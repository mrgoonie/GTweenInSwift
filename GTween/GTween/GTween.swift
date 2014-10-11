//
//  GTween.swift
//  GTween
//
//  Created by Goon Nguyen on 10/9/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import UIKit
import QuartzCore

let alpha = "alpha"
let x = "x"
let y = "y"
let scaleX = "scaleX"
let scaleY = "scaleY"
let width = "width"
let height = "height"
let ease = "ease"
let delay = "delay"
let onComplete = "onComplete"
let onUpdate = "onUpdate"
let onStart = "onStart"

struct GTween {
    //static var loop:CADisplayLink!
    static var tweenArr:[TweenObject] = []
    //var speed:Double = 0.5;
    
    static func to(target:AnyObject, time:Float, params:Dictionary<String, Any>, events:[String: ()->Void]=Dictionary()){
        var tween = TweenObject(_target: target, time: time, params:params, events:events)
        tweenArr += [tween]
    }
    
    /*static func from(target:AnyObject, dur:Float, params:Dictionary<String, AnyObject>){
        var tween = TweenObject(_target: target, time: dur, params:["x":100])
        tweenArr += [tween]
    }*/
}


class TweenObject:NSObject {
    var loop:CADisplayLink!
    
    /*var fromValue:Float!
    var toValue:Float!*/
    var changeValue:Float!
    
    var speed:Double = 1
    var target:AnyObject!
    var targetFrame:CGRect!
    var currentTime:Double = 0
    var totalTime:Double = 0
    var delayTime:Double = 0
    
    var repeat:Int = 0
    var repeatCount:Int = 0
    
    var _time:Float!
    
    var isPaused:Bool = false;
    var isStarted:Bool = false;
    var isYoyo:Bool = false;
    
    var inputParams:Dictionary<String, Any>!
    var tweenParams:[String: AnyObject]!
    
    var easeNumber:Float?
    var easeType:String = "Linear.easeNone" //default
    
    var linearMode:ModeLinear = ModeLinear()
    var backMode:ModeBack = ModeBack()
    var quintMode:ModeQuint = ModeQuint()
    var elasticMode:ModeElastic = ModeElastic()
    var bounceMode:ModeBounce = ModeBounce()
    var sineMode:ModeSine = ModeSine()
    var expoMode:ModeExpo = ModeExpo()
    var circMode:ModeCirc = ModeCirc()
    var cubicMode:ModeCubic = ModeCubic()
    var quartMode:ModeQuart = ModeQuart()
    var quadMode:ModeQuad = ModeQuad()
    
    typealias OnCompleteType = ()->Void
    
    var runOnComplete:(()->())?
    var runOnUpdate:(()->())?
    var runOnStart:(()->())?
    
    //tween values
    var toX:Float!
    var toY:Float!
    var toWidth:Float!
    var toHeight:Float!
    var toScaleX:Float!
    var toScaleY:Float!
    var toAlpha:Float!
    var originScaleX:Float!
    var originScaleY:Float!
    var originCenterX:Float!
    var originCenterY:Float!
    
    init(_target:AnyObject, time:Float, params:[String: Any], events:[String: ()->Void] = Dictionary()){
        target = _target
        _time = time;
        targetFrame = target.frame;
        inputParams = params;
        println(targetFrame)
        
        originCenterX = Float(target.center.x)
        originCenterY = Float(target.center.y)
        
        if var inputEase = params["ease"] as? String {
            easeType = String(inputEase)
        }
        
        if var delayInInt = params["delay"] as? Int {
            delayTime = Double(delayInInt)
        } else if let delayInDouble = params["delay"] as? Float {
            delayTime = Double(delayInDouble)
        } else if let delayInFloat = params["delay"] as? Double {
            delayTime = delayInFloat
        }
        
        runOnComplete  = events["onComplete"]
        runOnUpdate    = events["onUpdate"]
        runOnStart     = events["onStart"]
        
        if var xInInt = params["x"] as? Int {
            toX = Float(xInInt)
        } else if let xInDouble = params["x"] as? Double {
            toX = Float(xInDouble)
        } else if let xInFloat = params["x"] as? Float {
            toX = xInFloat
        } 
        
        if let yInInt = params["y"] as? Int {
            toY = Float(yInInt)
        } else if let yInDouble = params["y"] as? Double {
            toY = Float(yInDouble)
        } else if let yInFloat = params["y"] as? Float {
            toY = yInFloat
        }
        if let widthInInt = params["width"] as? Int {
            toWidth = Float(widthInInt)
        } else if let widthInDouble = params["width"] as? Double {
            toWidth = Float(widthInDouble)
        } else if let widthInFloat = params["width"] as? Float {
            toWidth = widthInFloat
        }
        
        if let heightInInt = params["height"] as? Int {
            toHeight = Float(heightInInt)
        } else if let heightInDouble = params["height"] as? Double {
            toHeight = Float(heightInDouble)
        } else if let heightInFloat = params["height"] as? Float {
            toHeight = heightInFloat
        }
        
        if let scaleXInInt = params["scaleX"] as? Int {
            toScaleX = Float(scaleXInInt)
        } else if let scaleXInDouble = params["scaleX"] as? Double {
            toScaleX = Float(scaleXInDouble)
        } else if let scaleXInFloat = params["scaleX"] as? Float {
            toScaleX = scaleXInFloat
        }
        
        if let scaleYInInt = params["scaleY"] as? Int {
            toScaleY = Float(scaleYInInt)
        } else if let scaleYInDouble = params["scaleY"] as? Double {
            toScaleY = Float(scaleYInDouble)
        } else if let scaleYInFloat = params["scaleY"] as? Float {
            toScaleY = scaleYInFloat
        }
        
        if let alphaInInt = params["alpha"] as? Int {
            toAlpha = Float(alphaInInt)
        } else if let alphaInDouble = params["alpha"] as? Double {
            toAlpha = Float(alphaInDouble)
        } else if let alphaInFloat = params["alpha"] as? Float {
            toAlpha = alphaInFloat
        }
        
        println("x:\(toX) y:\(toY) scaleX:\(toScaleX) scaleY:\(toScaleY) alpha:\(toAlpha)")
        
        super.init()
        
        originScaleX = self.xscale(target)
        originScaleY = self.yscale(target)
        
        setup()
    }
    
    func setup(){
        loop = CADisplayLink(target: self, selector: Selector("onLoop"))
        loop.frameInterval = 1
        loop.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func onLoop(){
        //println("\(currentTime)")
        if ((currentTime >= delayTime && speed > 0) || (speed < 0))// && _currentTime <= _totalTime))
        {
            //var value;
            var time = Float((currentTime - delayTime) / Double(_time));
            //make this nicer!
            time = fminf(1.0, fmaxf(0.0, time));
            
            //=============================================
            //        UPDATE VALUES
            //=============================================
            
            easeNumber = getEaseNumber(easeType, time: time)
            
            var newX:Float!
            var newY:Float!
            var newW:Float!
            var newH:Float!
            var newAlpha:Float!
            var newScaleX:Float!
            var newScaleY:Float!
            
            if toX != nil {
                newX = getNewValue(toX, fromValue: Float(targetFrame.origin.x), ease: easeNumber!)
            } else {
                newX = Float(targetFrame.origin.x)
            }
            
            if toY != nil {
                newY = getNewValue(toY, fromValue: Float(targetFrame.origin.y), ease: easeNumber!)
            } else {
                newY = Float(targetFrame.origin.y)
            }
            
            if toWidth != nil {
                newW = getNewValue(toWidth, fromValue: Float(targetFrame.size.width), ease: easeNumber!)
            } else {
                newW = Float(targetFrame.size.width)
            }
            
            if toHeight != nil {
                newH = getNewValue(toHeight, fromValue: Float(targetFrame.size.height), ease: easeNumber!)
            } else {
                newH = Float(targetFrame.size.height)
            }
            
            if toScaleX != nil {
                newScaleX = getNewValue(toScaleX, fromValue: originScaleX, ease: easeNumber!)
            } else {
                newScaleX = xscale(target)
            }
            
            if toScaleY != nil {
                newScaleY = getNewValue(toScaleY, fromValue: originScaleY, ease: easeNumber!)
            } else {
                newScaleY = yscale(target)
            }
            
            var newTransform = CGAffineTransformMakeScale(CGFloat(newScaleX), CGFloat(newScaleY))
            
            var newFrame = target.frame
            newFrame.origin.x = CGFloat(newX)
            newFrame.origin.y = CGFloat(newY)
            
            var newCenter = target.center
            newCenter.x = CGFloat(newX)
            newCenter.y = CGFloat(newY)
            
            if(toScaleX == nil) {
                newFrame.size.width = CGFloat(newW)
            }
            
            if(toScaleY == nil) {
                newFrame.size.height = CGFloat(newH)
            }
            
            if((target as? UIView) != nil){
                var newTarget = (target as UIView)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UILabel) != nil){
                var newTarget = (target as UILabel)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UIImageView) != nil){
                var newTarget = (target as UIImageView)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UIButton) != nil){
                var newTarget = (target as UIButton)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UICollectionView) != nil){
                var newTarget = (target as UICollectionView)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UITextView) != nil){
                var newTarget = (target as UITextView)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UIScrollView) != nil){
                var newTarget = (target as UIScrollView)
                
                if(toScaleX != nil || toScaleY != nil) {
                    newTarget.transform = newTransform
                    newFrame = newTarget.frame
                    if(toX != nil){ newFrame.origin.x = CGFloat(newX) }
                    if(toY != nil){ newFrame.origin.y = CGFloat(newY) }
                    newTarget.frame = newFrame
                } else {
                    newTarget.frame = newFrame
                }
            } else if((target as? UIPickerView) != nil){
                (target as UIPickerView).frame = newFrame
            } else if((target as? UIWebView) != nil){
                (target as UIWebView).frame = newFrame
            } else if((target as? UIToolbar) != nil){
                (target as UIToolbar).frame = newFrame
            } else if((target as? UISwitch) != nil){
                (target as UISwitch).frame = newFrame
            } else if((target as? UIActivityIndicatorView) != nil){
                (target as UIActivityIndicatorView).frame = newFrame
            } else if((target as? UIProgressView) != nil){
                (target as UIProgressView).frame = newFrame
            } else if((target as? UIPageControl) != nil){
                (target as UIPageControl).frame = newFrame
            } else if((target as? UIStepper) != nil){
                (target as UIStepper).frame = newFrame
            }
            
            if toAlpha != nil {
                newAlpha = getNewValue(toAlpha, fromValue: Float(target.layer.opacity), ease: easeNumber!)
                target.layer.opacity = newAlpha
            } else {
                newAlpha = Float(target.layer.opacity)
            }
            
            
            //=============================================
            
            if(runOnStart != nil && !isStarted){
                runOnStart?()
                isStarted = true
            }
            
            if (runOnUpdate != nil) {
                runOnUpdate?()
            }
            
            if (time == 1.0)
            {
                if (!isYoyo)
                {
                    if (repeat == 0 || repeatCount == repeat)
                    {
                        self.stop()
                    }
                    else
                    {
                        currentTime = 0.0;
                        repeatCount++;
                    }
                }
                else
                {
                    currentTime = totalTime;
                    speed = speed * -1;
                }
            }
            else if (time == 0 && speed < 0)
            {
                if (repeat == 0 || repeatCount == repeat)
                {
                    self.stop()
                }
                else
                {
                    currentTime = 0.0;
                    speed = speed * -1;
                    repeatCount++;
                }
            }
        }
        
        currentTime += loop.duration * speed;
    }
    
    func xscale(item:AnyObject)->Float {
        var t:CGAffineTransform!
        if item is UIView {
            t = (item as UIView).transform;
        }
        if item is UILabel {
            t = (item as UILabel).transform;
        }
        if item is UIImageView {
            t = (item as UIImageView).transform;
        }
        if item is UIButton {
            t = (item as UIButton).transform;
        }
        if item is UITextView {
            t = (item as UITextView).transform;
        }
        if item is UIScrollView {
            t = (item as UIScrollView).transform;
        }
        if item is UICollectionView {
            t = (item as UICollectionView).transform;
        }
        
        return Float(sqrt(t.a * t.a + t.c * t.c));
    }
    
    func yscale(item:AnyObject)->Float {
        var t:CGAffineTransform!
        if item is UIView {
            t = (item as UIView).transform;
        }
        if item is UILabel {
            t = (item as UILabel).transform;
        }
        if item is UIImageView {
            t = (item as UIImageView).transform;
        }
        if item is UIButton {
            t = (item as UIButton).transform;
        }
        if item is UITextView {
            t = (item as UITextView).transform;
        }
        if item is UIScrollView {
            t = (item as UIScrollView).transform;
        }
        if item is UICollectionView {
            t = (item as UICollectionView).transform;
        }
        return Float(sqrt(t.b * t.b + t.d * t.d));
    }
    
    func getEaseNumber(type:String, time:Float)->Float {
        var result:Float;
        
        switch(type){
            
        case Back.easeOut:
            backMode.time = time
            result = backMode.easeOutNumber
            break
            
        case Back.easeIn:
            backMode.time = time
            result = backMode.easeInNumber
            break
            
        case Back.easeInOut:
            backMode.time = time
            result = backMode.easeInOutNumber
            break
        
        case Elastic.easeOut:
            elasticMode.time = time
            result = elasticMode.easeOutNumber
            break
            
        case Elastic.easeIn:
            elasticMode.time = time
            result = elasticMode.easeInNumber
            break
            
        case Elastic.easeInOut:
            elasticMode.time = time
            result = elasticMode.easeInOutNumber
            break
            
        case Bounce.easeOut:
            bounceMode.time = time
            result = bounceMode.easeOutNumber
            break
            
        case Bounce.easeIn:
            bounceMode.time = time
            result = bounceMode.easeInNumber
            break
            
        case Bounce.easeInOut:
            bounceMode.time = time
            result = bounceMode.easeInOutNumber
            break
            
        case Sine.easeOut:
            sineMode.time = time
            result = sineMode.easeOutNumber
            break
            
        case Sine.easeIn:
            sineMode.time = time
            result = sineMode.easeInNumber
            break
            
        case Sine.easeInOut:
            sineMode.time = time
            result = sineMode.easeInOutNumber
            break
           
        case Expo.easeOut:
            expoMode.time = time
            result = expoMode.easeOutNumber
            break
            
        case Expo.easeIn:
            expoMode.time = time
            result = expoMode.easeInNumber
            break
            
        case Expo.easeInOut:
            expoMode.time = time
            result = expoMode.easeInOutNumber
            break
            
        case Circ.easeOut:
            circMode.time = time
            result = circMode.easeOutNumber
            break
            
        case Circ.easeIn:
            circMode.time = time
            result = circMode.easeInNumber
            break
            
        case Circ.easeInOut:
            circMode.time = time
            result = circMode.easeInOutNumber
            break
            
        case Cubic.easeOut:
            cubicMode.time = time
            result = cubicMode.easeOutNumber
            break
            
        case Cubic.easeIn:
            cubicMode.time = time
            result = cubicMode.easeInNumber
            break
            
        case Cubic.easeInOut:
            cubicMode.time = time
            result = cubicMode.easeInOutNumber
            break
            
        case Quad.easeOut:
            quadMode.time = time
            result = quadMode.easeOutNumber
            break
            
        case Quad.easeIn:
            quadMode.time = time
            result = quadMode.easeInNumber
            break
            
        case Quad.easeInOut:
            quadMode.time = time
            result = quadMode.easeInOutNumber
            break
            
        case Quart.easeOut:
            quartMode.time = time
            result = quartMode.easeOutNumber
            break
        
        case Quart.easeIn:
            quartMode.time = time
            result = quartMode.easeInNumber
            break
            
        case Quart.easeInOut:
            quartMode.time = time
            result = quartMode.easeInOutNumber
            break
            
        case Quint.easeOut:
            quintMode.time = time
            result = quintMode.easeOutNumber
            break
            
        case Quint.easeIn:
            quintMode.time = time
            result = quintMode.easeInNumber
            break
            
        case Quint.easeInOut:
            quintMode.time = time
            result = quintMode.easeInOutNumber
            break
            
        default:
            linearMode.time = time
            result = linearMode.easeNoneNumber
            break
        }
        
        return result
    }
    
    func getNewValue(toValue:Float, fromValue:Float, ease:Float)->Float {
        changeValue = toValue - fromValue
        var value = fromValue + changeValue * ease;
        return value
    }
    
    func start(){
        setup()
    }
    
    func pause(){
        if(!isPaused){
            loop.invalidate()
            isPaused = true;
        }
    }
    
    func resume(){
        if(isPaused){
            setup()
            isPaused = false;
        }
    }
    
    func stop(){
        //testOnComplete?()
        runOnComplete?()
        loop.invalidate()
    }
}



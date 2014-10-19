//
//  TweenConstraint.swift
//  Numberize
//
//  Created by Nguyen Goon on 10/19/14.
//  Copyright (c) 2014 Nguyen Goon. All rights reserved.
//

import Foundation
import UIKit

class TweenConstraint:NSObject {
    var loop:CADisplayLink!
    
    //tween values
    var fromValue:CGFloat!
    var toValue:CGFloat!
    var changeValue:CGFloat!
    
    var speed:Double = 1
    var target:NSLayoutConstraint!
    var curViewController:UIViewController!
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
    
    /*var linearMode:ModeLinear = ModeLinear()
    var backMode:ModeBack = ModeBack()
    var quintMode:ModeQuint = ModeQuint()
    var elasticMode:ModeElastic = ModeElastic()
    var bounceMode:ModeBounce = ModeBounce()
    var sineMode:ModeSine = ModeSine()
    var expoMode:ModeExpo = ModeExpo()
    var circMode:ModeCirc = ModeCirc()
    var cubicMode:ModeCubic = ModeCubic()
    var quartMode:ModeQuart = ModeQuart()
    var quadMode:ModeQuad = ModeQuad()*/
    
    var runOnComplete:(()->())?
    var runOnUpdate:(()->())?
    var runOnStart:(()->())?
    
    init(viewController:UIViewController, _target:AnyObject, time:Float, params:[String: Any], events:[String: ()->Void] = Dictionary()){
        target = _target as NSLayoutConstraint
        curViewController = viewController
        _time = time
        
        fromValue = target.constant
        
        if let rotationInInt = params["constant"] as? Int {
            toValue = CGFloat(rotationInInt)
        } else if let rotationInDouble = params["constant"] as? Double {
            toValue = CGFloat(rotationInDouble)
        } else if let rotationInFloat = params["constant"] as? Float {
            toValue = CGFloat(rotationInFloat)
        } else if let rotationInCGFloat = params["constant"] as? CGFloat {
            toValue = rotationInCGFloat
        }
        
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
        
        super.init()
        
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
            
            easeNumber = Ease.getEaseNumber(easeType, time: time)
            
            var newValue:CGFloat!
            
            if toValue != nil {
                newValue = getNewValue(toValue, fromValue: fromValue, ease: easeNumber!)
            } else {
                newValue = target.constant
            }
            
            target.constant = newValue
            curViewController.view.layoutIfNeeded()
            
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
    
    func getNewValue(toValue:CGFloat, fromValue:CGFloat, ease:Float)->CGFloat {
        changeValue = toValue - fromValue
        var value = fromValue + changeValue * CGFloat(ease);
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
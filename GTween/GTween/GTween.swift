//
//  GTween.swift
//  GTween
//
//  Created by Goon Nguyen on 10/9/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import UIKit
import QuartzCore



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
    
    var fromValue:Float!
    var toValue:Float!
    var changeValue:Float!
    
    var speed:Double = 1
    var target:AnyObject!
    var targetFrame:CGRect!
    var currentTime:Double = 0
    var totalTime:Double = 0
    var delay:Double = 0
    
    var repeat:Int = 0
    var repeatCount:Int = 0
    
    var _time:Float!
    
    var isPaused:Bool = false;
    var isStarted:Bool = false;
    var isYoyo:Bool = false;
    
    var inputParams:Dictionary<String, Any>!
    var tweenParams:[String: AnyObject]!
    
    var ease:Float?
    //var easeType:AnyClass!
    
    typealias OnCompleteType = ()->Void
    
    var runOnComplete:(()->())?
    var runOnUpdate:(()->())?
    var runOnStart:(()->())?
    
    init(_target:AnyObject, time:Float, params:[String: Any], events:[String: ()->Void] = Dictionary()){
        target = _target
        _time = time;
        targetFrame = target.frame;
        inputParams = params;
        
        runOnComplete  = events["onComplete"]
        runOnUpdate    = events["onUpdate"]
        runOnStart     = events["onStart"]
        
        var x:Float!
        var y:Float!
        var width:Float!
        var height:Float!
        var scaleX:Float!
        var scaleY:Float!
        var alpha:Float!
        
        if var xInInt = params["x"] as? Int {
            x = Float(xInInt)
        } else if let xInDouble = params["x"] as? Double {
            x = Float(xInDouble)
        } else if let xInFloat = params["x"] as? Float {
            x = xInFloat
        }
        
        if let yInInt = params["y"] as? Int {
            y = Float(yInInt)
        } else if let yInDouble = params["y"] as? Double {
            y = Float(yInDouble)
        } else if let yInFloat = params["y"] as? Float {
            y = yInFloat
        }
        
        if let widthInInt = params["width"] as? Int {
            width = Float(widthInInt)
        } else if let widthInDouble = params["width"] as? Double {
            width = Float(widthInDouble)
        } else if let widthInFloat = params["width"] as? Float {
            width = widthInFloat
        }
        
        if let heightInInt = params["height"] as? Int {
            height = Float(heightInInt)
        } else if let heightInDouble = params["height"] as? Double {
            height = Float(heightInDouble)
        } else if let heightInFloat = params["height"] as? Float {
            height = heightInFloat
        }
        
        if let scaleXInInt = params["scaleX"] as? Int {
            scaleX = Float(scaleXInInt)
        } else if let scaleXInDouble = params["scaleX"] as? Double {
            scaleX = Float(scaleXInDouble)
        } else if let scaleXInFloat = params["scaleX"] as? Float {
            scaleX = scaleXInFloat
        }
        
        if let scaleYInInt = params["scaleY"] as? Int {
            scaleY = Float(scaleYInInt)
        } else if let scaleYInDouble = params["scaleY"] as? Double {
            scaleY = Float(scaleYInDouble)
        } else if let scaleYInFloat = params["scaleY"] as? Float {
            scaleY = scaleYInFloat
        }
        
        if let alphaInInt = params["alpha"] as? Int {
            alpha = Float(alphaInInt)
        } else if let alphaInDouble = params["alpha"] as? Double {
            alpha = Float(alphaInDouble)
        } else if let alphaInFloat = params["alpha"] as? Float {
            alpha = alphaInFloat
        }
        
        println("x:\(x) y:\(y) scaleX:\(scaleX) scaleY:\(scaleY) alpha:\(alpha)")
        
        super.init()
        
        setup()
    }
    
    func setup(){
        loop = CADisplayLink(target: self, selector: Selector("onLoop"))
        loop.frameInterval = 1
        loop.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func onLoop(){
        println("\(currentTime)")
        if ((currentTime >= delay && speed > 0) || (speed < 0))// && _currentTime <= _totalTime))
        {
            //var value;
            var time = Float((currentTime - delay) / Double(_time));
            //make this nicer!
            time = fminf(1.0, fmaxf(0.0, time));
            
            //=============================================
            
            //Linear.time = time
            
            //changeValue = toValue - fromValue
            //var value = fromValue + changeValue * Linear.easeNone;
            
            //=============================================
            
            /*[_values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                {
                [(GSTweenData*)obj updateWithValue:value];
                }];*/
            
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



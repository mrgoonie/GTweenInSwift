//
//  SetObject.swift
//  GTween
//
//  Created by Goon Nguyen on 10/13/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import UIKit

class SetObject: NSObject {
    
    var target:AnyObject!
    
    var originFrame:CGRect!
    var setFrame:CGRect!
    
    var delayTime:Double = 0
    
    var toX:Float!
    var toY:Float!
    var toWidth:Float!
    var toHeight:Float!
    var toScaleX:Float!
    var toScaleY:Float!
    var toAlpha:Float!
    var toRotation:Float!
    var originScaleX:Float!
    var originScaleY:Float!
    var originCenterX:Float!
    var originCenterY:Float!
    var originRotation:Float!
    
    init(_target:AnyObject, params:[String: Any]){
        target = _target
        
        originFrame = target.frame
        setFrame = target.frame
        
        if var delayInInt = params["delay"] as? Int {
            delayTime = Double(delayInInt)
        } else if let delayInDouble = params["delay"] as? Float {
            delayTime = Double(delayInDouble)
        } else if let delayInFloat = params["delay"] as? Double {
            delayTime = delayInFloat
        }
        
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
        } else {
            toScaleX = xscale(target)
        }
        
        if let scaleYInInt = params["scaleY"] as? Int {
            toScaleY = Float(scaleYInInt)
        } else if let scaleYInDouble = params["scaleY"] as? Double {
            toScaleY = Float(scaleYInDouble)
        } else if let scaleYInFloat = params["scaleY"] as? Float {
            toScaleY = scaleYInFloat
        } else {
            toScaleY = yscale(target)
        }
        
        if let alphaInInt = params["alpha"] as? Int {
            toAlpha = Float(alphaInInt)
        } else if let alphaInDouble = params["alpha"] as? Double {
            toAlpha = Float(alphaInDouble)
        } else if let alphaInFloat = params["alpha"] as? Float {
            toAlpha = alphaInFloat
        }
        
        if let rotationInInt = params["rotation"] as? Int {
            toRotation = Float(rotationInInt)
        } else if let rotationInDouble = params["rotation"] as? Double {
            toRotation = Float(rotationInDouble)
        } else if let rotationInFloat = params["rotation"] as? Float {
            toRotation = rotationInFloat
        } else {
            toRotation = getrotation(target)
        }
        
        //println("x:\(toX) y:\(toY) scaleX:\(toScaleX) scaleY:\(toScaleY) alpha:\(toAlpha)")
        
        super.init()
        
        originScaleX = xscale(target)
        originScaleY = yscale(target)
        originRotation = getrotation(target) * Float(180 / M_PI)
        
        if(delayTime > 0){
            //NSTimer.performSelector("set", withObject: self, afterDelay: delayTime)
            var timer = NSTimer.scheduledTimerWithTimeInterval(delayTime, target: self, selector:  Selector("set"), userInfo: nil, repeats: false)
        } else {
            set()
        }
    }
    
    func set(){
        
        var scaleTransform = CGAffineTransformMakeScale(CGFloat(toScaleX), CGFloat(toScaleY))
        var rotateTransform = CGAffineTransformMakeRotation(CGFloat(Double(toRotation)/180.0*M_PI))
        var newTransform = CGAffineTransformConcat(scaleTransform, rotateTransform)
        
        if((target as? UIView) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UILabel) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UIImageView) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UIImageView) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UIButton) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UITextView) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        } else if((target as? UIScrollView) != nil){
            var newTarget = (target as UIView)
            newTarget.transform = newTransform
            
            setFrame = newTarget.frame
            
            if(toAlpha != nil){
                target.layer.opacity = toAlpha
            }
            
            if(toX != nil){
                setFrame.origin.x = CGFloat(toX)
            }
            
            if(toY != nil){
                setFrame.origin.y = CGFloat(toY)
            }
            
            if(toScaleX != nil || toScaleY != nil || toRotation != nil){
                if(toWidth != nil){
                    setFrame.size.width = CGFloat(toWidth)
                }
                
                if(toHeight != nil){
                    setFrame.size.height = CGFloat(toHeight)
                }
            }
            
            newTarget.frame = setFrame
        }
        
        
    }
}

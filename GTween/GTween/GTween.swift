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
    static var tweenArr:[TweenObject] = []
    
    static var linearMode:ModeLinear = ModeLinear()
    static var backMode:ModeBack = ModeBack()
    static var quintMode:ModeQuint = ModeQuint()
    static var elasticMode:ModeElastic = ModeElastic()
    static var bounceMode:ModeBounce = ModeBounce()
    static var sineMode:ModeSine = ModeSine()
    static var expoMode:ModeExpo = ModeExpo()
    static var circMode:ModeCirc = ModeCirc()
    static var cubicMode:ModeCubic = ModeCubic()
    static var quartMode:ModeQuart = ModeQuart()
    static var quadMode:ModeQuad = ModeQuad()
    
    static func set(target:AnyObject, params:Dictionary<String, Any>){
        var set = SetObject(_target: target, params:params)
    }
    
    static func to(target:AnyObject,
        time:Float,
        params:Dictionary<String, Any>,
        events:[String: ()->Void]=Dictionary())
    {
        var tween = TweenObject(_target: target, time: time, params:params, events:events)
        tweenArr += [tween]
    }
    
    static func constraintTo(viewController:UIViewController,
        constraint:AnyObject,
        time:Float,
        params:Dictionary<String, Any>,
        events:[String: ()->Void]=Dictionary())
    {
        var tween = TweenConstraint(viewController: viewController, _target:constraint, time: time, params: params, events: events)
        //tweenArr += [tween]
    }
    
    /*static func from(target:AnyObject, dur:Float, params:Dictionary<String, AnyObject>){
        var tween = TweenObject(_target: target, time: dur, params:["x":100])
        tweenArr += [tween]
    }*/
}








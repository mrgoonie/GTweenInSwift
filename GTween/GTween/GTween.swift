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
    
    static func set(target:AnyObject, params:Dictionary<String, Any>){
        var set = SetObject(_target: target, params:params)
    }
    
    static func to(target:AnyObject, time:Float, params:Dictionary<String, Any>, events:[String: ()->Void]=Dictionary()){
        var tween = TweenObject(_target: target, time: time, params:params, events:events)
        tweenArr += [tween]
    }
    
    /*static func from(target:AnyObject, dur:Float, params:Dictionary<String, AnyObject>){
        var tween = TweenObject(_target: target, time: dur, params:["x":100])
        tweenArr += [tween]
    }*/
}








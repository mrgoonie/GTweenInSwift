//
//  Ease.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Ease {
    /*static var Linear:String    = "Linear"
    static var Back:String      = "Back"
    static var Elastic:String   = "Elastic"
    static var Quint:String     = "Quint"
    static var Sine:String      = "Sine"
    static var Bounce:String    = "Bounce"
    static var Expo:String      = "Expo"
    static var Circ:String      = "Circ"
    static var Cubic:String     = "Cubic"
    static var Quad:String      = "Quad"
    static var Quart:String     = "Quart"*/
    
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
    
    static func getEaseNumber(type:String, time:Float)->Float {
        var result:Float;
        
        switch(type){
            
        case Back.easeOut:
            Ease.backMode.time = time
            result = Ease.backMode.easeOutNumber
            break
            
        case Back.easeIn:
            Ease.backMode.time = time
            result = Ease.backMode.easeInNumber
            break
            
        case Back.easeInOut:
            Ease.backMode.time = time
            result = Ease.backMode.easeInOutNumber
            break
            
        case Elastic.easeOut:
            Ease.elasticMode.time = time
            result = Ease.elasticMode.easeOutNumber
            break
            
        case Elastic.easeIn:
            Ease.elasticMode.time = time
            result = Ease.elasticMode.easeInNumber
            break
            
        case Elastic.easeInOut:
            Ease.elasticMode.time = time
            result = Ease.elasticMode.easeInOutNumber
            break
            
        case Bounce.easeOut:
            Ease.bounceMode.time = time
            result = Ease.bounceMode.easeOutNumber
            break
            
        case Bounce.easeIn:
            Ease.bounceMode.time = time
            result = Ease.bounceMode.easeInNumber
            break
            
        case Bounce.easeInOut:
            Ease.bounceMode.time = time
            result = Ease.bounceMode.easeInOutNumber
            break
            
        case Sine.easeOut:
            Ease.sineMode.time = time
            result = Ease.sineMode.easeOutNumber
            break
            
        case Sine.easeIn:
            Ease.sineMode.time = time
            result = Ease.sineMode.easeInNumber
            break
            
        case Sine.easeInOut:
            Ease.sineMode.time = time
            result = Ease.sineMode.easeInOutNumber
            break
            
        case Expo.easeOut:
            Ease.expoMode.time = time
            result = Ease.expoMode.easeOutNumber
            break
            
        case Expo.easeIn:
            Ease.expoMode.time = time
            result = Ease.expoMode.easeInNumber
            break
            
        case Expo.easeInOut:
            Ease.expoMode.time = time
            result = Ease.expoMode.easeInOutNumber
            break
            
        case Circ.easeOut:
            Ease.circMode.time = time
            result = Ease.circMode.easeOutNumber
            break
            
        case Circ.easeIn:
            Ease.circMode.time = time
            result = Ease.circMode.easeInNumber
            break
            
        case Circ.easeInOut:
            Ease.circMode.time = time
            result = Ease.circMode.easeInOutNumber
            break
            
        case Cubic.easeOut:
            Ease.cubicMode.time = time
            result = Ease.cubicMode.easeOutNumber
            break
            
        case Cubic.easeIn:
            Ease.cubicMode.time = time
            result = Ease.cubicMode.easeInNumber
            break
            
        case Cubic.easeInOut:
            Ease.cubicMode.time = time
            result = Ease.cubicMode.easeInOutNumber
            break
            
        case Quad.easeOut:
            Ease.quadMode.time = time
            result = Ease.quadMode.easeOutNumber
            break
            
        case Quad.easeIn:
            Ease.quadMode.time = time
            result = Ease.quadMode.easeInNumber
            break
            
        case Quad.easeInOut:
            Ease.quadMode.time = time
            result = Ease.quadMode.easeInOutNumber
            break
            
        case Quart.easeOut:
            Ease.quartMode.time = time
            result = Ease.quartMode.easeOutNumber
            break
            
        case Quart.easeIn:
            Ease.quartMode.time = time
            result = Ease.quartMode.easeInNumber
            break
            
        case Quart.easeInOut:
            Ease.quartMode.time = time
            result = Ease.quartMode.easeInOutNumber
            break
            
        case Quint.easeOut:
            Ease.quintMode.time = time
            result = Ease.quintMode.easeOutNumber
            break
            
        case Quint.easeIn:
            Ease.quintMode.time = time
            result = Ease.quintMode.easeInNumber
            break
            
        case Quint.easeInOut:
            Ease.quintMode.time = time
            result = Ease.quintMode.easeInOutNumber
            break
            
        default:
            Ease.linearMode.time = time
            result = Ease.linearMode.easeNoneNumber
            break
        }
        
        return result
    }
}
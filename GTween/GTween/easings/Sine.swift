//
//  Sine.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Sine {
    
    static var easeIn:String { return Ease.Sine + ".easeIn" }
    static var easeOut:String { return Ease.Sine + ".easeOut" }
    static var easeInOut:String { return Ease.Sine + ".easeInOut" }
    
}

class ModeSine {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        var t = cos(Double(time) * M_PI_2)
        return Float(1.0 - t);
    }
    
    var easeOutNumber:Float {
        return Float(sin(Double(time) * M_PI_2));
    }
    
    var easeInOutNumber:Float {
        return -0.5 * Float((cos(M_PI * Double(time)) - 1.0));
    }
}
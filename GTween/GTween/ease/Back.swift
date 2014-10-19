//
//  Back.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Back {
    
    static var easeIn:String { return "Back.easeIn" }
    static var easeOut:String { return "Back.easeOut" }
    static var easeInOut:String { return "Back.easeInOut" }
    
}

class ModeBack {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        return time * time * ((_sValue + 1) * time - _sValue);
    }
    
    var easeOutNumber:Float {
        time = time - 1;
        return time * time * ((_sValue + 1) * time + _sValue) + 1;
    }
    
    var easeInOutNumber:Float {
        //println("easeInOut")
        time = time * 2;
        var s = _sValue * 1.525;
        if (time < 1){
            return 0.5 * (time * time * ((s + 1) * time - s));
        } else {
            time = time - 2;
            return 0.5 * (time * time * ((s + 1) * time + s) + 2);
        }
    }
}
//
//  Circ.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Circ {
    
    static var easeIn:String { return Ease.Circ + ".easeIn" }
    static var easeOut:String { return Ease.Circ + ".easeOut" }
    static var easeInOut:String { return Ease.Circ + ".easeInOut" }
    
}

class ModeCirc {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        return -(sqrt(1.0 - time * time) - 1.0);
    }
    
    var easeOutNumber:Float {
        time = time - 1.0;
            return sqrt(1.0 - time * time);
    }
    
    var easeInOutNumber:Float {
        time = time * 2.0;
        if (time < 1.0){
            return -0.5 * (sqrt(1.0 - time * time) - 1.0);
        }
        
        time = time - 2.0;
        return 0.5 * (sqrt(1.0 - time * time) + 1.0);
    }
}

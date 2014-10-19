//
//  Quad.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Quad {
    
    static var easeIn:String { return "Quad.easeIn" }
    static var easeOut:String { return "Quad.easeOut" }
    static var easeInOut:String { return "Quad.easeInOut" }
    
}

class ModeQuad {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        return time * time;
    }
    
    var easeOutNumber:Float {
        return -time * (time - 2.0);
    }
    
    var easeInOutNumber:Float {
        time = time * 2.0;
        if (time < 1.0){
            return 0.5 * time * time;
        }
        
        time = time - 1;
        return -0.5 * (time * (time - 2.0) - 1.0);
    }
}


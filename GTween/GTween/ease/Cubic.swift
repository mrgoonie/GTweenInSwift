//
//  Cubic.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Cubic {
    
    static var easeIn:String { return "Cubic.easeIn" }
    static var easeOut:String { return "Cubic.easeOut" }
    static var easeInOut:String { return "Cubic.easeInOut" }
    
}

class ModeCubic {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        return time * time * time;
    }
    
    var easeOutNumber:Float {
        time = time - 1.0;
            return time * time * time + 1.0;

    }
    
    var easeInOutNumber:Float {
        time = time * 2.0;
        if (time < 1.0){
            return 0.5 * time * time * time;
        }
        
        time = time - 2.0;
        return 0.5 * (time * time * time + 2.0);
    }
}

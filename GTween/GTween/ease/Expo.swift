//
//  Expo.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Expo {
    
    static var easeIn:String { return "Expo.easeIn" }
    static var easeOut:String { return "Expo.easeOut" }
    static var easeInOut:String { return "Expo.easeInOut" }
    
}

class ModeExpo {
    var time:Float!
    var _sValue:Float = 1.70158;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        return time == 0.0 ? 0.0 : pow(2, 10 * (time - 1));
    }
    
    var easeOutNumber:Float {
        return time == 1.0 ? 1.0 : -pow(2, -10.0 * time) + 1.0;
    }
    
    var easeInOutNumber:Float {
        if (time == 0.0){
            return 0.0;
        }
        if (time >= 1.0){
            return 1.0;
        }
        
        time = time * 2.0;
        if (time < 1.0){
            return 0.5 * pow(2, 10.0 * (time - 1));
        }
        
        time = time-1
        
        return 0.5 * (-pow(2, -10.0 * time) + 2.0);
    }
}

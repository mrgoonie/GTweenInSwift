//
//  Bounce.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Bounce {
    static var easeIn:String { return Ease.Bounce + ".easeIn" }
    static var easeOut:String { return Ease.Bounce + ".easeOut" }
    static var easeInOut:String { return Ease.Bounce + ".easeInOut" }
}

class ModeBounce {
    var time:Float!
    
    var _pValue = 0.3;
    var _sValue = 0.3 / 4.0;
    var _aValue = 1.0;
    
    init(){
        
    }
    
    var easeInNumber:Float {
        time = 1 - time
        return 1.0 - self.easeOutNumber;
    }
    
    var easeOutNumber:Float {
        if (time < 1.0 / 2.75)
        {
            return (7.5625 * time * time);
        }
        else if (time < 2.0 / 2.75)
        {
            time = time - (1.5 / 2.75)
            var postfix = time
            return 7.5625 * postfix * time + 0.75;
        }
        else if (time < 2.5 / 2.75)
        {
            time = time - (2.25 / 2.75)
            var postfix = time;
            return 7.5625 * postfix * time + 0.9375;
        }
        else
        {
            time = time - (2.625 / 2.75)
            var postfix = time;
            return 7.5625 * postfix * time + 0.984375;
            }
    }
    
    var easeInOutNumber:Float {
        //println("easeInOut")
        time = time * 2.0;
        if (time < 1.0){
            time = 1 - time
            var t = self.easeOutWithTime(1.0)
            return (1.0 - t * 0.5)
        } else {
            time = time - 1
            var result = self.easeOutWithTime(1.0)
            return result * 0.5 + 0.5;
        }
    }
    
    func easeOutWithTime(duration:Float)->Float
    {
        time = time / duration;
        if (time < 1.0 / 2.75)
        {
            return (7.5625 * time * time);
        }
        else if (time < 2.0 / 2.75)
        {
            time = time - (1.5 / 2.75)
            return 7.5625 * time * time + 0.75;
        }
        else if (time < 2.5 / 2.75)
        {
            time = time - (2.25 / 2.75)
            return 7.5625 * time * time + 0.9375;
        }
        else
        {
            time = time - (2.625 / 2.75);
            return 7.5625 * time * time + 0.984375;
        }
    }
}
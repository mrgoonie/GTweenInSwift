//
//  Elastic.swift
//  GTween
//
//  Created by Goon Nguyen on 10/10/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Elastic {
    static var easeIn:String { return Ease.Elastic + ".easeIn" }
    static var easeOut:String { return Ease.Elastic + ".easeOut" }
    static var easeInOut:String { return Ease.Elastic + ".easeInOut" }
}

class ModeElastic {
    var time:Float!
    
    var _pValue = 0.3;
    var _sValue = 0.3 / 4.0;
    var _aValue = 1.0;
    
    init(){
        
    }
    
    var easeInNumber:Float {
            if (time == 0.0){
                return 0.0;
            }
            if (time == 1.0){
                return 1.0;
            }
            time = time - 1
            
            var postfix = pow(2.0, Double(10.0 * time));
            var result = postfix * sin((Double(time) - _sValue) * (M_PI * 2) / _pValue)
            result = -result
                
            return Float(result);
        }
    
    var easeOutNumber:Float {
            if (time == 0.0){
                return 0.0;
            }
            if (time == 1.0){
                return 1.0;
            }
            
            var result = pow(2.0, (-10.0 * Double(time))) * sin( (Double(time) - _sValue) * (M_PI * 2) / _pValue ) + 1.0;
                
            return Float(result)
        }
    
    var easeInOutNumber:Float {
        //println("easeInOut")
        if (time == 0.0){
            return 0.0;
        }
        if (time >= 1.0){
            return 1.0;
        }
            
            time = time * 2.0;
            if (time < 1)
            {
                time = time - 1
                var postfix = pow(2.0, Double(10.0 * time));
                var t = postfix * sin((Double(time) - _sValue) * (M_PI * 2) / _pValue)
                var result = 0.5 * t
                result = -result
                return Float(result);
            }
            time = time - 1
            var postfix = pow(2.0, -10.0 * Double(time));
            var result = postfix * sin((Double(time) - _sValue) * (M_PI * 2) / _pValue) * 0.5 + 1.0;
            return Float(result)
    }
}
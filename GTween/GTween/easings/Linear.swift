//
//  Linear.swift
//  GTween
//
//  Created by Goon Nguyen on 10/9/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation

struct Linear {
    
    static var time:Float!
    
    static var easeNone:Float {
        return fminf(1.0, fmaxf(0.0, time));
    }
}
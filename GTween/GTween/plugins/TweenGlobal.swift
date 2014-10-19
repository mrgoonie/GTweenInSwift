//
//  TweenGlobal.swift
//  GTween
//
//  Created by Goon Nguyen on 10/13/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import Foundation
import UIKit

let alpha = "alpha"
let x = "x"
let y = "y"
let scaleX = "scaleX"
let scaleY = "scaleY"
let width = "width"
let height = "height"
let rotation = "rotation"
let ease = "ease"
let delay = "delay"

func xscale(item:AnyObject)->Float {
    var t:CGAffineTransform!
    if item is UIView {
        t = (item as UIView).transform;
    }
    if item is UILabel {
        t = (item as UILabel).transform;
    }
    if item is UIImageView {
        t = (item as UIImageView).transform;
    }
    if item is UIButton {
        t = (item as UIButton).transform;
    }
    if item is UITextView {
        t = (item as UITextView).transform;
    }
    if item is UIScrollView {
        t = (item as UIScrollView).transform;
    }
    if item is UICollectionView {
        t = (item as UICollectionView).transform;
    }
    
    return Float(sqrt(t.a * t.a + t.c * t.c));
}

func yscale(item:AnyObject)->Float {
    var t:CGAffineTransform!
    if item is UIView {
        t = (item as UIView).transform;
    }
    if item is UILabel {
        t = (item as UILabel).transform;
    }
    if item is UIImageView {
        t = (item as UIImageView).transform;
    }
    if item is UIButton {
        t = (item as UIButton).transform;
    }
    if item is UITextView {
        t = (item as UITextView).transform;
    }
    if item is UIScrollView {
        t = (item as UIScrollView).transform;
    }
    if item is UICollectionView {
        t = (item as UICollectionView).transform;
    }
    return Float(sqrt(t.b * t.b + t.d * t.d));
}

func getrotation(item:AnyObject)->Float {
    var t:CGAffineTransform!
    
    if item is UIView {
        t = (item as UIView).transform;
    }
    if item is UILabel {
        t = (item as UILabel).transform;
    }
    if item is UIImageView {
        t = (item as UIImageView).transform;
    }
    if item is UIButton {
        t = (item as UIButton).transform;
    }
    if item is UITextView {
        t = (item as UITextView).transform;
    }
    if item is UIScrollView {
        t = (item as UIScrollView).transform;
    }
    if item is UICollectionView {
        t = (item as UICollectionView).transform;
    }
    
    return Float(atan2f(Float(t.b), Float(t.a)));
}
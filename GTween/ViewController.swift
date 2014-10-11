//
//  ViewController.swift
//  GTween
//
//  Created by Goon Nguyen on 10/9/14.
//  Copyright (c) 2014 Goon Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var item: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var img: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //item.layer.cornerRadius = 20
        
        GTween.to(item, time: 2, params: [y:100, scaleX:3, scaleY:3, ease:Bounce.easeOut, delay:1],
            events: [onComplete:{
                println("item move complete")
            }])
        
        GTween.to(label, time: 2, params: [y:150, "ease":Circ.easeOut, "delay":1.5],
            events: ["onComplete":{
                println("label move complete")
            }])
        
        GTween.to(btn, time: 2, params: ["x":200, alpha:0.5, "ease":Elastic.easeOut, "delay":2],
            events: ["onComplete":{
                println("btn move complete")
            }])
        
        GTween.to(img, time: 2,
            params: [x:250, y:250, ease:Back.easeInOut, delay:2.5],
            events: [onStart:{
                    println("I start to move!")
                }, onUpdate: {
                    println("I'm movinggggg...")
                }, onComplete: {
                    println("I'm at the new position!")
                }])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


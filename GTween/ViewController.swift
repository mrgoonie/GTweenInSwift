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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        item.layer.cornerRadius = 20
        
        GTween.to(item, time: 2, params: ["x":100, "y":500, "width":100, "height":100, "ease":Quart.easeInOut, "delay":1],
            events: ["onComplete":{
                println("item move complete")
            }])
        
        GTween.to(label, time: 2, params: ["y":50, "ease":Quart.easeInOut, "delay":2],
            events: ["onComplete":{
                println("label move complete")
            }])
        
        GTween.to(btn, time: 2, params: ["x":200, "ease":Quart.easeInOut, "delay":3],
            events: ["onComplete":{
                println("btn move complete")
            }])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  MaskGuidDemo
//
//  Created by js on 16/9/9.
//  Copyright © 2016年 js. All rights reserved.
//

import UIKit
import MaskGuidKit

class ViewController: UIViewController {

    var maskItem: VersionConfigItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       let maskItem = VersionConfigItem(identity: "id2", relation: .LessThanOrEqual, version: "2.0")
        print(maskItem.flag)
        
        self.maskItem = maskItem
        self.maskItem?.operateValue = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  WaveView
//
//  Created by 王蕾 on 16/2/24.
//  Copyright © 2016年 Apple inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var waveView : WaveView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        waveView = WaveView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(waveView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  JenkinsTesting
//
//  Created by Aleem on 17/10/17.
//  Copyright © 2017 jenkins. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    var actIndicator: MBProgressHUD = MBProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator = MBProgressHUD(view: self.view)
        actIndicator.label.textColor = .black
        actIndicator.label.text = "Loading..."
        self.view.addSubview(actIndicator)
        actIndicator.show(animated: true)
        
        let dispatchTime = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.actIndicator.hide(animated: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


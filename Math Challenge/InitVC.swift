//
//  ViewController.swift
//  Math Challenge
//
//  Created by Apple Family on 7/28/17.
//  Copyright © 2017 Apple Family. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var takeChallengeBtn: UIButton!
    @IBOutlet weak var treeNumberImgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.object(forKey: KEY_RECORD_CURRENT) == nil {
            UserDefaults.standard.set(0, forKey: KEY_RECORD_CURRENT)
        }
        
        if UserDefaults.standard.object(forKey: KEY_RECORD_HIGHEST) == nil {
            UserDefaults.standard.set(0, forKey: KEY_RECORD_HIGHEST)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


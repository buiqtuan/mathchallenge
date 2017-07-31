//
//  InitStatVC.swift
//  Math Challenge
//
//  Created by Apple Family on 7/30/17.
//  Copyright © 2017 Apple Family. All rights reserved.
//

import UIKit

class InitStatVC: UIViewController {
    @IBOutlet weak var currentScoreLbl: UILabel!
    @IBOutlet weak var highestScoreLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currentScoreLbl.text = "Current Score: \(UserDefaults.standard.integer(forKey: KEY_RECORD_CURRENT))"
        highestScoreLbl.text = "Current Score: \(UserDefaults.standard.integer(forKey: KEY_RECORD_HIGHEST))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

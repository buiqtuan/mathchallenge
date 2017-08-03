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
    @IBOutlet weak var bannerDisplay: UILabel!
    @IBOutlet weak var statBtn: UIButton!
    @IBOutlet weak var appNameLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.object(forKey: KEY_RECORD_CURRENT) == nil {
            UserDefaults.standard.set(0, forKey: KEY_RECORD_CURRENT)
        }
        
        if UserDefaults.standard.object(forKey: KEY_RECORD_HIGHEST) == nil {
            UserDefaults.standard.set(0, forKey: KEY_RECORD_HIGHEST)
        }
        
        self.bannerDisplay.layer.cornerRadius = 10
        self.bannerDisplay.layer.masksToBounds = true
        self.takeChallengeBtn.layer.cornerRadius = 8
        
        self.statBtn.layer.cornerRadius = 50
        
        self.view.backgroundColor = UIColor.init(red: 195, green: 244, blue: 200)
        
        //set on-click animation for buttons
        UIView.animate(withDuration: 0.3,
            animations: {
                self.takeChallengeBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                self.bannerDisplay.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                self.statBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                self.appNameLbl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.takeChallengeBtn.transform = CGAffineTransform.identity
                    self.bannerDisplay.transform = CGAffineTransform.identity
                    self.statBtn.transform = CGAffineTransform.identity
                    self.appNameLbl.transform = CGAffineTransform.identity
                }
        })
        
        //Change the title every time it get reloaded
        self.bannerDisplay.text = "\(randomInt(min: 1, max: 9)) + \(randomInt(min: 1, max: 9)) = ?"
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    @IBAction func playNowPressed(_ sender: Any) {
        self.takeChallengeBtn = sender as! UIButton
        
        UIView.animate(withDuration: 0.1, animations:{
            self.takeChallengeBtn.frame = CGRect(x: self.takeChallengeBtn.frame.origin.x + 25, y: self.takeChallengeBtn.frame.origin.y + 25, width: self.takeChallengeBtn.frame.size.width, height: self.takeChallengeBtn.frame.size.height)
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


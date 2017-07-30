//
//  MainVC.swift
//  Math Challenge
//
//  Created by Apple Family on 7/30/17.
//  Copyright © 2017 Apple Family. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var firstFactor: UILabel!
    @IBOutlet weak var secondFactor: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var timeCounter: UIProgressView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var record: UILabel!
    
    var timer = Timer()
    var maxTime = 5
    var firstFactorInt = 0
    var secondFactorInt = 0
    var resultInt = 0
    var recordInt = 0
    var isCorrect = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.   
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.startBtn.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = false
        self.startBtn.addSubview(blurEffectView)
        
        //set up timer counter
        self.timeCounter.progress = 1.0
        
        //init the fist pair of factors
        self.initResult()
        
    }
    
    func initResult() {
        firstFactorInt =  randomInt(min: 1, max: 50)
        secondFactorInt =  randomInt(min: 1, max: 50)
        let sum = firstFactorInt + secondFactorInt
        if randomInt(min: 0, max: 1) == 1 {
            resultInt = sum
        } else {
            if sum < 20 {
                resultInt = randomInt(min: sum - 2, max: sum)
            }
            if sum < 40 && sum >= 20 {
                resultInt = randomInt(min: sum - 4, max: sum)
            }
            if sum < 60 && sum >= 40{
                resultInt = randomInt(min: sum - 4, max: sum)
            }
            if sum < 80 && sum >= 60 {
                resultInt = randomInt(min: sum - 6, max: sum)
            }
            if sum <= 100 && sum >= 80 {
                resultInt = randomInt(min: sum - 6, max: sum)
            }
        }
        self.result.text = "\(resultInt)"
        self.firstFactor.text = "\(firstFactorInt)"
        self.secondFactor.text = "\(secondFactorInt)"
        
        self.isCorrect = resultInt == (firstFactorInt + secondFactorInt) ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideBtnView(_ sender: Any) {
        self.startBtn.isHidden = true

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
    }
    
    @IBAction func correctPressed(_ sender: Any) {
        if self.isCorrect {
            self.recordInt += 1
            self.record.text = "\(self.recordInt)"
            self.timer.invalidate()
            self.timeCounter.progress = 1.0
            self.maxTime = 5
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
            self.initResult()
        } else {
            self.timer.invalidate()
        }
    }
    
    @IBAction func wrongPressed(_ sender: Any) {
        if !self.isCorrect {
            self.recordInt += 1
            self.record.text = "\(self.recordInt)"
            self.timer.invalidate()
            self.timeCounter.progress = 1.0
            self.maxTime = 5
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
            self.initResult()
        } else {
            self.timer.invalidate()
        }
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func setProgressBar()
    {
        maxTime -= 1
        self.timeCounter.setProgress(Float(maxTime) / Float(5), animated: true)
    }
}

//
//  MainVC.swift
//  Math Challenge
//
//  Created by Apple Family on 7/30/17.
//  Copyright © 2017 Apple Family. All rights reserved.
//

import UIKit
import AudioToolbox
import GoogleMobileAds

let KEY_RECORD_HIGHEST = "KEY_RECORD_HIGHEST"
let KEY_RECORD_CURRENT = "KEY_RECORD_CURRENT"

class MainVC: UIViewController, GADInterstitialDelegate,GADBannerViewDelegate {
    @IBOutlet weak var firstFactor: UILabel!
    @IBOutlet weak var secondFactor: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var timeCounter: UIProgressView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var record: UILabel!
    @IBOutlet weak var correctBtn: UIButton!
    @IBOutlet weak var wrongBtn: UIButton!
    
    @IBOutlet weak var currentScoreLbl: UILabel!
    @IBOutlet weak var highestScoreLbl: UILabel!
    @IBOutlet weak var failPopupView: UIView!
    @IBOutlet weak var failPopupBanner: UIView!
    @IBOutlet weak var failBackBtn: UIButton!
    @IBOutlet weak var failPlayAgainBtn: UIButton!
    
    @IBOutlet weak var bannerViewMainVC: UIView!
    
    var bannerView: GADBannerView!
    
    var timer = Timer()
    var maxTime = 300
    var firstFactorInt = 0
    var secondFactorInt = 0
    var resultInt = 0
    var recordInt = 0
    var isCorrect = false
    var showAdTimer = Timer()
    
    var subInterstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let blurEffect: UIBlurEffect!
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        } else {
            blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.startBtn.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = false
        self.startBtn.addSubview(blurEffectView)
        
        //set up timer counter
        self.timeCounter.progress = 1.0
        
        //setup fail popup
        self.failPopupBanner.layer.cornerRadius = 10
        self.failPopupBanner.backgroundColor = UIColor.init(red: 255, green: 246, blue: 210)
        self.failBackBtn.layer.cornerRadius = 4
        self.failPlayAgainBtn.layer.cornerRadius = 4
        
        let blurEffectPopup = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectViewPopup = UIVisualEffectView(effect: blurEffectPopup)
        blurEffectViewPopup.frame = self.failPopupView.bounds
        blurEffectViewPopup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectViewPopup.isUserInteractionEnabled = false
        
        self.failPopupView.backgroundColor = UIColor.clear
        self.failPopupView.insertSubview(blurEffectViewPopup, at: 0)
        
        self.view.backgroundColor = UIColor.init(red: 195, green: 244, blue: 200)
        
        self.correctBtn.layer.cornerRadius = 50
        self.wrongBtn.layer.cornerRadius = 50
        
        self.timeCounter.layer.cornerRadius = 3
        self.timeCounter.layer.masksToBounds = true
        
        //set inter ads
        subInterstitial = GADInterstitial(adUnitID: AD_INTER_PLAYGROUND_ID)
        subInterstitial.delegate = self
        subInterstitial.load(GADRequest())
        
        self.showAdTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(MainVC.callInterAds), userInfo: nil, repeats: false)
        
        //set banner ads
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.delegate = self
        self.bannerViewMainVC.addSubview(self.bannerView)
        bannerView.adUnitID = AD_BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        self.subInterstitial = GADInterstitial(adUnitID: AD_INTER_PLAYGROUND_ID)
        subInterstitial.delegate = self
        subInterstitial.load(GADRequest())
        return subInterstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.subInterstitial = createAndLoadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    @IBAction func reloadPlayGround(_ sender: Any) {
        self.timeCounter.progress = 1.0
        self.startBtn.isHidden = false
        self.failPopupView.isHidden = true
        self.timer.invalidate()
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        self.recordInt = 0
        self.record.text = "0"
        self.failPopupView.isHidden = true
        self.timeCounter.progress = 1.0
        self.maxTime = 300
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
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
                if randomInt(min: 0, max: 1) == 1 {
                    resultInt = sum + 10
                } else {
                    resultInt = randomInt(min: sum - 4, max: sum)
                }
            }
            if sum < 60 && sum >= 40{
                if randomInt(min: 0, max: 1) == 1 {
                    resultInt = sum - 10
                } else {
                    resultInt = randomInt(min: sum - 4, max: sum)
                }
            }
            if sum < 80 && sum >= 60 {
                if randomInt(min: 0, max: 1) == 1 {
                    resultInt = sum + 10
                } else {
                    resultInt = randomInt(min: sum - 4, max: sum)
                }            }
            if sum <= 100 && sum >= 80 {
                if randomInt(min: 0, max: 1) == 1 {
                    resultInt = sum - 10
                } else {
                    resultInt = randomInt(min: sum - 6, max: sum)
                }
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
        self.record.text = "0"
        self.recordInt = 0
        self.maxTime = 300
        
        self.startBtn.isHidden = true
        
        self.initResult()

        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
    }
    
    @IBAction func correctPressed(_ sender: Any) {
        if self.isCorrect {
            self.processCorrectChooice()
        } else {
            self.showFailPopup()
        }
    }
    
    @IBAction func wrongPressed(_ sender: Any) {
        if !self.isCorrect {
            self.processCorrectChooice()
        } else {
            self.showFailPopup()
        }
    }
    
    func processCorrectChooice() {
        self.recordInt += 1
        self.record.text = "\(self.recordInt)"
        self.timer.invalidate()
        self.timeCounter.progress = 1.0
        self.maxTime = 300
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MainVC.setProgressBar), userInfo: nil, repeats: true)
        self.initResult()
    }
    
    func showFailPopup() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.timer.invalidate()
        UserDefaults.standard.set(self.recordInt, forKey: KEY_RECORD_CURRENT)
        if self.recordInt > UserDefaults.standard.integer(forKey: KEY_RECORD_HIGHEST) {
            UserDefaults.standard.set(self.recordInt, forKey: KEY_RECORD_HIGHEST)
        }
        self.currentScoreLbl.text = "Current Score: \(UserDefaults.standard.integer(forKey: KEY_RECORD_CURRENT))"
        self.highestScoreLbl.text = "Highest Score: \(UserDefaults.standard.integer(forKey: KEY_RECORD_HIGHEST))"
        self.failPopupView.isHidden = false
        //set timer to call inter ads
        self.showAdTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(MainVC.callInterAds), userInfo: nil, repeats: false)
    }
    
    func callInterAds() {
        if self.startBtn.isHidden && self.failPopupView.isHidden {
            return
        }
        if self.subInterstitial.isReady {
            self.subInterstitial.present(fromRootViewController: self)
        }
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func setProgressBar() {
        maxTime -= 1
        self.timeCounter.setProgress(Float(maxTime) / Float(300), animated: true)
        if self.timeCounter.progress == 0 {
            showFailPopup()
        }
    }
}

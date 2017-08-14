//
//  InitStatVC.swift
//  Math Challenge
//
//  Created by Apple Family on 7/30/17.
//  Copyright © 2017 Apple Family. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FBSDKShareKit

class InitStatVC: UIViewController, GADInterstitialDelegate {
    @IBOutlet weak var currentScoreLbl: UILabel!
    @IBOutlet weak var highestScoreLbl: UILabel!
    @IBOutlet weak var recordStackView: UIStackView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var rateAppBtn: UIButton!
    
    var interstitial: GADInterstitial!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currentScoreLbl.text = "Current Score : \(UserDefaults.standard.integer(forKey: KEY_RECORD_CURRENT))"
        highestScoreLbl.text = "Highest Score : \(UserDefaults.standard.integer(forKey: KEY_RECORD_HIGHEST))"
        
        self.view.backgroundColor = UIColor.init(red: 195, green: 244, blue: 200)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.currentScoreLbl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.highestScoreLbl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.recordStackView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.backBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.currentScoreLbl.transform = CGAffineTransform.identity
                            self.highestScoreLbl.transform = CGAffineTransform.identity
                            self.recordStackView.transform = CGAffineTransform.identity
                            self.backBtn.transform = CGAffineTransform.identity
                        }
        })
        
        //set up inter add
        interstitial = GADInterstitial(adUnitID: AD_INTER_STAT_VC_ID)
        let request = GADRequest()
        interstitial.load(request)
        interstitial.delegate = self
        
        //set timer to call inter ads
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(InitStatVC.callInterAds), userInfo: nil, repeats: false)
        
        //set up share Function
    }
    
    func callInterAds() {
        if self.interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    @IBAction func shareAction(_ sender: Any) {
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: ITUNE_APP_URL)! as URL
        content.quote = "Check out this cool mini game, I've just got \(UserDefaults.standard.value(forKey: KEY_RECORD_HIGHEST) ?? "") points, beat me??"
        
        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
    }
    @IBAction func rateAction(_ sender: Any) {
        let url: URL = URL(string:ITUNE_APP_REVIEW_URL)!
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open \(ITUNE_APP_REVIEW_URL): \(success)")
            })
        } else {
            if UIApplication.shared.openURL(url) {
                print("Open \(ITUNE_APP_REVIEW_URL): success")
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "backToInitView", sender: nil)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let _interstitial = GADInterstitial(adUnitID: AD_INTER_STAT_VC_ID)
        _interstitial.delegate = self
        _interstitial.load(GADRequest())
        return _interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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

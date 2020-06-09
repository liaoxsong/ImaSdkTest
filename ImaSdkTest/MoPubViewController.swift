//
//  MoPubViewController.swift
//  ImaSdkTest
//
//  Created by Song Liao on 6/8/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
//import MoPub
//
//class MoPubViewController: UIViewController, MPInterstitialAdControllerDelegate {
//
//	var mopub: MPInterstitialAdController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//		//interstitial test ad unit id, 4f117153f5c24fa6a3a92b818a5eb630
//		//my own testing ad unit id:340ed34f68974e078c783576618676be
//		mopub = MPInterstitialAdController(forAdUnitId: "4f117153f5c24fa6a3a92b818a5eb630")
//		mopub.delegate = self
//
//        // Do any additional setup after loading the view.
//    }
//
//	func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
//		print("loaded ad")
//	}
//    
//
//	func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!, withError error: Error!) {
//		print("ad failed :\(error)")
//	}
//	@IBAction func buttonClicked(_ sender: UIButton) {
//		mopub.loadAd()
//	}
//
//	@IBAction func showAd(_ sender: Any) {
//		if mopub.ready {
//				print("mopub showing")
//				mopub.show(from: self)
//			}else {
//				print("Mopub not ready")
//			}
//	}
//}

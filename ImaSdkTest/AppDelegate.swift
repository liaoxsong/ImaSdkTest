//
//  AppDelegate.swift
//  ImaSdkTest
//
//  Created by Song Liao on 6/5/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
//import MoPub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.

//		let sdkConfig = MPMoPubConfiguration(adUnitIdForAppInitialization: "4f117153f5c24fa6a3a92b818a5eb630")
//		//sdkConfig.globalMediationSettings = []
//		sdkConfig.loggingLevel = .info
//		sdkConfig.allowLegitimateInterest = true
//
//		MoPub.sharedInstance().initializeSdk(with: sdkConfig, completion: {
//			print("Mopub sdk init completed")
//		})

		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}


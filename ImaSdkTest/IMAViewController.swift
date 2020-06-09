import AVFoundation
import AVKit
import UIKit
import GoogleInteractiveMediaAds

//https://developers.google.com/interactive-media-ads/docs/sdks/ios

class IMAViewController: UIViewController, IMAAdsLoaderDelegate, IMAAdsManagerDelegate {

	//official example, very slow
	static let Content1 = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
	//video to be displayed
	static let Content2 = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"


	//ad VAST Url to be played prior to video, timestamp is ISO 8601
	static let AdTagURLString = "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/single_ad_samples&ciu_szs=300x250&impl=s&gdfp_req=1&env=vp&output=vast&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ct%3Dlinear&correlator="

	static let AdTag2 = "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/single_ad_samples&ciu_szs=300x250&impl=s&gdfp_req=1&env=vp&output=vast&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ct%3Dlinear&correlator=2020-06-09T00:17:57+0000"

	var adsLoader: IMAAdsLoader!
	var adsManager: IMAAdsManager!

	var contentPlayhead: IMAAVPlayerContentPlayhead?

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

  var playerViewController: AVPlayerViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black;
    setUpContentPlayer()
	setUpAdsLoader()
  }

	@IBAction func requestAdClicked(_ sender: Any) {
		showContentPlayer()
		requestAds()
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

  func setUpContentPlayer() {
    // Load AVPlayer with path to our content.
		let contentURL = URL(string: IMAViewController.Content1)!
		   let player = AVPlayer(url: contentURL)
		   playerViewController = AVPlayerViewController()
		   playerViewController.player = player

		   contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: player)
			 NotificationCenter.default.addObserver(
			   self,
			   selector: #selector(IMAViewController.contentDidFinishPlaying(_:)),
			   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
			   object: player.currentItem);

			hideContentPlayer()
		   //showContentPlayer()

  }

	func setUpAdsLoader() {
		adsLoader = IMAAdsLoader(settings: nil)
		adsLoader.delegate = self
	}

	func requestAds() {
		//create ad display for ad rendering
		let adDisplayContainer = IMAAdDisplayContainer(adContainer: self.view)
		//create an ad request with our ad tag, display container
		let request = IMAAdsRequest(
        adTagUrl: IMAViewController.AdTag2,
        adDisplayContainer: adDisplayContainer,
        contentPlayhead: contentPlayhead,
        userContext: nil)
		adsLoader.requestAds(with: request)
	}

	@objc func contentDidFinishPlaying(_ notification: Notification) {
	   adsLoader.contentComplete()
	 }

  func showContentPlayer() {
    self.addChild(playerViewController)

    playerViewController.view.frame = self.view.bounds
    self.view.insertSubview(playerViewController.view, at: 0)
    playerViewController.didMove(toParent:self)
  }

  func hideContentPlayer() {
    // The whole controller needs to be detached so that it doesn't capture  events from the remote.
    playerViewController.willMove(toParent:nil)
    playerViewController.view.removeFromSuperview()
    playerViewController.removeFromParent()
  }

	//MARK: - IMAAdsLoaderDelegate
	func adsLoader(_ loader: IMAAdsLoader!, adsLoadedWith adsLoadedData: IMAAdsLoadedData!) {
		adsManager = adsLoadedData.adsManager
		adsManager.delegate = self
		adsManager.initialize(with: nil)
	}

	func adsLoader(_ loader: IMAAdsLoader!, failedWith adErrorData: IMAAdLoadingErrorData!) {
		print("Error loading ads: " + adErrorData.adError.message)
		print("error code: \(adErrorData.adError.code.rawValue)")
		showContentPlayer()
		playerViewController.player?.play()
	}

	//MARK: - IMAAdsManagerDelegate
	func adsManager(_ adsManager: IMAAdsManager!, didReceive error: IMAAdError!) {
		print("AdsManager Error: \(error.code), \(String(describing: error.message)) ")
		showContentPlayer()
		playerViewController.player?.play()
	}

	func adsManager(_ adsManager: IMAAdsManager!, didReceive event: IMAAdEvent!) {
		//start playing once ads is loaded
		if event.type == IMAAdEventType.LOADED {
			adsManager.start()
		}
	}

	func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager!) {
		// pause the content for the SDK to play ads
		playerViewController.player?.pause()
		hideContentPlayer()
	}

	func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager!) {
		//Resume the content since the SDK is done playing ads (at least for now)
		showContentPlayer()
		playerViewController.player?.play()
	}
}


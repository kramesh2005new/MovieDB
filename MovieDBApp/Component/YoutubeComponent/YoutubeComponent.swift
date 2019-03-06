//
//  AwesomeView.swift
//  IBComponents
//
//  Created by Ricardo Gehrke Filho on 26/09/17.
//  Copyright © 2017 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import XCDYouTubeKit

@IBDesignable class YoutubeComponent: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var imgYoutubevideo: UIImageView!
    
    @IBOutlet var imgPlay: UIImageView!
    
    var videoContainerView: UIView!
    
    private var _youtubeURL: URL!
    
    private var _youtubeVideoIdentifier: String!
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    var playerViewController:XCDYouTubeVideoPlayerViewController!
    
    let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: YoutubeComponent.self)
        bundle.loadNibNamed("YoutubeComponent", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
//    @IBInspectable var button1Title: String = "" {
//        didSet {
//            button1.setTitle(button1Title, for: .normal)
//        }
//    }
    
    var youtubeVideoIdentifier: String {
        get {
            
            return _youtubeVideoIdentifier
        }
        set(newIdentifier){
            
            self._youtubeVideoIdentifier = newIdentifier
            
            setupControls()
        }
    }
    
    private func setupControls()
    {
        if self._youtubeVideoIdentifier != nil && self.imgYoutubevideo != nil
        {
            if let thumbnailURL = URL(string: "http://img.youtube.com/vi/\(self._youtubeVideoIdentifier!)/1.jpg")
            {
                self.imgYoutubevideo.sd_setImage(with: thumbnailURL, placeholderImage: UIImage(named:"logo"), options: .refreshCached, completed: { (img, error, cache, url) in
                    
                    if (error != nil)
                    {
                        self.imgYoutubevideo.contentMode = .scaleAspectFill
                    }
                    else
                    {
                        self.imgYoutubevideo.contentMode = .scaleAspectFill
                    }
                    
                })
            }
            
        }
        
        if tapGestureRecognizer == nil && self.imgPlay != nil
        {
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedPlay(_:)))
            
            self.imgPlay.isUserInteractionEnabled = true
            
            self.imgPlay.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func tappedPlay(_ sender:AnyObject){
        print("Youtupe Identifier : \(self.youtubeVideoIdentifier)")
        
        playerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: self.youtubeVideoIdentifier)
        
        if self.tag == 0
        {
            appDelegate.window?.rootViewController?.present(playerViewController, animated: true) {
                
                //self.appDelegate.youtubePlayerShow = true
                self.playerViewController.moviePlayer.play()
            }
        }
        else
        {
            if self.videoContainerView != nil
            {
                playerViewController.present(in: self.videoContainerView)
                playerViewController.moviePlayer.play()
            }
        }
        
    }
    
    func moviePlayerPlaybackDidFinish(notification: Notification)
    {
        
    }
    
}

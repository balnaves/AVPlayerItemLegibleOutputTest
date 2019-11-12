//
//  ViewController.swift
//  AVPlayerItemLegibleOutputTest
//
//  Created by James Balnaves on 11/11/19.
//  Copyright © 2019 James Balnaves. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    let playerVC = AVPlayerViewController()
    let captionOutput = AVPlayerItemLegibleOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8") else {
            return
        }
        // Create an AVPlayer
        let player = AVPlayer(url: url)
        playerVC.player = player
        
        // Add the AVPlayerViewController view to our positioning  view
        playerView.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
        
        playerVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerVC.view.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            playerVC.view.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            playerVC.view.topAnchor.constraint(equalTo: playerView.topAnchor),
            playerVC.view.bottomAnchor.constraint(equalTo: playerView.bottomAnchor)
        ])
        
        // Set ourself as the delegate to AVPlayerItemLegibleOutput and we will
        // get notified when a caption appears.
        captionOutput.setDelegate(self, queue: DispatchQueue.main)
        
        // Turn off the AVPlayer's display of captions (if desired)
        //captionOutput.suppressesPlayerRendering = true
        
        player.play()
        player.currentItem?.add(captionOutput)
    }
}

extension ViewController: AVPlayerItemLegibleOutputPushDelegate {
    func legibleOutput(_ output: AVPlayerItemLegibleOutput,
                       didOutputAttributedStrings strings: [NSAttributedString],
                       nativeSampleBuffers nativeSamples: [Any],
                       forItemTime itemTime: CMTime) {
        textView.attributedText = strings.first
    }
}

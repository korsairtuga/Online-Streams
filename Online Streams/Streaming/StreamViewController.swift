//
//  StreamViewController.swift
//  Online Streams
//
//  Created by Joshua Liebowitz on 11/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

import AVKit
import UIKit

class StreamViewController: UIViewController {

    var streamURL: NSURL!;

    convenience required init(streamURL: NSURL) {
        self.init(nibName: nil, bundle: nil)
        self.streamURL = streamURL
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let avPlayer = AVPlayer(URL: self.streamURL)
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(avPlayerLayer)
        avPlayer.play()
    }
}

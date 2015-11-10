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

    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?

    var detailItem: NSURL? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let player: AVPlayer = self.avPlayer {
                player.pause()
                self.avPlayer = nil
                self.avPlayerLayer!.removeFromSuperlayer()
            }
            self.avPlayer = AVPlayer(URL: detail)
            self.avPlayerLayer = AVPlayerLayer(player: avPlayer)
            self.avPlayerLayer!.frame = self.view.bounds
            self.view.layer.addSublayer(avPlayerLayer!)
        }
    }

    func stop() {
        if let player = self.avPlayer {
            player.pause()
        }
    }

    func start() {
        if let player = self.avPlayer {
            player.play()
        }
    }

    override func viewWillDisappear(animated: Bool) {
        self.stop()
    }

}

//
//  ViewController.swift
//  Online Streams
//
//  Created by Joshua Liebowitz on 11/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var detailViewController: StreamViewController? = nil
    var streams: Array<StreamTableViewCellData> = [
        StreamTableViewCellData(streamURL: NSURL(string: "http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8?b=500,300,700,900,1200")!, streamTitle: "ABC"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://c004.p105.edgesuite.net/i/c004/bbcworld_1@97498/master.m3u8")!, streamTitle: "BBC World News"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://whdh.mpl.miisolutions.net:1935/whdh-live01/_definst_/mp4:whdh_1/playlist.m3u8")!, streamTitle: "Boston WHDH (channel 7 news"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://btvasia-i.akamaihd.net/hls/live/203322/btvasia_ios/P1/M24K.m3u8")!, streamTitle: "Bloomberg"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://origin2.live.web.tv.streamprovider.net/streams/877ba7a57aa68fd898b838f58d51a69f/index.m3u8")!, streamTitle: "CCTV"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://origin2.live.web.tv.streamprovider.net/streams/3bc166ba3776c04e987eb242710e75c0/index.m3u8")!, streamTitle: "CNBC"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://nasatv-lh.akamaihd.net/i/NASA_101@319270/master.m3u8")!, streamTitle: "NASA"),
        StreamTableViewCellData(streamURL: NSURL(string: "http://37.58.85.156/rlo001/ngrp:rlo001.stream_all/playlist.m3u8")!, streamTitle:"Reuters")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! StreamViewController)
        }
    }

    override func viewWillAppear(animated: Bool) {
        if let split = self.splitViewController {
            self.clearsSelectionOnViewWillAppear = split.collapsed
        }
        super.viewWillAppear(animated)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let streamData = self.streams[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = streamData.streamTitle
        return cell
    }

    override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath {
            let streamData = self.streams[indexPath.row]
            if let controller = self.detailViewController {
                controller.detailItem = streamData.streamURL
                controller.start()
            }
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let controller = self.detailViewController {
            controller.stop()
        }

        let streamData = self.streams[indexPath.row]
        let streamViewController = StreamViewController()
        streamViewController.detailItem = streamData.streamURL

        self.splitViewController?.presentViewController(streamViewController, animated: true, completion: { () -> Void in
            streamViewController.start()
        })
    }

}


//
//  ViewController.swift
//  Online Streams
//
//  Created by Joshua Liebowitz on 11/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

import UIKit

class ChannelViewController: UITableViewController {

    var detailViewController: StreamViewController? = nil
    var streams: [StreamTableViewCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! StreamViewController)
        }
    }

    func loadChannelsFromFile() -> [StreamTableViewCellData] {
        let bundle = NSBundle(forClass: ChannelViewController.self)
        let filePath = bundle.pathForResource("channels", ofType: "json", inDirectory: "Stream Data")
        let channelsText: NSData = NSData(contentsOfFile: filePath!)!
        do {
            let dataDictionary: [Dictionary] = try NSJSONSerialization.JSONObjectWithData(channelsText, options: []) as! [Dictionary<String, String>]
            let channels = dataDictionary.map{ StreamTableViewCellData(streamURL: NSURL(string: $0["url"]!)!, streamTitle: $0["title"]!)}.sort({ (
                first, second) -> Bool in
                return first.streamTitle.compare(second.streamTitle) == NSComparisonResult.OrderedAscending
            })
            return channels
        } catch {
            print("json error: \(error)")
            return []
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.streams = self.loadChannelsFromFile()

        if let split = self.splitViewController {
            self.clearsSelectionOnViewWillAppear = split.collapsed
        }
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


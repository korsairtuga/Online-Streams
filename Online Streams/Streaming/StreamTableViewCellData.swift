//
//  StreamTableViewCellData.swift
//  Online Streams
//
//  Created by Joshua Liebowitz on 11/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

import UIKit

class StreamTableViewCellData: NSObject {

    let streamTitle: String
    let streamURL: NSURL

    required init(streamURL: NSURL, streamTitle: String) {
        self.streamURL = streamURL
        self.streamTitle = streamTitle
        super.init()
    }

}

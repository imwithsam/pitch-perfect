//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Samson Brock on 11/30/15.
//  Copyright © 2015 Samson Brock. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
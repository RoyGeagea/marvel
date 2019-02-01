//
//  DetailOperations.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

enum DetailOperationState {
    case New, Downloaded, Failed
}

class DetailRecord {
    let name:String
    let url: URL
    var state = DetailOperationState.New
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}

class DetailOperation {
    lazy var downloadsInProgress = [IndexPath: Operation]()
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        //in default, the operation know how much it must run in concurrency(deppending on the hardware)
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class DetailOperationDownloader: Operation {

    let detailRecord: DetailRecord
    

    init(detailRecord: DetailRecord) {
        self.detailRecord = detailRecord
    }
    
    override func main() {
        if self.isCancelled {
            return
        }

//        let imageData = NSData(contentsOfURL:self.photoRecord.url)
        

        if self.isCancelled {
            return
        }
        

//        if imageData?.length > 0 {
//            self.photoRecord.image = UIImage(data:imageData!)
//            self.photoRecord.state = .Downloaded
//        }
//        else
//        {
//            self.photoRecord.state = .Failed
//            self.photoRecord.image = UIImage(named: "Failed")
//        }
    }
}


//
//  Helper.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import Kingfisher

class Helper: NSObject {
    
    class func setImage(imgView: UIImageView, url: URL) {
        var imgView = imgView
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}

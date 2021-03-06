//
//  ItemCollectionViewCell.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(detail: DetailObject) {
        self.titleLabel.text = detail.title
        if detail.imageURL != "" {
            Helper.setImage(imgView: self.imgView, url: URL(string: detail.imageURL)!)
        }
        else {
            self.imgView.image = UIImage(named: "no-image.jpg")
        }
    }
    
}

//
//  DetailObject.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import Foundation

struct DetailObject {
    
    let ID: String!
    let title : String!
    let imageURL : String!
    
    init(ID: String, title: String, imageURL: String) {
        self.ID = ID
        self.title = title
        self.imageURL = imageURL
    }
    
}

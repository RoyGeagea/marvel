//
//  AppDelegate.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

enum DetailType: String {
    case character = "Character"
    case comics = "Comics"
    case events = "Events"
    case stories = "Stories"
    case series = "Series"
}

protocol TableViewCellBuilder {
    var rowHeight: CGFloat { get }
    var rowName: String { get }
    var items: [Items] { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

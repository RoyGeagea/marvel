//
//  AppDelegate.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

protocol TableViewCellBuilder {
    var rowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

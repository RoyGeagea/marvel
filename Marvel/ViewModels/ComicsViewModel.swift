//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

class ComicsViewModel: TableViewCellBuilder {

    var items: [Items]
    var rowHeight: CGFloat = 248
    var rowName: String
    var isDownloaded = false
    var details: [DetailObject]?
    var characterID: String
    
    init(items: [Items], rowName: String, characterID: String) {
        self.items = items
        self.rowName = rowName
        self.characterID = characterID
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        
        cell.setup(vm: self)
        
        return cell
    }
    
}

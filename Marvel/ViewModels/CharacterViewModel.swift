//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

class CharacterViewModel: TableViewCellBuilder {
    
    var character: Results
    var rowHeight: CGFloat = 100
    
    init(character: Results) {
        self.character = character
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
        // Pass ourselves (the view model) to setup the cell
        cell.setup(vm: self)
        
        // Return the cell
        return cell
    }
}

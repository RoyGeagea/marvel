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
    var rowName: String = DetailType.character.rawValue
    var items: [Items] = [Items]()
    
    init(character: Results) {
        self.character = character
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
        cell.setup(vm: self)
        
        return cell
    }
}

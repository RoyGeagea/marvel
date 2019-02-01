//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(vm: CharacterViewModel) {
        self.titleLabel.text =  vm.character.name
        self.detailsLabel.text = vm.character.description
        Helper.setImage(imgView: self.imgView, url: URL(string: (vm.character.thumbnail?.path)! + "." + (vm.character.thumbnail?.tExtension)!)!)
    }

}

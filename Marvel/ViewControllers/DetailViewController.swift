//
//  DetailViewController.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var character: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.tableFooterView = UIView()
        
        self.titleLabel.text = self.character.name
        Helper.setImage(imgView: self.imgView, url: URL(string: (character.thumbnail?.path)! + "." + (character.thumbnail?.tExtension)!)!)
    }



}


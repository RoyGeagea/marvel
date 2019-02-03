//
//  DetailTableViewCell.swift
//  Marvel
//
//  Created by Roy Geagea on 2/1/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ComicsViewModel!
    var detailsObjects: [DetailObject]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(vm: ComicsViewModel) {
        self.viewModel = vm
        self.titleLabel.text =  vm.rowName
        
        if vm.isDownloaded == false {
            self.getComics(type: self.viewModel.rowName.lowercased())
        }
        else {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.reloadData()
        }
    }
    
    func getComics(type: String) {
        DataManager.sharedInstance.getForCharacter(type: type, view: self, characterID: self.viewModel.characterID) { (success, detailsObjects, errorMessage) in
            if success {
                OperationQueue.main.addOperation({
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
                    if self.viewModel.rowName.lowercased() == type {
                        self.viewModel.details = detailsObjects!
                        self.viewModel.isDownloaded = true
                    }
                    self.collectionView.reloadData()
                })
            }
            else {
                
            }
        }
    }
    
}

extension DetailTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCollectionViewCell
        
        cell.setup(detail: self.viewModel.details[indexPath.item])
        
        return cell
    }
    
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 117, height: 199)
    }
    
}

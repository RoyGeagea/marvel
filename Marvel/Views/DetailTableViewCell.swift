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
        
        switch self.viewModel.rowName {
        case DetailType.comics.rawValue:
            if vm.isDownloaded == false {
                self.getComics()
            }
            else {
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
            }
        default:
            break
        }
    }
    
    func getComics() {
        DataManager.sharedInstance.getComicsForCharacter(view: self, characterID: "1011334") { (success, detailsObjects, errorMessage) in
            if success {
                OperationQueue.main.addOperation({
                    self.viewModel.details = detailsObjects
                    self.viewModel.isDownloaded = true
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
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
        if self.viewModel.items.count > 3 {
            return 3
        }
        else {
            return self.viewModel.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCollectionViewCell
        
        cell.setup(detail: self.viewModel.details![indexPath.item])
        
        return cell
    }
    
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.viewModel.rowName {
        case DetailType.comics.rawValue:
            return CGSize(width: 117, height: 199)
        default:
            return CGSize(width: 117, height: 199)
        }
    }
    
}

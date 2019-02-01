//
//  MasterViewController.swift
//  Marvel
//
//  Created by Roy Geagea on 1/31/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import UIKit
import ListPlaceholder

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var data = [TableViewCellBuilder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView()
        
        self.getCharacters()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = data[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                let character = (object as! CharacterViewModel).character
                controller.character = character
                controller.title = "\(character.id!)"
                
                var dataToPass = [TableViewCellBuilder]()
                if let comics = character.comics, let items = comics.items, items.count > 0 {
                    dataToPass.append(ComicsViewModel(comics: items))
                }
                controller.data = dataToPass
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data[indexPath.row].cellInstance(tableView, indexPath: indexPath)
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].rowHeight
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
    //MARK: - API CALL
    
    func getCharacters() {
        self.tableView.showLoader()
        DataManager.sharedInstance.getUserData(viewController: self, firstTime: true) { (success, viewModels, errorMessage) in
            OperationQueue.main.addOperation({
                self.tableView.hideLoader()
            })
            if success {
                self.data = viewModels!
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
            else {
                
            }
        }
    }
    

}


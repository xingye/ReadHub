//
//  TopicTableViewController.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 17/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

class TopicTableViewController: UITableViewController {

    static let sectionHeaderReusedID = "sectionHeader"
    
    let loader = DataLoader<Topic> { result in
        result.filter { $0.title != nil && !$0.title!.isEmpty }
    }
    
    var topics  = [Topic]() {
        didSet {
            tableViewModel = TopicTableViewModel(topics: topics)
        }
    }
    
    var tableViewModel = TopicTableViewModel(topics: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: TopicTableViewController.sectionHeaderReusedID)
        
        loader.load { (result) in
            switch result {
            case .failure(let error):
                print("load topic error: \(error.localizedDescription)")
                
            case .success(let data):
                self.topics += data
                
                DispatchQueue.main.async {
                    dump(self.topics)
                    self.tableView.reloadData()
                }
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableViewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return tableViewModel.tableView(tableView, viewForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewModel.tableView(tableView, heightForHeaderInSection: section)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}

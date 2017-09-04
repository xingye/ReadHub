//
//  NewsTableViewController.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/1.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit
import ESPullToRefresh

class NewsTableViewController: UITableViewController, Refreshable {
    
    lazy var viewModel: Refresher = {
        let index = self.navigationController?.tabBarController?.selectedIndex
        if index == 2 {
            return TechNewsTableViewModel()
        }
        return NewsTableViewModel()
    }()
    
    var tableViewModel: BasicNewsTableViewModel {
        return viewModel as! BasicNewsTableViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewModel.load { [weak self] (error) in
            if let err = error {
                print(err)
                return
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        tableView.rowHeight = 150
        tableView.register(NewsCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = tableViewModel.url(at: indexPath)
        performSegue(withIdentifier: "news", sender: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "news",
            let url = sender as? URL else {
            return
        }
        
        let webVC = segue.destination as! WebViewController
        webVC.url = url
    }
}

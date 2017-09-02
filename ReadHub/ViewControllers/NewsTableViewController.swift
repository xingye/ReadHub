//
//  NewsTableViewController.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/1.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    lazy var viewModel: BasicNewsTableViewModel = {
        let index = self.navigationController?.tabBarController?.selectedIndex
        if index == 2 {
            return TechNewsTableViewModel()
        }
        return NewsTableViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.load { [weak self] (error) in
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
        return viewModel.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.url(at: indexPath)
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

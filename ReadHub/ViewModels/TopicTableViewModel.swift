//
//  TopicTableViewModel.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 31/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

struct TopicTableViewModel {
    private var topics: [Topic]
    private var sectionViewModels: [SectionHeaderViewModel]
    
    init(topics: [Topic]) {
        self.topics = topics
        sectionViewModels = topics.map(SectionHeaderViewModel.init)
    }
    
    func numberOfSections() -> Int {
        return self.topics.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let topic = topics[section]
        let sectionViewModel = sectionViewModels[section]
        
        switch sectionViewModel.status {
        case .collasp:
            return 0
            
        case .open:
            if let items = topic.newsArray {
                return items.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            TopicTableViewController.sectionHeaderReusedID) as! SectionHeaderView
        headerView.viewModel = sectionViewModels[section]
        
        return headerView
    }
    
    // FIXME: Need to optimize
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            TopicTableViewController.sectionHeaderReusedID) as! SectionHeaderView
        headerView.viewModel = sectionViewModels[section]
        
        print("****** section: \(section) height: \(headerView.height)")
        return headerView.height
 
        //return 50.0
    }
    
    
}

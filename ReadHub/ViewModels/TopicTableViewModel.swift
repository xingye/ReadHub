//
//  TopicTableViewModel.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 31/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

class TopicTableViewModel {
    
    private var topics: [Topic] = []
    private var sectionViewModels: [SectionHeaderViewModel] = []
    private let templateCell: TopicSummaryCell
    
    init() {
        self.templateCell =  Bundle.main.loadNibNamed("TopicSummaryCell",
                                                 owner: nil,
                                                 options: nil)![0] as! TopicSummaryCell
    }
    
    let loader = DataLoader<Topic> { result in
        result.filter { $0.title != nil && !$0.title!.isEmpty }
    }
    
    func load(completion: @escaping (Error?) -> Void) {
        loader.load { (result) in
            switch result {
            case .failure(let error):
                print("load topic error: \(error.localizedDescription)")
                completion(error)
                
            case .success(let data):
                self.topics = data
                self.sectionViewModels = self.topics.map(SectionHeaderViewModel.init)
                
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func replaceSectionViewModel(at index: Int, with model: SectionHeaderViewModel) {
        self.sectionViewModels[index] = model
    }
    
    func topic(at indexPath: IndexPath) -> TopicItem {
        return topics[indexPath.section].newsArray![indexPath.row]
    }
    
    func topicUrl(at indexPath: IndexPath) -> URL? {
        let topic = self.topic(at: indexPath)
        guard let url = topic.mobileUrl, let result = try? url.asURL() else {
            return nil
        }
        
        return result
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as! SectionHeaderView
        headerView.viewModel = sectionViewModels[section]
        headerView.section = section
        
        return headerView
    }
    
    // FIXME: Need to optimize
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as! SectionHeaderView
        headerView.viewModel = sectionViewModels[section]
        
        print("****** section: \(section) height: \(headerView.height)")
        return headerView.height + 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let topic = topics[indexPath.section]
            let model = TopicSummaryCellViewModel(topic: topic)
            templateCell.config(with: model)
            
            let height = templateCell.cellHeight()
            print("indexPath: \(indexPath), height: \(height)")
            
            return height
        }
 
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as TopicSummaryCell
            let viewModel = TopicSummaryCellViewModel(topic: topics[indexPath.section])
            cell.config(with: viewModel)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as TopicCell
        let topic = topics[indexPath.section]
        let item = topic.newsArray![indexPath.row]
        let viewModel = TopicCellViewModel(topic: item)
        cell.config(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 { return false }
        return true
    }
}

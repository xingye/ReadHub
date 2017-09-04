//
//  TopicTableViewModel.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 31/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

class TopicTableViewModel: Refresher {
    
    fileprivate var topics: [Topic] = []
    fileprivate var sectionViewModels: [SectionHeaderViewModel] = []
    private let templateCell: TopicSummaryCell
    
    init() {
        self.templateCell = Bundle.main.loadNibNamed("TopicSummaryCell",
                                                 owner: nil,
                                                 options: nil)![0] as! TopicSummaryCell
    }
    
    let loader = DataLoader<Topic> { result in
        result.filter { $0.title != nil && !$0.title!.isEmpty }
    }
    
    fileprivate func loadOrRefresh(with result: Result<[Topic]>, completion: @escaping (Error?) -> Void) {
        switch result {
        case .failure(let error):
            print("load topic error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                completion(error)
            }
            
        case .success(let data):
            self.topics = data
            self.sectionViewModels = self.topics.map(SectionHeaderViewModel.init)
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func refresh(completion: @escaping (Error?) -> Void) {
        loader.refresh { [unowned self] (result) in
            self.loadOrRefresh(with: result, completion: completion)
        }
    }
    
    func loadMore(completion: @escaping (Error?, IndexSet) -> Void) {
        loader.nextPage { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, [])
                }
                
            case .success(let data):
                let currentSections = self.sectionViewModels.count
                
                self.topics.append(contentsOf: data)
                self.sectionViewModels.append(contentsOf: data.map(SectionHeaderViewModel.init))
                
                let insertedSections = IndexSet(integersIn: currentSections..<(currentSections+data.count))
                DispatchQueue.main.async {
                    completion(nil, insertedSections)
                }
            }
        }
    }
    
    func load(completion: @escaping (Error?) -> Void) {
        loader.load { [unowned self] (result) in
            self.loadOrRefresh(with: result, completion: completion)
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
        
        return headerView.height + 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let topic = topics[indexPath.section]
            let model = TopicSummaryCellViewModel(topic: topic)
            templateCell.config(with: model)
            
            let height = templateCell.cellHeight()
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

/*
extension TopicTableViewModel: Refresher {
    
    func refresh(completion: @escaping (Error?) -> Void) {
        loader.refresh { [unowned self] (result) in
            self.loadOrRefresh(with: result, completion: completion)
        }
    }
    
    func loadMore(completion: @escaping (Error?, IndexSet) -> Void) {
        loader.nextPage { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, [])
                }
                
            case .success(let data):
                let currentSections = self.sectionViewModels.count
                
                self.topics.append(contentsOf: data)
                self.sectionViewModels.append(contentsOf: data.map(SectionHeaderViewModel.init))
                
                let insertedSections = IndexSet(integersIn: currentSections..<(currentSections+data.count))
                DispatchQueue.main.async {
                    completion(nil, insertedSections)
                }
            }
        }
    }
}
 */

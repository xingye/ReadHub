//
//  TopicTableViewController.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 17/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit
import ESPullToRefresh

class TopicTableViewController: UITableViewController {
    
    var tableViewModel = TopicTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        configureRefresher()
        
        tableViewModel.load { [unowned self] error in
            if let err = error {
                print("### load topic error", err)
                
                return
            }
            
            self.tableView.reloadData()
        }
        
        tableView.estimatedRowHeight = 60
    }
    
    private func registerNib() {
        tableView.register(SectionHeaderView.self)
        tableView.register(TopicCell.self)
        tableView.register(TopicSummaryCell.self)
    }
    
    private func configureRefresher() {
        let header = ESRefreshHeaderAnimator(frame: .zero)
        let footer = ESRefreshFooterAnimator(frame: .zero)
        
        tableView.es_addPullToRefresh(animator: header) { [unowned self] in
            self.tableViewModel.refresh { error in
                if let err = error {
                    print(err)
                    return
                }
                self.tableView.es_stopPullToRefresh()
                self.tableView.reloadData()
            }
        }
        
        tableView.es_addInfiniteScrolling(animator: footer) { [unowned self] in
            self.tableViewModel.loadMore { error, sections in
                if let err = error {
                    print(err)
                    return
                }
                
                if sections.count > 0 {
                    self.tableView.es_stopLoadingMore()
                    self.tableView.insertSections(sections, with: .automatic)
                } else {
                    self.tableView.es_noticeNoMoreData()
                }
            }
        }
        
        tableView.expriedTimeInterval = 20.0
    }
}

// MARK: - Table view data source

extension TopicTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewModel.tableView(tableView, cellForRowAt: indexPath)
     }
}

// MARK: - TableView Delegate

extension TopicTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewModel.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewModel.tableView(tableView, heightForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableViewModel.tableView(tableView, viewForHeaderInSection: section) as! SectionHeaderView
        headerView.delegate = self
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { return }
        
        if let url = tableViewModel.topicUrl(at: indexPath) {
            performSegue(withIdentifier: "web", sender: url)
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return tableViewModel.tableView(tableView, shouldHighlightRowAt: indexPath)
    }
}

// MARK: - SectionHeaderViewDelegate

extension TopicTableViewController: SectionHeaderViewDelegate {
    func sectionHeaderViewDidTap(_ headerView: SectionHeaderView) {
        tableViewModel.replaceSectionViewModel(at: headerView.section,
                                               with: headerView.viewModel!)
        tableView.reloadSections([headerView.section], with: .automatic)
    }
}

// MARK: - Navigation

extension TopicTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "web", let url = sender as? URL {
            let destVC = segue.destination as! WebViewController
            destVC.url = url
        }
    }
}



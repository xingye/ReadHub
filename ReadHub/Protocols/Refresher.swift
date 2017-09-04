//
//  Refresher.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/4.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit
import ESPullToRefresh

protocol Refresher {
    func loadMore(completion: @escaping (Error?, IndexSet) -> Void)
    func refresh(completion: @escaping (Error?) -> Void)
}

protocol Refreshable: class {
    var viewModel: Refresher {get}
}

extension Refreshable where Self: UITableViewController {
    func configureRefresher() {
        let header = ESRefreshHeaderAnimator(frame: .zero)
        let footer = ESRefreshFooterAnimator(frame: .zero)
        
        tableView.es_addPullToRefresh(animator: header) { [unowned self] in
            self.viewModel.refresh { error in
                if let err = error {
                    print(err)
                    return
                }
                self.tableView.es_stopPullToRefresh()
                self.tableView.reloadData()
            }
        }
        
        tableView.es_addInfiniteScrolling(animator: footer) { [unowned self] in
            self.viewModel.loadMore { error, sections in
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


//
//  NewsTableViewModel.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/1.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

class BasicNewsTableViewModel {
    var news: [NewsProvider] = []
    
    func load(completeion: @escaping (Error?) -> Void) {
        fatalError("Must be implemented by subclass")
    }
    
    func url(at indexPath: IndexPath) -> URL? {
        let url = try? news[indexPath.row].url?.asURL()
        return url?.flatMap{ $0 }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = NewsViewModel(provider: news[indexPath.row])
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewsCell
        cell.configureWith(viewModel: cellModel)
        
        return cell
    }
}

class NewsTableViewModel: BasicNewsTableViewModel {
    var loader: DataLoader<News>
    
    override init() {
        self.loader = DataLoader<News>(filter: nil)
        super.init()
    }
    
    override func load(completeion: @escaping (Error?) -> Void) {
        loader.load { (result) in
            switch result {
            case .success(let news):
                self.news = news
                completeion(nil)
                
            case .failure(let error):
                completeion(error)
            }
        }
    }
}

class TechNewsTableViewModel: BasicNewsTableViewModel {
    var loader: DataLoader<TechNews>
    
    override init() {
        loader = DataLoader<TechNews>(filter: nil)
        super.init()
    }
    
    override func load(completeion: @escaping (Error?) -> Void) {
        loader.load { (result) in
            switch result {
            case .success(let news):
                self.news = news
                completeion(nil)
                
            case .failure(let error):
                completeion(error)
            }
        }
    }
}







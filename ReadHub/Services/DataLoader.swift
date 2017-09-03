//
//  DataLoader.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 12/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

let baseUrl = "https://api.readhub.me/"

enum Result<T> {
    case failure(Error)
    case success(T)
}

class DataLoader<T: Mappable> {
    
    private enum DataType {
        case topic
        case news
        case techNews
        case unknow
    }
    
    typealias Callback = (Result<[T]>) -> Void
    
    public  var pageSize = 20
    private var lastCursor: Int?
    private let type: DataType
    
    private var url: String {
        var path = ""
        switch self.type {
        case .topic:
            path = "topic"
        case .news:
            path = "news"
        case .techNews:
            path = "technews"
        case .unknow:
            fatalError()
        }
        
        var url = baseUrl + path + "?pageSize=\(pageSize)"
        if type == .topic {
            if let cursor = lastCursor {
                url += "&lastCursor=\(cursor)"
            } else {
                url += "&lastCursor=@null"
            }
        } else {
            if let cursor = lastCursor {
                url += "&lastCursor=\(cursor - 10 * 60 * 1000)"
            } else {
                lastCursor = Int(Date().timeIntervalSince1970 * 1000)
                url += "lastCursor=\(String(describing: lastCursor))"
            }
            
        }
        
        return url
    }
    
    private var filter: (([T]) -> [T])?
    
    init(filter: (([T]) -> [T])?) {
        let genericType = String(describing: type(of: T.self))
                          .components(separatedBy: ".")
                          .dropLast()
                          .joined(separator: ".")
        
        if genericType == String(describing: Topic.self) {
            self.type = .topic
            
        } else if genericType == String(describing: News.self) {
            self.type = .news
            
        } else if genericType == String(describing: TechNews.self) {
            self.type = .techNews
        } else {
            fatalError()
        }
        
        self.filter = filter
    }
    
    func load(completion: @escaping Callback) {
        Alamofire.request(url).responseObject { (response: DataResponse<ContentResponse<T>>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let value):
                if let result = value.data {
                    if let filter = self.filter {
                        completion(.success(filter(result)))
                    } else {
                        completion(.success(result))
                    }
                    
                    if let topics = result as? [Topic] {
                        self.lastCursor = topics.last?.order
                    }
                    
                } else {
                    completion(.success([]))
                }
                
                return
            }
        }
    }
    
    func nextPage(completion: @escaping Callback) {
        load(completion: completion)
    }
    
    func refresh(completion: @escaping Callback) {
        lastCursor = nil
        load(completion: completion)
    }
}



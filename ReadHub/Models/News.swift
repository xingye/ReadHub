//
//  News.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 11/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import Foundation
import ObjectMapper

struct News: Mappable {
    var id: String?
    var siteName: String?
    var authorName: String?
    var url: String?
    var summary: String?
    var title: String?
    var publishDate: Date?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        siteName    <- map["siteName"]
        authorName  <- map["authorName"]
        url         <- map["url"]
        summary     <- map["summary"]
        title       <- map["title"]
        publishDate <- (map["publishDate"], transform)
    }
}

struct TechNews: Mappable {
    var id: String?
    var siteName: String?
    var authorName: String?
    var url: String?
    var summary: String?
    var title: String?
    var publishDate: Date?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        siteName    <- map["siteName"]
        authorName  <- map["authorName"]
        url         <- map["url"]
        summary     <- map["summary"]
        title       <- map["title"]
        publishDate <- (map["publishDate"], transform)
    }
}

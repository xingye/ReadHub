//
//  Topic.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 11/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import Foundation
import ObjectMapper

let transform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
    return value?.dateFromISO8601
}, toJSON: { (value: Date?) -> String? in
    return value?.iso8601
})

struct TopicItem: Mappable {
    
    var id: String?
    var url: String?
    var title: String?
    var groupId: Int?
    var siteName: String?
    var mobileUrl: String?
    var authorName: String?
    var duplicateId: Int?
    var publishDate: Date?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        url         <- map["url"]
        title       <- map["title"]
        groupId     <- map["groupId"]
        siteName    <- map["siteName"]
        mobileUrl   <- map["mobileUrl"]
        authorName  <- map["authorName"]
        duplicateId <- map["duplicateId"]
        publishDate <- (map["publishDate"], transform)//DateFormatterTransform(dateFormatter: Formatter.iso8601)
    }
}

struct RelatedTopicItem: Mappable {
    var id: Int?
    var title: String?
    var url: String?
    var mobileUrl: String?
    var sources: [Source]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        url         <- map["url"]
        mobileUrl   <- map["mobileUrl"]
        sources     <- map["sources"]
    }
}

struct Source: Mappable {
    var name: String?
    var url: String?
    var mobileUrl: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        mobileUrl   <- map["mobileUrl"]
        url         <- map["url"]
        name        <- map["name"]
    }
}

struct RelatedTopic: Mappable {
    var entityId: Int?
    var entityName: String?
    var eventType: Int?
    var data: [RelatedTopicItem]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        entityId   <- map["entityId"]
        entityName <- map["entityName"]
        eventType  <- map["eventType"]
        data       <- map["data"]
    }
}

struct NelData: Mappable {
    var result: [RelatedTopic]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        result <- map["result"]
    }
}

struct Topic: Mappable {
    var id: String?
    var createdAt: Date?
    var newsArray: [TopicItem]?
    var order: Int?
    var publishDate: Date?
    var summary: String?
    var title: String?
    var updatedAt: Date?
    var entityRelatedTopics: [RelatedTopic]?
    var nelData: NelData?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        createdAt           <- (map["createdAt"], transform)
        newsArray           <- map["newsArray"]
        order               <- map["order"]
        publishDate         <- (map["publishDate"], transform)
        summary             <- map["summary"]
        title               <- map["title"]
        updatedAt           <- (map["updatedAt"], transform)
        entityRelatedTopics <- map["entityRelatedTopics"]
        nelData             <- map["nelData"]
    }
}










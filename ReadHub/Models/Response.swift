//
//  Response.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 11/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import Foundation
import ObjectMapper

struct ContentResponse<T: Mappable>: Mappable {
    var data: [T]?
    var pageSize: Int?
    var totalItems: Int?
    var totalPages: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data       <- map["data"]
        pageSize   <- map["pageSize"]
        totalItems <- map["totalItems"]
        totalPages <- map["totalPages"]
    }
}

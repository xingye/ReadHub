//
//  Date+iso8601.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 17/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import Foundation

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    func sinceNow() -> String {
        var timeString = "刚刚"
        let timeInterval = -timeIntervalSinceNow
        if Int(timeInterval / (24 * 60 * 60)) > 0 {
            timeString = "\(Int(timeInterval / (24 * 60 * 60)))天前"
        } else if Int(timeInterval / (60 * 60)) > 0 {
            timeString = "\(Int(timeInterval / (60 * 60)))小时前"
        } else if Int(timeInterval / 60) > 0 {
            timeString = "\(Int(timeInterval / 60))分钟前"
        }
        
        return timeString
    }
}

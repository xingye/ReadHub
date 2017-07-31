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
}

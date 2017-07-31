//
//  SectionHeaderViewModel.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 17/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

struct SectionHeaderViewModel {
    private var title: String?
    private var timeString: String?
    var sectionTitle: NSMutableAttributedString?
    private(set) var status: SectionHeaderView.SectionStatus = .collasp
    
    init(topic: Topic) {
        title = topic.title
        
        let timeInterval = Date().timeIntervalSince(topic.publishDate ?? Date())
        if Int(timeInterval / (24 * 60 * 60)) > 0 {
            timeString = "\(Int(timeInterval / (24 * 60 * 60)))天前"
        } else if Int(timeInterval / (60 * 60)) > 0 {
            timeString = "\(Int(timeInterval / (60 * 60)))小时前"
        } else if Int(timeInterval / 60) > 0 {
            timeString = "\(Int(timeInterval / 60))分钟前"
        }
        
        setSectionAttributeString()
    }
    
    mutating func nextStatus() {
        status = status.next()
    }
    
    private mutating func setSectionAttributeString() {
        guard let titleString = title else { return }
        
        let time = timeString ?? "1分钟前"
        sectionTitle = NSMutableAttributedString(string: titleString + "  " + time)
        
        let titleAttr = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1)]
        let timeAttr = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption2), NSForegroundColorAttributeName: UIColor.lightGray]
        let titleRange = NSMakeRange(0, (titleString as NSString).length)
        let timeRange = NSMakeRange((titleString as NSString).length + 2, (time as NSString).length)
        
        sectionTitle!.setAttributes(titleAttr, range: titleRange)
        sectionTitle!.setAttributes(timeAttr, range: timeRange)
    }
}

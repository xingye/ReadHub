//
//  TopicCellViewModel.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import Foundation

struct TopicCellViewModel {
    private var topic: TopicItem
    
    init(topic: TopicItem) {
        self.topic = topic
    }
    
    var title: String? {
        return topic.title
    }
    
    var source: String? {
        return topic.siteName
    }
}

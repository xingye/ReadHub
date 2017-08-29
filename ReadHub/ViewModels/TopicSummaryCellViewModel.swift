//
//  TopicSummaryCellViewModel.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

struct TopicSummaryCellViewModel {
    private var topic: Topic
    private(set) var height: CGFloat = 0.0
    
    init(topic: Topic) {
        self.topic = topic
        
    }
    
    var summary: String? {
        return topic.summary
    }
    
}

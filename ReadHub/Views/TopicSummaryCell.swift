//
//  TopicSummaryCell.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

class TopicSummaryCell: UITableViewCell {

    @IBOutlet weak var lblSummary: UILabel!
    
    func config(with viewModel: TopicSummaryCellViewModel) {
        lblSummary.text = viewModel.summary
        lblSummary.sizeToFit()
    }
    
    func cellHeight() -> CGFloat {
        let height = lblSummary.bounds.size.height + 8.0 * 2
        return height
    }
}

extension TopicSummaryCell: NibCreateable, Reuseable {}

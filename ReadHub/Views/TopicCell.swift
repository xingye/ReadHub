//
//  TopicCell.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    func config(with viewModel: TopicCellViewModel) {
        lblTitle.text = viewModel.title
        lblSource.text = viewModel.source
    }
}

extension TopicCell: NibCreateable, Reuseable {}

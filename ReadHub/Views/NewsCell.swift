//
//  NewsCell.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/1.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configureWith(viewModel: NewsViewModel) {
        lblTitle.text = viewModel.title
        lblSummary.text = viewModel.summary
        lblProfile.text = viewModel.profile
    }
}

extension NewsCell: Reuseable, NibCreateable {}

//
//  SectionHeaderView.swift
//  ReadHub
//
//  Created by Liang, Yangxing on 31/7/2017.
//  Copyright © 2017 Liang, Yangxing. All rights reserved.
//

import UIKit

protocol SectionHeaderViewDelegate: class {
    func sectionHeaderViewDidTap(_ headerView: SectionHeaderView)
}

class SectionHeaderView: UITableViewHeaderFooterView {
    
    enum SectionStatus {
        case collasp
        case open
        
        func next() -> SectionStatus {
            switch self {
            case .collasp:
                return .open
            
            case .open:
                return .collasp
            }
        }
    }

    @IBOutlet weak var lblTitle: UILabel!
    
    private(set) var height: CGFloat = 0.0
    
    var viewModel: SectionHeaderViewModel? {
        willSet {
            guard let model = newValue, let title = model.sectionTitle else {
                return
            }
            
            lblTitle.attributedText = title
            lblTitle.sizeToFit()
            
//            let size = CGSize(width: lblTitle.bounds.size.width, height: 999.0)
//            height = (lblTitle.attributedText!.string as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName], context: nil)
            height = lblTitle.bounds.size.height + 8.0
            
        }
    }
    
    weak var delegate: SectionHeaderViewDelegate?
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        viewModel?.nextStatus()
        delegate?.sectionHeaderViewDidTap(self)
    }
}


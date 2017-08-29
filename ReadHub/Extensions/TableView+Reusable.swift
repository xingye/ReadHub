//
//  TableView+Reusable.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reuseable, T: NibCreateable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reuseable, T: NibCreateable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T
        where T: UITableViewCell, T: Reuseable {
            guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
                as? T else {
                    fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            }
            
            return cell
    }
}

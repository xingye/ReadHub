//
//  Storyboardable.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/13.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

protocol Storyboardable: class {}

enum Storyboard: String {
    case main = "Main"
}

extension Storyboardable where Self: UIViewController {
    static func instantiate(from storyboard: Storyboard = .main, bundle: Bundle? = nil) -> Self {
        let identifier = String(describing: Self.self)
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let vc = sb.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Could not initialize view controller with \(identifier)")
        }

        return vc
    }
}

extension UIViewController: Storyboardable{}

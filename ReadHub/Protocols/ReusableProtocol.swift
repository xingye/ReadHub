//
//  ReusableProtocol.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/12.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit

protocol Reuseable: class {
    static var reuseIdentifier: String { get }
}

protocol NibCreateable: class {
    static var nibName: String { get }
}

extension Reuseable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension NibCreateable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

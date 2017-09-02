//
//  URLConvertable.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/13.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import Foundation

protocol URLConvertable {
    func asURL() throws -> URL
}

extension String: URLConvertable {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw NSError(domain: "Invalid URL", code: 1000)
        }
        return url
    }
}

extension URL: URLConvertable {
    func asURL() throws -> URL {
        return self
    }
}

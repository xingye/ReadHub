//
//  NewsViewModel.swift
//  ReadHub
//
//  Created by 星爷 on 2017/9/1.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import Foundation

protocol NewsProvider {
    var title: String? { get }
    var summary: String? { get }
    var siteName: String? { get }
    var authorName: String? { get }
    var publishDate: Date? { get }
    var url: String? { get }
}

extension News: NewsProvider{}
extension TechNews: NewsProvider{}

struct NewsViewModel {
    var title: String
    var summary: String
    var profile: String
    
    init(provider: NewsProvider) {
        title = provider.title ?? ""
        summary = provider.summary ?? ""
        profile = NewsViewModel.constructProfile(from: provider)
    }
    
    private static func constructProfile(from provider: NewsProvider) -> String {
        var profile = provider.siteName ?? "Unknow"
        if let name = provider.authorName {
            profile = profile + "/" + name
        }
        profile += "   " + (provider.publishDate ?? Date()).sinceNow()
        return profile
    }
}








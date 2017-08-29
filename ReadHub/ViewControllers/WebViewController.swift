//
//  WebViewController.swift
//  ReadHub
//
//  Created by 星爷 on 2017/8/13.
//  Copyright © 2017年 Liang, Yangxing. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url: URLConvertable? {
        didSet {
            guard let aUrl = url, let path = try? aUrl.asURL() else {
                return
            }
            
            print(view)
            
            let request = URLRequest(url: path)
            webView.load(request)
        }
    }
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = true
        
        configWebView()
    }

    private func configWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }
}



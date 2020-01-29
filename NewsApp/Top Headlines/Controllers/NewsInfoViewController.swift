//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import WebKit

class NewsInfoViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    // Properties
    var webURLString = ""
    

    override func loadView() {
        super.loadView()
        
        // Setup the webView Configuration
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.allowsInlineMediaPlayback = false
        webViewConfig.mediaTypesRequiringUserActionForPlayback = .all
        
        // Setup the webView with the configuration
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check url
        guard let url = URL(string: webURLString) else { return }
        
        // Create request
        let urlRequest = URLRequest(url: url)
        
        // load the request and display the contents
        DispatchQueue.main.async {
            self.webView.load(urlRequest)
        }
        
    }
    

}

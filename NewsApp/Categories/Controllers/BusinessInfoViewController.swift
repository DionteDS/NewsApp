//
//  BusinessInfoViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/28/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import WebKit

class BusinessInfoViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    
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

        // Check the url
        guard let url = URL(string: webURLString) else { return }
        
        // Create the request
        let urlRequest = URLRequest(url: url)
        
        // Load the web page with the request
        DispatchQueue.main.async {
            self.webView.load(urlRequest)
        }
        
    }
    
    

}

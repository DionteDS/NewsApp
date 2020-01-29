//
//  enterainmentWebVCViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/29/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import WebKit

class EnterainmentWebVCViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    var webURLString = ""
    
    override func loadView() {
        super.loadView()
        
        // Setup the webView configuration
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.allowsInlineMediaPlayback = false
        webViewConfig.mediaTypesRequiringUserActionForPlayback = .all
        
        // Set the webView with the config
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.uiDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if the url is nil
        guard let url = URL(string: webURLString) else { return }
        
        // Create the request
        let urlRequest = URLRequest(url: url)
        
        // Load the website on the main thread
        DispatchQueue.main.async {
            self.webView.load(urlRequest)
        }
        
    }

}

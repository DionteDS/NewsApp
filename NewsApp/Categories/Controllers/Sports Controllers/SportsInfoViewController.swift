//
//  SportsInfoViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/31/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import WebKit

class SportsInfoViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    var webURLString = ""

    override func loadView() {
        super.loadView()
        
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.allowsInlineMediaPlayback = false
        webViewConfig.mediaTypesRequiringUserActionForPlayback = .all
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if url is nil
        guard let url = URL(string: webURLString) else { return }
        
        // Create the request
        let urlRequest = URLRequest(url: url)
        
        // Display contents on the main thread
        DispatchQueue.main.async {
            self.webView.load(urlRequest)
        }
        
    }
    

}

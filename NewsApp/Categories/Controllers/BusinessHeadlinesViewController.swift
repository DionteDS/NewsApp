//
//  BusinessHeadlinesViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BusinessHeadlinesViewController: UIViewController {
    
    @IBOutlet weak var businessTableView: UITableView!
    
    
    let baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var businessHeadlines: [[String: Any]] = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Networking calls
    
    public func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
    }
    
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseNews = responseValue["articles"] as! [[String: Any]]? {
                    self.businessHeadlines = responseNews
                    self.businessTableView.reloadData()
                }
                
            } else {
                print(response.error!)
            }
            
        }
        
    }
}


//MARK: - TableView Delegate and DataSource Methods

extension BusinessHeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
        
    }
    
    
}

//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/25/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    
    // Properties
    let baseURLForTopHeadLines = "https://newsapi.org/v2/top-headlines"
    var newsTopics: [[String: Any]] = [[String: Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Top Headlines"

        // Create nib for news tableViewCell
        // And register the nib
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsCell")
        
        setQuery()
        
    }
    
    //MARK: - Networking Functions
    
    func setQuery() {
        
        let params: [String: String] = ["country": "us", "apiKey": APIKEY, "pageSize": "10"]
        
        fetchData(url: baseURLForTopHeadLines, parameters: params)
        
    }
    
    func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseNewsTopics = responseValue["articles"] as! [[String: Any]]? {
//                    print(responseNewsTopics)
                    self.newsTopics = responseNewsTopics
                    self.newsTableView.reloadData()
                }
                
            }
            
//            if response.result.isSuccess {
//                print("Got Data")
//                print(JSON(response.result.value!))
//
//                let jsonData: JSON = JSON(response.result.value!)
//
//
//            } else {
//                print("Error \(response.error!)")
//            }
            
        }
        
    }

}

// MARK: - TableView Delegate and DataSource Methods
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        // Store each news article
        let eachArticle = self.newsTopics[indexPath.row]
        
        // Get the source name
        let eachSource = eachArticle["source"] as! [String: Any]
        
        // Display the title and source in the cell labels
        cell.newsTitle.text = (eachArticle["title"] as? String ?? "")
        cell.newsSource.text = (eachSource["name"] as? String ?? "")
        
        return cell
        
    }
    
    // Row height for cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    
    
    
}

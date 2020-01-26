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
    var newsTopics: [String: String] = [String: String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create nib for news tableViewCell
        // And register the nib
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsCell")
        
    }
    
    
    func setQuery() {
        
        
    }

}

// MARK: - TableView Delegate and DataSource Methods
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.newsTitle.text = "Title"
        cell.newsSource.text = "Source"
        cell.newsImg.image = UIImage(named: "newsImage")
        
        return cell
        
    }
    
    // Row height for cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    
    
    
}

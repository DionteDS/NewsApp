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
    private let baseURLForTopHeadLines = "https://newsapi.org/v2/top-headlines"
    private var newsTopics: [[String: Any]] = [[String: Any]]()
    private var row = 0
//    private let APIKEY = "Place your api key here"
    
    private var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        view.backgroundColor = UIColor.gray
        
        setupRefreshControl()
        
        
        // Create nib for news tableViewCell
        // And register the nib
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsCell")
        
        newsTableView.backgroundColor = UIColor.gray
        
        newsTableView.separatorStyle = .none
        
        
        newsTableView.tableFooterView = UIView.init(frame: .zero)
        
        setQuery()
        
    }
    
    private func setupNavBar() {
        
        // Navigation bar setup
        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Top Headlines"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    private func setupRefreshControl() {
        
        // If user is on iOS version 10.0 add the refreshControl to the
        // newsTableView.refreshControl property
        // Else add the refreshControl to the newsTableView SubView
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControl
        } else {
            newsTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching news data", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan])
        
    }
    
    @objc private func updateList() {
        
        setQuery()
        refreshControl.endRefreshing()
        
    }
    
    //MARK: - Networking Functions
    
    private func setQuery() {
        
        let params: [String: String] = ["country": "us", "apiKey": APIKEY, "pageSize": "10"]
        
        fetchData(url: baseURLForTopHeadLines, parameters: params)
        
    }
    
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseNewsTopics = responseValue["articles"] as! [[String: Any]]? {
                    self.newsTopics = responseNewsTopics
                    self.newsTableView.reloadData()
                }
            } else {
                print(response.error!)
            }
            
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
        
        // Call customDesign to set the border for each cell
        cell.customDesign()
        
        // Set the label colors to white
        cell.newsSource.textColor = UIColor.white
        cell.newsTitle.textColor = UIColor.white
        
        // Store each news article
        let eachArticle = self.newsTopics[indexPath.row]
        
        // Get the source name
        let eachSource = eachArticle["source"] as! [String: Any]
        
        
        // Get the image for the article
        if let imageURL = eachArticle["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    // Scale the image to 100 x 100
                    // With an Aspect Scaled Fill
                    let size = CGSize(width: 100, height: 100)
                    let scaledImage = image.af_imageAspectScaled(toFill: size)
                    // Set image on main thread
                    DispatchQueue.main.async {
                        // Display the title and source in the cell labels
                        cell.newsTitle.text = (eachArticle["title"] as? String ?? "")
                        cell.newsSource.text = (eachSource["name"] as? String ?? "")
                        cell.newsImg.image = scaledImage
                    }
                } else {
                    print(response.error!)
                }
            }
        }
        
        return cell
        
    }
    
    // Select a news article to gets info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the selected news article indexPath row
        if let rowIndex = tableView.indexPathForSelectedRow?.row {
            row = rowIndex
        }
        
        performSegue(withIdentifier: "newsInfo", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Row height for cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    // Prepare the contents for the NewsInfoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newsInfo" {
            let controller = segue.destination as! NewsInfoViewController
            
            // Grab the selected news article url
            let eachArticle = newsTopics[row]
            let newsURLString = (eachArticle["url"] as? String ?? "")
            controller.webURLString = newsURLString
        }
        
    }
    
    
}

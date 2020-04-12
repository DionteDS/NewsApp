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
    
//    private let APIKEY = "Place your api key here"
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var businessHeadlines: [[String: Any]] = [[String: Any]]()
    
    private var row = 0
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor.gray
        
        setupNavBar()
        
        setupRefreshControl()
        
        let nib = UINib(nibName: "BusinessTableViewCell", bundle: nil)
        businessTableView.register(nib, forCellReuseIdentifier: "businessCell")
        businessTableView.backgroundColor = UIColor.gray
        businessTableView.separatorStyle = .none
        
    }
    
    private func setupRefreshControl() {
        
        // If user is on iOS version 10.0 add the refreshControl to the
        // newsTableView.refreshControl property
        // Else add the refreshControl to the newsTableView SubView
        if #available(iOS 10.0, *) {
            businessTableView.refreshControl = refreshControl
        } else {
            businessTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data", attributes: [NSAttributedString.Key.foregroundColor : UIColor.cyan])
    }
    
    @objc private func updateList() {
        
        setQuery(category: "business")
        refreshControl.endRefreshing()
        
    }
    
    private func setupNavBar() {
        // Navigation bar setup
       navigationItem.title = "Business"
       
       navigationItem.largeTitleDisplayMode = .always
        
       navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
        return businessHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! BusinessTableViewCell
        
        cell.customDesign()
        
        cell.newsTitle.textColor = UIColor.white
        cell.newsSource.textColor = UIColor.white
        
        let eachBusinessArticle = self.businessHeadlines[indexPath.row]
        
        let getSource = eachBusinessArticle["source"] as! [String: Any]
        
        if let imageURL = eachBusinessArticle["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 100, height: 100)
                    let scaleImage = image.af_imageAspectScaled(toFill: size)
                    
                    // Display the contents on the main thread
                    DispatchQueue.main.async {
                        cell.newsTitle.text = (eachBusinessArticle["title"] as? String ?? "")
                        cell.newsSource.text = (getSource["name"] as? String ?? "")
                        cell.newsImg.image = scaleImage
                    }
                } else {
                    print(response.error!)
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let rowIndex = tableView.indexPathForSelectedRow?.row {
            row = rowIndex
        }
        
        performSegue(withIdentifier: "goToBusinessURLs", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToBusinessURLs" {
            let controller = segue.destination as! BusinessInfoViewController
            
            let eachBusinessArticle = businessHeadlines[row]
            
            let url = (eachBusinessArticle["url"] as? String ?? "")
            
            controller.webURLString = url
        }
    }
    
}

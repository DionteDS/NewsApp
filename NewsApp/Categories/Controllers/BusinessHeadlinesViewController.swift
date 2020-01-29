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
    
    var businessHeadlines: [[String: Any]] = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar setup
        navigationItem.title = "Business"
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = UIColor.gray
        businessTableView.backgroundColor = UIColor.gray
        
        let nib = UINib(nibName: "BusinessTableViewCell", bundle: nil)
        businessTableView.register(nib, forCellReuseIdentifier: "businessCell")
        
        businessTableView.separatorStyle = .none
        
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
        
        cell.newsTitle.text = (eachBusinessArticle["title"] as? String ?? "")
        cell.newsSource.text = (getSource["name"] as? String ?? "")
        
        if let imageURL = eachBusinessArticle["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 100, height: 100)
                    let scaleImage = image.af_imageAspectScaled(toFill: size)
                    DispatchQueue.main.async {
                        cell.newsImg.image = scaleImage
                    }
                } else {
                    print(response.error!)
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    
}

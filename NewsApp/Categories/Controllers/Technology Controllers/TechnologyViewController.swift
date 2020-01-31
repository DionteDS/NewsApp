//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/31/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TechnologyViewController: UIViewController {
    
    @IBOutlet weak var techCollectionView: UICollectionView!
    
    private var baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var techNews: [[String: Any]] = [[String: Any]]()
    
    private var row = 0
    
    private var layout = UICollectionViewFlowLayout()
    
    private var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        techCollectionView.backgroundColor = UIColor.gray
        
        setupNavbar()
        
        setupLayout()
        
        let nib = UINib(nibName: "TechCollectionViewCell", bundle: nil)
        techCollectionView.register(nib, forCellWithReuseIdentifier: "techCell")
        
    }
    
    // Setup the navbar
    private func setupNavbar() {
        
        navigationItem.title = "Technology"
        
        navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // Setup the flow layout
    private func setupLayout() {
        
        let collecitonViewSizeWidth = techCollectionView.frame.size.width
        let collectionViewSizeHeight = techCollectionView.frame.size.height
        
        layout.itemSize = CGSize(width: collecitonViewSizeWidth - 92, height: collectionViewSizeHeight - 518)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        
        techCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    //MARK: - Network Calls
    
    // Set the search query
    func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
        
    }
    
    // Fetch data
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let techNewsArticles = responseValue["articles"] as! [[String: Any]]? {
                    self.techNews = techNewsArticles
                    self.techCollectionView.reloadData()
                }
            } else {
                print(response.error!)
            }
        }
        
    }
    

}


//MARK: - CollectionView Delegate and DataSource Methods

extension TechnologyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "techCell", for: indexPath) as! TechCollectionViewCell
        
        cell.designBorderBackground()
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        // Hold each article
        let articles = techNews[indexPath.row]
        
        // Grab the source to each article
        let source = articles["source"] as! [String: Any]
        
        // Grab the image url
        if let imageURL = articles["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 322, height: 128)
                    let scaledImage = image.af_imageAspectScaled(toFill: size)
                    
                    // Display the contents on the main thread
                    DispatchQueue.main.async {
                        cell.titleLabel.text = (articles["title"] as? String ?? "")
                        cell.sourceLabel.text = (source["name"] as? String ?? "")
                        cell.imgView.image = scaledImage
                    }
                }
            }
        }
        
        return cell
        
    }
    
    
}

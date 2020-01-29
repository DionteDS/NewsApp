//
//  EnterainmentViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/29/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EnterainmentViewController: UIViewController {

    @IBOutlet weak var enterainmentCollectionView: UICollectionView!
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var layout = UICollectionViewFlowLayout()
    
    private var enterainmentNews: [[String: Any]] = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        enterainmentCollectionView.backgroundColor = UIColor.gray
        
        setupNavBar()
        
        // Create and register the custom collectionViewCell
        let nib = UINib(nibName: "EnterainmentCollectionViewCell", bundle: nil)
        enterainmentCollectionView.register(nib, forCellWithReuseIdentifier: "enterainmentCell")
        
        setupLayout()
        
    }
    
    private func setupNavBar() {
       // Navigation bar setup
       navigationItem.title = "Entertainment"
       navigationController?.navigationBar.tintColor = UIColor.white
       navigationItem.largeTitleDisplayMode = .always
       navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // Setup the flowlayout
    private func setupLayout() {
        
        let collectionViewSizeWidth = enterainmentCollectionView.frame.size.width
        let collectionViewSizeHeight = enterainmentCollectionView.frame.size.height
        
        layout.itemSize = CGSize(width: collectionViewSizeWidth - 92, height: collectionViewSizeHeight - 518)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        
        enterainmentCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    //MARK: - Network calls
    
    // Set the search query
    public func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
        
    }
    
    // Fetch data
    func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseNews = responseValue["articles"] as! [[String: Any]]? {
                    self.enterainmentNews = responseNews
                    self.enterainmentCollectionView.reloadData()
                }
            } else {
                print(response.error!)
            }
        }
        
    }
}



// MARK: - CollectionView Delegate and DataSource Methods

extension EnterainmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enterainmentNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "enterainmentCell", for: indexPath) as! EnterainmentCollectionViewCell
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        
        // Grab each article
        let eachArticle = enterainmentNews[indexPath.row]
        
        // Grab the source
        let newsSource = eachArticle["source"] as! [String: Any]
        
        
        // Grab the url to the image
        if let imageURL = eachArticle["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 322, height: 123)
                    let imageScaled = image.af_imageAspectScaled(toFill: size)
                    
                    // Display the contents on the main thread
                    DispatchQueue.main.async {
                        cell.titleLabel.text = (eachArticle["title"] as? String ?? "")
                        cell.sourceLabel.text = (newsSource["name"] as? String ?? "")
                        cell.imgView.image = imageScaled
                    }
                } else {
                    print(response.error!)
                }
            }
        }
        
        
        return cell
        
    }
    
}

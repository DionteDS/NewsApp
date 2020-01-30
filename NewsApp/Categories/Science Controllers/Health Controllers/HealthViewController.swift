//
//  HealthViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/29/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HealthViewController: UIViewController {
    
    @IBOutlet weak var healthCollectionView: UICollectionView!
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var healthNews: [[String: Any]] = [[String: Any]]()
    
    private var layout = UICollectionViewFlowLayout()
    
    private var refreshControl = UIRefreshControl()
    
    private var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        setupRefreshControl()
        
        let nib = UINib(nibName: "HealthCollectionViewCell", bundle: nil)
        healthCollectionView.register(nib, forCellWithReuseIdentifier: "healthCell")
        healthCollectionView.backgroundColor = UIColor.gray

        setupNavBar()
        
        setupLayout()
        
    }
    
    // Setup the refreshControl
    private func setupRefreshControl() {
        
        // If user is on iOS version 10.0 add the refreshControl to the
        // newsTableView.refreshControl property
        // Else add the refreshControl to the newsTableView SubView
        if #available(iOS 10.0, *) {
            healthCollectionView.refreshControl = refreshControl
        } else {
            healthCollectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data", attributes: [NSAttributedString.Key.foregroundColor : UIColor.cyan])
        
    }
    
    @objc private func updateList() {
        
        setQuery(category: "health")
        refreshControl.endRefreshing()
        
    }
    
    // Setup NavBar
    private func setupNavBar() {
        
       // Navigation bar setup
       navigationItem.title = "Health"
        
       navigationController?.navigationBar.tintColor = UIColor.white
        
       navigationItem.largeTitleDisplayMode = .always
        
       navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // Setup the collectionView flowlayout
    private func setupLayout() {
        
        let collectionViewSizeWidth = healthCollectionView.frame.size.width
        let collectionViewSizeHeight = healthCollectionView.frame.size.height
        
        layout.itemSize = CGSize(width: collectionViewSizeWidth - 92, height: collectionViewSizeHeight - 518)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        
        healthCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    //MARK: - Network calls
    
    // Set the search query
    public func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
        
    }
    
    // Fetch the data
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseHealthNews = responseValue["articles"] as! [[String: Any]]? {
                    self.healthNews = responseHealthNews
                    self.healthCollectionView.reloadData()
                }
            }
        }
        
    }

}

//MARK: - CollectionView Delegate and DataSource Methods

extension HealthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthCell", for: indexPath) as! HealthCollectionViewCell
        
        cell.designBorderBackground(radius: 10, borderColor: .gray, shadowColor: .black)
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        
        let healthNewsArticle = healthNews[indexPath.row]
        
        let healthSource = healthNewsArticle["source"] as! [String: Any]
        
        // Grab the image url to the article
        if let imageURL = healthNewsArticle["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 322, height: 123)
                    let scaledImage = image.af_imageAspectScaled(toFill: size)
                    
                    // Display the contents on the main thread
                    DispatchQueue.main.async {
                        cell.titleLabel.text = (healthNewsArticle["title"] as? String ?? "")
                        cell.sourceLabel.text = (healthSource["name"] as? String ?? "")
                        cell.imgView.image = scaledImage
                    }
                }
            }
        }
        return cell
    }
    
    // Tapp a cell to segue over to it
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let rowIndex = collectionView.indexPathsForSelectedItems?.first {
            row = rowIndex.row
        }
        
        performSegue(withIdentifier: "healthWebViewVC", sender: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    // Prepare the data to be sent over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "healthWebViewVC" {
            let controller = segue.destination as! HealthInfoViewController
            
            let eachArticle = healthNews[row]
            
            let url = eachArticle["url"] as? String ?? ""
            
            controller.webURLString = url
        }
        
    }
    
    
}

//
//  ScienceViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/30/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ScienceViewController: UIViewController {
    
    @IBOutlet weak var scienceCollectionView: UICollectionView!
    
    private var baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var scienceNews: [[String: Any]] = [[String: Any]]()
    
    private var layout = UICollectionViewFlowLayout()
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        scienceCollectionView.backgroundColor = UIColor.gray
        
        setupNavBar()
        
        setupRefreshControl()

        setupLayout()
        
        let nib = UINib(nibName: "ScienceCollectionViewCell", bundle: nil)
        scienceCollectionView.register(nib, forCellWithReuseIdentifier: "scienceCell")
        
    }
    
    //MARK: -  Network calls
    
    // Set the search query
    public func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
        
    }
    
    // Fetch the data
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseNews = responseValue["articles"] as! [[String: Any]]? {
                    self.scienceNews = responseNews
                    self.scienceCollectionView.reloadData()
                }
            } else {
                print(response.error!)
            }
            
        }
        
    }
    
    // Setup navbar
    private func setupNavBar() {
        
        navigationItem.title = "Science"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    // Setup flowlayout
    private func setupLayout() {
        
        let collectionViewSizeWidth = scienceCollectionView.frame.size.width
        let collectionViewSizeHeight = scienceCollectionView.frame.size.height
        
        layout.itemSize = CGSize(width: collectionViewSizeWidth - 92, height: collectionViewSizeHeight - 518)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        
        scienceCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupRefreshControl() {
        
        // If user is on iOS version 10.0 add the refreshControl to the
        // newsTableView.refreshControl property
        // Else add the refreshControl to the newsTableView SubView
        if #available(iOS 10.0, *) {
            scienceCollectionView.refreshControl = refreshControl
        } else {
            scienceCollectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data", attributes: [NSAttributedString.Key.foregroundColor : UIColor.cyan])
        
    }
    
    @objc private func updateList() {
        
        setQuery(category: "science")
        refreshControl.endRefreshing()
    }

}

//MARK: - CollectionView Delegate and DataSource Methods

extension ScienceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scienceNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scienceCell", for: indexPath) as! ScienceCollectionViewCell
        
        cell.designBorderBackground()
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        // Grab each science news article
        let scienceNewsArticles = scienceNews[indexPath.row]
        
        // Grab each source and turn into a dictonary
        let sourceNews = scienceNewsArticles["source"] as! [String: Any]
        
        // Grab the url to the article image
        if let imageURL = scienceNewsArticles["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 322, height: 128)
                    let scaledImage = image.af_imageAspectScaled(toFill: size)
                    
                    // Display content back on main thread
                    DispatchQueue.main.async {
                        cell.titleLabel.text = (scienceNewsArticles["title"] as? String ?? "")
                        cell.sourceLabel.text = (sourceNews["name"] as? String ?? "")
                        cell.imgView.image = scaledImage
                    }
                } else {
                    print(response.error!)
                }
            }
        }
        
        return cell
        
    }
    
    
}

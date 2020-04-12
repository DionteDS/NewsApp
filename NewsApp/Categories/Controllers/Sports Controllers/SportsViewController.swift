//
//  SportsViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/31/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SportsViewController: UIViewController {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
//    private let APIKEY = "Place your api key here"
    
    private var baseURL = "https://newsapi.org/v2/top-headlines"
    
    private var sportsNews: [[String: Any]] = [[String: Any]]()
    
    private var layout = UICollectionViewFlowLayout()
    
    private var row = 0
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        sportsCollectionView.backgroundColor = UIColor.gray

        setNavbar()
        
        setupRefreshControl()
        
        setupLayout()
        
        // Create and register the nib file
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: "sportsCell")
        
    }
    
    
    // Setup the navBar
    private func setNavbar() {
        
        navigationItem.title = "Sports"
        
        navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    
    // Setup the flow layout
    private func setupLayout() {
        
        let collectionViewSizeWidth = sportsCollectionView.frame.size.width
        let collectionViewSizeHeight = sportsCollectionView.frame.size.height
        
        layout.itemSize = CGSize(width: collectionViewSizeWidth - 92, height: collectionViewSizeHeight - 518)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        
        sportsCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    // Setup the refreshControl
    private func setupRefreshControl() {
        
        // If user is on iOS version 10.0 add the refreshControl to the
        // newsTableView.refreshControl property
        // Else add the refreshControl to the newsTableView SubView
        if #available(iOS 10.0, *) {
            sportsCollectionView.refreshControl = refreshControl
        } else {
            sportsCollectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data", attributes: [NSAttributedString.Key.foregroundColor : UIColor.cyan])
        
    }
    
    @objc private func updateList() {
        
        setQuery(category: "sports")
        refreshControl.endRefreshing()
        
    }
    
    //MARK: - Network Calls
    
    // Set the search query
    public func setQuery(category: String) {
        
        let params: [String: String] = ["apiKey": APIKEY, "category": category, "country": "us", "pageSize": "10"]
        
        fetchData(url: baseURL, parameters: params)
    }
    
    // Fetch the data
    private func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let sportsResponseNews = responseValue["articles"] as! [[String: Any]]? {
                    self.sportsNews = sportsResponseNews
                    self.sportsCollectionView.reloadData()
                }
            } else {
                print(response.error!)
            }
        }
        
    }

}

//MARK: - CollectionView Delegate and DataSource

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as! SportsCollectionViewCell
        
        cell.designBorderBackground()
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        let sportTopics = sportsNews[indexPath.row]
        
        let source = sportTopics["source"] as! [String: Any]
        
        // Grab the image url
        if let imageURL = sportTopics["urlToImage"] as? String {
            Alamofire.request(imageURL).responseImage { (response) in
                if let image = response.result.value {
                    let size = CGSize(width: 322, height: 128)
                    let scaledImage = image.af_imageAspectScaled(toFill: size)
                    
                    // Display the contents on the main thread
                    cell.titleLabel.text = (sportTopics["title"] as? String ?? "")
                    cell.sourceLabel.text = (source["name"] as? String ?? "")
                    cell.imgView.image = scaledImage
                }
            }
        }
        
        return cell
        
    }
    
    // Select a cell to segue too
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let rowIndex = collectionView.indexPathsForSelectedItems?.first {
            row = rowIndex.row
        }
        
        performSegue(withIdentifier: "goToSportsWebViewVC", sender: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    // Preapre the data to be sent over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSportsWebViewVC" {
            let controller = segue.destination as! SportsInfoViewController
            
            let article = sportsNews[row]
            
            let url = article["url"] as? String ?? ""
            
            controller.webURLString = url
        }
    }
    
}

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
    
    private var sportsNews: [[String: Any]] = [[String: Any]]()
    
    private var row = 0
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        sportsCollectionView.backgroundColor = UIColor.gray

        setNavbar()
        
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
    

}

//MARK: - CollectionView Delegate and DataSource

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as! SportsCollectionViewCell
        
        cell.designBorderBackground()
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        cell.titleLabel.text = "Title"
        cell.sourceLabel.text = "Source"
        
        return cell
        
    }
    
    
}

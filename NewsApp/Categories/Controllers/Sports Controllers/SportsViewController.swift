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
    
    private var layout = UICollectionViewFlowLayout()
    
    private var row = 0
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        sportsCollectionView.backgroundColor = UIColor.gray

        setNavbar()
        
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

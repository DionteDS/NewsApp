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
    
    private var healthNews: [[String: Any]] = [[String: Any]]()
    
    private var layout = UICollectionViewFlowLayout()
    
    private var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        let nib = UINib(nibName: "HealthCollectionViewCell", bundle: nil)
        healthCollectionView.register(nib, forCellWithReuseIdentifier: "healthCell")
        healthCollectionView.backgroundColor = UIColor.gray

        setupNavBar()
        
        setupLayout()
        
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
    
    func setQuery(category: String) {
        
        
        
    }

}

//MARK: - CollectionView Delegate and DataSource Methods

extension HealthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthCell", for: indexPath) as! HealthCollectionViewCell
        
        cell.designBorderBackground(radius: 10, borderColor: .gray, shadowColor: .black)
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        cell.titleLabel.text = "Title"
        cell.sourceLabel.text = "Source"
        
        
        return cell
    }
    
    
}

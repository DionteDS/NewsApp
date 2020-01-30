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
    
    private var scienceNews: [[String: Any]] = [[String: Any]]()
    
    private var layout = UICollectionViewFlowLayout()
    
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        scienceCollectionView.backgroundColor = UIColor.gray
        
        setupNavBar()

        setupLayout()
        
        let nib = UINib(nibName: "ScienceCollectionViewCell", bundle: nil)
        scienceCollectionView.register(nib, forCellWithReuseIdentifier: "scienceCell")
        
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

}

//MARK: - CollectionView Delegate and DataSource Methods

extension ScienceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scienceCell", for: indexPath) as! ScienceCollectionViewCell
        
        cell.designBorderBackground()
        
        cell.titleLabel.textColor = UIColor.white
        cell.sourceLabel.textColor = UIColor.white
        
        cell.titleLabel.text = "Title"
        cell.sourceLabel.text = "Source"
        
        return cell
        
    }
    
    
}

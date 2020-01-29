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
    
    private var layout = UICollectionViewFlowLayout()
    
    private var enterainmentNews: [[String: Any]] = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EnterainmentCollectionViewCell", bundle: nil)
        enterainmentCollectionView.register(nib, forCellWithReuseIdentifier: "enterainmentCell")
        
        setupLayout()
        
    }
    
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
    

}



// MARK: - CollectionView Delegate and DataSource Methods

extension EnterainmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "enterainmentCell", for: indexPath) as! EnterainmentCollectionViewCell
        
        cell.titleLabel.text = "Title"
        cell.sourceLabel.text = "Source"
        
        
        return cell
        
    }
    
}

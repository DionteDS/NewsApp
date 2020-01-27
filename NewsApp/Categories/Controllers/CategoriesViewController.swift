//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var layout = UICollectionViewFlowLayout()
    
    let categories = ["business", "enterainment", "health", "science", "sports", "technology"]
    
    var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create nib and register it to the categoryCeollectionView
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
        
        setupLayout()
        
    }
    
    // Setup the flowlayout for the collectionViewCells
    private func setupLayout() {
        
        let padding: CGFloat = 30
        let collectionViewSize = categoryCollectionView.frame.size.width - padding
        
        layout.itemSize = CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .vertical
        
        categoryCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
}


//MARK: - CollectionView Delegate and Data Source Methods

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CustomCollectionViewCell
        
        
        cell.contentView.backgroundColor = .red
        cell.categoryTitle.text = categories[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Store the row index for the selected indexPath
        if let rowIndex = collectionView.indexPathsForSelectedItems?.first {
            row = rowIndex.item
        }
        
        performSegue(withIdentifier: "goToBusinessController", sender: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    
    // Prepare data to be sent over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToBusinessController" {
            let controller = segue.destination as! BusinessHeadlinesViewController
            
            controller.setQuery(category: categories[row])
        }
        
    }
    
    
}

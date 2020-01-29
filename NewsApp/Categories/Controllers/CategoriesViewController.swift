//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/26/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

private enum Category: String {
    case business = "business"
    case enterainment = "entertainment"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var layout = UICollectionViewFlowLayout()
    
    private let categories = ["business", "entertainment", "health", "science", "sports", "technology"]
    
    private var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        view.backgroundColor = UIColor.gray
        
        categoryCollectionView.backgroundColor = UIColor.gray

        // Create nib and register it to the categoryCeollectionView
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
        
        setupLayout()
        
    }
    
    // Setup the navBar
    func setupNavBar() {
        
        navigationController?.navigationBar.barTintColor = UIColor.gray
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // Setup the flowlayout for the collectionViewCells
    private func setupLayout() {
        
        let padding: CGFloat = 30
        let collectionViewSize = categoryCollectionView.frame.size.width - padding
        
        layout.itemSize = CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
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
        
        cell.designBorderBackground()
        
        cell.contentView.backgroundColor = .red
        cell.categoryTitle.text = categories[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Store the row index for the selected indexPath
        if let rowIndex = collectionView.indexPathsForSelectedItems?.first {
            row = rowIndex.item
        }
        
        // Grab the select category
        let topicPicked = categories[row]
        
        // Check which category was selected
        // And go to that category View Controller
        switch topicPicked{
        case Category.business.rawValue:
            performSegue(withIdentifier: "goToBusinessController", sender: self)
        case Category.enterainment.rawValue:
            performSegue(withIdentifier: "goToEnterainmentVC", sender: self)
        default:
            print("No category")
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    
    // Prepare data to be sent over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Determine which category to segue too.
        if segue.identifier == "goToBusinessController" {
            let controller = segue.destination as! BusinessHeadlinesViewController
            
            controller.setQuery(category: categories[row])
        } else if segue.identifier == "goToEnterainmentVC" {
            let controller = segue.destination as! EnterainmentViewController
        
            controller.setQuery(category: categories[row])
        }
        
    }
    
    
}

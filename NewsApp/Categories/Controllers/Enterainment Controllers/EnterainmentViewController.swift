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
    
    private var flowLayout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("In Enterainment View Controller")
        
    }
    
    private func setupLayout() {
        
        
        
    }
    

}



// MARK: - CollectionView Delegate and DataSource Methods

extension EnterainmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        return cell
        
    }
    
}

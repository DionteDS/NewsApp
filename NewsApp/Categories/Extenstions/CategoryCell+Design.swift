//
//  CategoryCell+Design.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/28/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    func designBorderBackground() {
        // Create the border
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
        
        // Create the shadow affects
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
        
    }
    
}

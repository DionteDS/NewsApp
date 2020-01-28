//
//  TableViewCell+Design.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/28/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func customDesign() {
        
        // Create the border of the cell
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
        
        
        
    }
    
}

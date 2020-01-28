//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Dionte Silmon on 1/25/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Set the spacing for the tableViewCell
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
}

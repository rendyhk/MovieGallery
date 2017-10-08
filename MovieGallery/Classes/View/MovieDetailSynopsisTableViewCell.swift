//
//  MovieDetailSynopsisTableViewCell.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

class MovieDetailSynopsisTableViewCell: UITableViewCell {
    @IBOutlet private weak var overviewLabel: UILabel!
    
    var overview: String = "" {
        didSet {
            overviewLabel.text = overview
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieDetailSynopsisTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

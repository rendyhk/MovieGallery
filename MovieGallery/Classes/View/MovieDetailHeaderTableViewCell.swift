//
//  MovieDetailHeaderTableViewCell.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

class MovieDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    var imageURLString = "" {
        didSet {
            guard let url = URL(string: imageURLString) else {
                return
            }
            indicator.startAnimating()
            bannerImageView.af_setImage(withURL: url)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieDetailHeaderTableViewCell", bundle: nil)
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

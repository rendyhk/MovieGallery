//
//  MovieListTableViewCell.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var iconAdult: UIImageView!
    
    var imageURLString: String = "" {
        didSet {
            guard let url = URL(string: imageURLString) else {
                return
            }
            movieImageView.af_setImage(withURL: url)
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: "MovieListTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        view.roundedWithDropShadow(cornerRadius: 6, shadowColor: .black, shadowOpacity: 0.08, shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

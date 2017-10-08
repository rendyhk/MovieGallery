//
//  MovieDetailHeaderDetailTableViewCell.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

protocol MovieDetailHeaderDetailTableViewCellDelegate: class {
    func movieDetailHeaderDetailTableViewCell(cell: MovieDetailHeaderDetailTableViewCell, didTap sender: UIButton)
}

class MovieDetailHeaderDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var voteLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    weak var delegate: MovieDetailHeaderDetailTableViewCellDelegate?
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var popularity: Double = 0 {
        didSet {
            popularityLabel.text = String(popularity)
        }
    }
    
    var vote: Double = 0 {
        didSet {
            guard vote > 0 else {
                voteLabel.text = "No vote"
                return
            }
            voteLabel.text = String(vote) + " votes"
        }
    }
    
    var languages: [String] = [] {
        didSet {
            guard languages.count > 0 else {
                return
            }
            var text = ""
            for lang in languages {
                let addition = text.isEmpty ? lang : ", \(lang)"
                text = text + addition
            }
            languageLabel.text = text
        }
    }
    
    var genres: [String] = [] {
        didSet {
            guard genres.count > 0 else {
                return
            }
            var text = ""
            for genre in genres {
                let addition = text.isEmpty ? genre : ", \(genre)"
                text = text + addition
            }
            genreLabel.text = text
        }
    }
    
    var duration: String = "" {
        didSet {
            durationLabel.text = duration
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieDetailHeaderDetailTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func bookButtonDidTap(_ sender: UIButton) {
        delegate?.movieDetailHeaderDetailTableViewCell(cell: self, didTap: sender)
    }
    
}

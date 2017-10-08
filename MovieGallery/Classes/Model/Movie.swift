//
//  Movie.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import Foundation

struct Movie {
    var id = ""
    var isAdult = false
    var backdropURL = ""
    var posterURL = ""
    var genreIDs: [Int] = []
    var originalLanguage = "en"
    var originalTitle = ""
    var overview = ""
    var popularity = 0.00
    var releaseDateString = ""
    var title = ""
    var video = 0
    var voteAverage = 0.0
    var voteCount = 0
    
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary["id"] as? String {
            self.id = id
        }
        
        if let isAdult = dictionary["adult"] as? Bool {
            self.isAdult = isAdult
        }
        
        if let backdropURL = dictionary["backdrop_path"] as? String {
            self.backdropURL = Constant.API.URL.baseURLResourceString + backdropURL
        }
        
        if let posterURL = dictionary["poster_path"] as? String {
            self.posterURL = Constant.API.URL.baseURLResourceString + posterURL
        }
        
        if let genreIDs = dictionary["genre_ids"] as? [Int] {
            self.genreIDs = genreIDs
        }
        
        if let originalLanguage = dictionary["original_language"] as? String {
            self.originalLanguage = originalLanguage
        }
        
        if let originalTitle = dictionary["original_title"] as? String {
            self.originalTitle = originalTitle
        }
        
        if let overview = dictionary["overview"] as? String {
            self.overview = overview
        }
        
        if let releaseDateString = dictionary["release_date"] as? String {
            self.releaseDateString = releaseDateString
        }
        
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let popularity = dictionary["popularity"] as? Double {
            self.popularity = popularity
        }
        
        if let video = dictionary["video"] as? Int {
            self.video = video
        }
        
        if let voteAverage = dictionary["vote_average"] as? Double {
            self.voteAverage = voteAverage
        }
        
        if let voteCount = dictionary["vote_count"] as? Int {
            self.voteCount = voteCount
        }
    }
}
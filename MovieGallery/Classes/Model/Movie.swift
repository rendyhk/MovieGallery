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
    var video = false
    var voteAverage = 0.0
    var voteCount = 0
    
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary["id"] as? Int {
            self.id = String(id)
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
        
        if let video = dictionary["video"] as? Bool {
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

struct Obj {
    var id = ""
    var name = ""
    
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary["id"] as? Int {
            self.id = String(id)
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
}

struct MovieDetail {
    var id = ""
    var title = ""
    var backdropURL = ""
    var posterURL = ""
    var genres: [Obj] = []
    var spokenLanguage: [Obj] = []
    var popularity = 0.00
    var overview = ""
    var voteAverage = 0.0
    var voteCount = 0
    var runtime = 0
    
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary["id"] as? Int {
            self.id = String(id)
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let backdropURL = dictionary["backdrop_path"] as? String {
            self.backdropURL = Constant.API.URL.baseURLResourceString + backdropURL
        }
        
        if let posterURL = dictionary["poster_path"] as? String {
            self.posterURL = Constant.API.URL.baseURLResourceString + posterURL
        }
        
        if let genres = dictionary["genres"] as? [[String: AnyObject]] {
            var tempGenres: [Obj] = []
            for genreDictionary in genres {
                let genre = Obj(dictionary: genreDictionary)
                tempGenres.append(genre)
            }
            self.genres = tempGenres
        }
        if let languages = dictionary["spoken_languages"] as? [[String: AnyObject]] {
            var tempLang: [Obj] = []
            for langDictionary in languages {
                let lang = Obj(dictionary: langDictionary)
                tempLang.append(lang)
            }
            self.spokenLanguage = tempLang
        }
        if let popularity = dictionary["popularity"] as? Double {
            self.popularity = popularity
        }
        if let overview = dictionary["overview"] as? String {
            self.overview = overview
        }
        if let voteAverage = dictionary["vote_average"] as? Double {
            self.voteAverage = voteAverage
        }
        if let voteCount = dictionary["vote_count"] as? Int {
            self.voteCount = voteCount
        }
        if let voteCount = dictionary["runtime"] as? Int {
            self.voteCount = voteCount
        }
    }
}


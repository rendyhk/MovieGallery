//
//  Constant.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

struct Constant {
    struct API {
        struct URL {
            static let baseURLString = "http://api.themoviedb.org/"
            static let movieListURLString = "\(baseURLString)3/discover/movie"
            static let movieDetailURLString = "\(baseURLString)3/movie/"
            static let baseURLResourceString = "https://image.tmdb.org/t/p/w370_and_h556_bestv2"
            static let baseURLResourceHDString = "https://image.tmdb.org/t/p/w1280"
        }
        
        struct Value {
            static let apiKey = "03e8cdcdfde1f7fa16f51bbbd63f45b0"
        }
        
        struct RequestKey {
            static let apiKey = "api_key"
            static let primaryReleaseDate = "primary_release_date.lte"
            static let sortBy = "sort_by"
            static let page = "page"
            static let results = "results"
        }
        
        struct ResponseKey {
            static let totalPage = "total_pages"
            static let page = "page"
            static let results = "results"
        }
    }
    
    struct Identifier {
        struct Cell {
            static let movieList = "MovieListCell"
            static let movieDetailHeader = "MovieDetailHeaderCell"
            static let movieDetailHeaderDescription = "MovieDetailHeaderDescriptionCell"
            static let movieDetailSynopsis = "MovieDetailHeadeSynopsisCell"
        }
    }

}


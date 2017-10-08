//
//  MovieGalleryTests.swift
//  MovieGalleryTests
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import XCTest
@testable import MovieGallery

class MovieGalleryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieModel() {
        let id = 123
        let title = "Beauty and the beast"
        let dict = [
            "id": id,
            "title": title
        ] as [String: AnyObject]
        let movie: Movie = Movie(dictionary: dict)
        XCTAssertEqual(title, movie.title)
        XCTAssertEqual(String(id), movie.id)
    }
    
    func testMovieDetailModel() {
        let id = 123
        let title = "Beauty and the beast"
        let genreDict = [
            "id": id,
            "name": "comedy"
            ] as [String: AnyObject]
        let dict = [
            "id": id,
            "title": title,
            "genres": [genreDict]
            ] as [String: AnyObject]
        let movie: MovieDetail = MovieDetail(dictionary: dict)
        XCTAssertEqual("comedy", movie.genres.first?.name)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

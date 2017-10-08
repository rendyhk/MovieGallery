//
//  MovieListViewController.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var totalPage = 1
    var currentPage = 0 {
        didSet {
            print("currentPage \(currentPage)")
        }
    }
    
    var releaseDate = Date().string()
    var sortBy = "release_date.desc"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.beginInfiniteScroll(true)
    }

    private func loadData(_ page: Int) {
        let queryItems = [URLQueryItem(name: Constant.API.RequestKey.apiKey, value: Constant.API.Value.apiKey),
                          URLQueryItem(name: Constant.API.RequestKey.primaryReleaseDate, value: releaseDate),
                          URLQueryItem(name: Constant.API.RequestKey.sortBy, value: sortBy),
                          URLQueryItem(name: Constant.API.RequestKey.page, value: String(page))
                          ]
        let urlComps = NSURLComponents(string: Constant.API.URL.movieListURLString)
        urlComps?.queryItems = queryItems
        
        guard let movieListURL = urlComps?.url else {
            return
        }

        Alamofire.request(URLRequest(url: movieListURL)).responseJSON(queue: DispatchQueue.global(), options: .allowFragments, completionHandler: { (response) in
            switch response.result {
            case .success(_):
                guard let responseDictionary = response.result.value as? [String: Any] else {
                    return
                }
                if let total = responseDictionary[Constant.API.ResponseKey.totalPage] as? Int {
                    self.totalPage = total
                }
                if let page = responseDictionary[Constant.API.ResponseKey.page] as? Int {
                    self.currentPage = page
                }
                
                guard let results = responseDictionary[Constant.API.ResponseKey.results] as? [[String: AnyObject]] else {
                    return
                }
                var tempMovies: [Movie] = []
                for movieDictionary in results {
                    let movie = Movie(dictionary: movieDictionary)
                    tempMovies.append(movie)
                }
                
                if page == 1 {
                    self.movies = tempMovies
                } else {
                    self.movies = self.movies + tempMovies
                }
            case .failure(_):
                return
            }
            
        })
    }
    
    private func setupView() {
        tableView.contentInset = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        tableView.register(MovieListTableViewCell.nib(), forCellReuseIdentifier: Constant.Identifier.Cell.movieList)
        
        tableView.addInfiniteScroll { (table) in
            let nextPage = self.currentPage + 1
            self.loadData(nextPage)
            table.finishInfiniteScroll(completion: nil)
        }
        
        tableView.setShouldShowInfiniteScrollHandler { (table) -> Bool in
            return self.currentPage < self.totalPage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.Cell.movieList) as! MovieListTableViewCell
        cell.imageURLString = movie.posterURL
        return cell
    }
}

//MARK : - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

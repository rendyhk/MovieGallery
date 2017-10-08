//
//  MovieListViewController.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit
import Alamofire
import PullToRefresh

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let refresher = PullToRefresh()
    
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
    
    var releaseDate = "2017-12-31"
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
                    DispatchQueue.main.async {
                        self.tableView.endRefreshing(at: .top)
                    }
                } else {
                    self.movies = self.movies + tempMovies
                }
            case .failure(_):
                return
            }
            
        })
    }
    
    private func setupView() {
        title = "Movie Galleries"
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
        
        tableView.addPullToRefresh(refresher) { 
            self.loadData(1)
        }
        
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.removePullToRefresh(tableView.topPullToRefresh!)
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
        cell.movieTitle = movie.title
        cell.rating = movie.voteAverage
        cell.popularity = movie.popularity
        cell.overview = movie.overview
        cell.isAdultMovie = movie.isAdult
        return cell
    }
}

//MARK : - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        movieDetailVC.movieID = movie.id
        movieDetailVC.movieTitle = movie.title
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

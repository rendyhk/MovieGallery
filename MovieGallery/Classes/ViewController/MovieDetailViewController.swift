//
//  MovieDetailViewController.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit
import Alamofire

enum MovieDetailCellType: Int {
    case header = 0
    case headerDetail = 1
    case synopsis = 2
    static let total = 3
}

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var movieID = "" {
        didSet {
            loadData()
        }
    }
    var movieTitle = ""
    
    var movieDetail: MovieDetail = MovieDetail(dictionary:[:]) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = movieTitle
        tableView.register(MovieDetailHeaderTableViewCell.nib(), forCellReuseIdentifier: Constant.Identifier.Cell.movieDetailHeader)
        tableView.register(MovieDetailHeaderDetailTableViewCell.nib(), forCellReuseIdentifier: Constant.Identifier.Cell.movieDetailHeaderDescription)
        tableView.register(MovieDetailSynopsisTableViewCell.nib(), forCellReuseIdentifier: Constant.Identifier.Cell.movieDetailSynopsis)
        
        tableView.tableFooterView = UIView()
    }
    
    private func loadData() {
        requestDetail()
    }
    
    private func requestDetail() {
        let queryItems = [URLQueryItem(name: Constant.API.RequestKey.apiKey, value: Constant.API.Value.apiKey)
        ]
        
        let urlComps = NSURLComponents(string: Constant.API.URL.movieDetailURLString + movieID)
        urlComps?.queryItems = queryItems
        
        guard let movieDetailURL = urlComps?.url else {
            return
        }
        
        Alamofire.request(URLRequest(url: movieDetailURL)).responseJSON(queue: DispatchQueue.global(), options: .allowFragments, completionHandler: { (response) in
            switch response.result {
            case .success(_):
                guard let responseDictionary = response.result.value as? [String: AnyObject] else {
                    return
                }
                print("xxx \(responseDictionary)")
                self.movieDetail = MovieDetail(dictionary: responseDictionary)
            case .failure(_):
                return
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetailCellType.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "defaultCell")
        switch indexPath.row {
        case MovieDetailCellType.header.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.Cell.movieDetailHeader) as! MovieDetailHeaderTableViewCell
            cell.imageURLString = self.movieDetail.posterURL
            return cell
        case MovieDetailCellType.headerDetail.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.Cell.movieDetailHeaderDescription) as! MovieDetailHeaderDetailTableViewCell
            cell.duration = "\(self.movieDetail.runtime) minutes"
            cell.title = movieDetail.title
            cell.popularity = movieDetail.voteAverage
            cell.vote = movieDetail.voteAverage
            cell.languages = movieDetail.spokenLanguage.map { lang in
                return lang.name
            }
            cell.genres = movieDetail.genres.map { genre in
                return genre.name
            }
            cell.delegate = self
            return cell
        case MovieDetailCellType.synopsis.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.Cell.movieDetailSynopsis) as! MovieDetailSynopsisTableViewCell
            cell.overview = movieDetail.overview
            return cell
        default:
            break
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case MovieDetailCellType.header.rawValue:
            return 200
        case MovieDetailCellType.headerDetail.rawValue:
            return 130
        case MovieDetailCellType.synopsis.rawValue:
            return UITableViewAutomaticDimension
        default:
            break
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case MovieDetailCellType.header.rawValue:
            return 200
        case MovieDetailCellType.headerDetail.rawValue:
            return 130
        case MovieDetailCellType.synopsis.rawValue:
            return 100
        default:
            break
        }
        return 44
    }
}

//MARK: MovieDetailHeaderDetailTableViewCellDelegate
extension MovieDetailViewController: MovieDetailHeaderDetailTableViewCellDelegate {
    func movieDetailHeaderDetailTableViewCell(cell: MovieDetailHeaderDetailTableViewCell, didTap sender: UIButton) {
        let webVC = WebViewController(nibName: "WebViewController", bundle: nil)
        navigationController?.pushViewController(webVC, animated: true)
    }
}

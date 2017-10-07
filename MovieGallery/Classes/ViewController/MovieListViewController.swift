//
//  MovieListViewController.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 07/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
}

//MARK : - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
}

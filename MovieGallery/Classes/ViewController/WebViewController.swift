//
//  WebViewController.swift
//  MovieGallery
//
//  Created by Rendy Hananta on 08/10/17.
//  Copyright © 2017 Rendy Hananta. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var urlString: String = "http://www.cathaycineplexes.com.sg/showtimes.aspx"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "Booking"
        guard let url = URL(string: urlString) else {
            return
        }
        let requestObj = URLRequest(url: url);
        webView.loadRequest(requestObj);
        webView.delegate = self
        indicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finished load")
        indicator.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("failed to load url")
    }
}

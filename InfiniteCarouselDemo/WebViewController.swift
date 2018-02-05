//
//  WebViewController.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 05/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var webView = UIWebView()
    var spinner = UIActivityIndicatorView()
    
    var activeDownloads = 0
    var webUrl: URL? = nil{
        didSet{
            if webView.window != nil{
                loadURL()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.addSubview(spinner)
        view.addSubview(webView)
        layoutSubViews()
        loadURL()
    }
    
    private func loadURL() {
        if webUrl != nil {
            let request = URLRequest(url: webUrl!)
            spinner.startAnimating()
            webView.loadRequest(request)
        }
    }
    
    private func layoutSubViews() {
        webView.frame = CGRect(x: 0,
                               y: 44,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height - 44)
        webView.scalesPageToFit = true
        webView.delegate = self
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activeDownloads += 1
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activeDownloads -= 1
        if activeDownloads < 1 {
            spinner.stopAnimating()
        }
    }
}

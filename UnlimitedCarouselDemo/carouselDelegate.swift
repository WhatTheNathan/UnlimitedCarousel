//
//  carouselDelegate.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 05/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

extension ViewController: UnlimitedCarouselDelegate {
    func didSelect(in carousel: UnlimitedCarousel, at indexPath: ICIndexPath) {
        let item = itemArray[indexPath.row]
        let url = item.link
        if url != "" {
            let webVC = WebViewController()
            webVC.webUrl = URL(string: url)
            webVC.navigationItem.title = item.title
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

extension ViewController: UnlimitedCarouselDataSource {
    func numberOfSections(in carousel: UnlimitedCarousel) -> Int {
        return 3
    }
    
    func numberOfFigures(for carousel: UnlimitedCarousel) -> Int {
        return itemArray.count
    }
    
    func titleForFigure(at indexPath: ICIndexPath, in carousel: UnlimitedCarousel) -> String {
        return itemArray[indexPath.row].title
    }
    
    func picLinkForFigure(at indexPath: ICIndexPath, in carousel: UnlimitedCarousel) -> URL {
        return URL(string: itemArray[indexPath.row].picture_url)!
    }
}

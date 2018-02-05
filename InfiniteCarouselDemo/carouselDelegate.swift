//
//  carouselDelegate.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 05/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

extension ViewController: InfiniteCarouselDelegate {
    func infiniteCarousel(_ carousel: InfiniteCarousel, didSelectFigureAt indexPath: ICIndexPath) {
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

extension ViewController: InfiniteCarouselDataSource {
    func numberOfSections(in carousel: InfiniteCarousel) -> Int {
        return 3
    }
    
    func numberOfFigures(for carousel: InfiniteCarousel) -> Int {
        return itemArray.count
    }
    
    func titleForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> String {
        return itemArray[indexPath.row].title
    }
    
    func picLinkForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> URL {
        return URL(string: itemArray[indexPath.row].picture_url)!
    }
}

//
//  InfiniteCarouselProtocol.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

protocol InfiniteCarouselDataSource {
    
    /// number of sections in infiniteCarousel
    /// the key for create infinite effect
    /// 3 or 5 is recommended
    func numberOfSections(in carousel: InfiniteCarousel) -> Int
    
    /// number of Figures in infiniteCarousel
    func numberOfFigures(for carousel: InfiniteCarousel) -> Int
    
    ///
    func titleForFigure(in carousel: InfiniteCarousel) -> String
    
    /// 
    func picLinkForFigure(in carousel: InfiniteCarousel) -> URL
}

protocol InfiniteCarouselDelegate {
    func infiniteCarousel(_ carousel: InfiniteCarousel, didSelectFigureAt indexPath: ICIndexPath)
    
    func isPageControlHideForSinglePage() -> Bool
}

extension InfiniteCarouselDelegate {
    func isPageControlHideForSinglePage() -> Bool { return true }
}

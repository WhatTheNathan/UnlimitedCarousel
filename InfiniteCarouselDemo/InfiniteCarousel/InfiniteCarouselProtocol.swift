//
//  InfiniteCarouselProtocol.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

protocol InfiniteCarouselDataSource {
    
    /// number of sections in infiniteCarousel,
    /// the key for create infinite effect,
    /// 3 or 5 is recommended
    func numberOfSections(in carousel: InfiniteCarousel) -> Int
    
    /// number of figures in infiniteCarousel
    func numberOfFigures(for carousel: InfiniteCarousel) -> Int
    
    /// title for your figure
    func titleForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> String
    
    /// picture link url for your figure
    func picLinkForFigure(at indexPath: ICIndexPath, in carousel: InfiniteCarousel) -> URL
}

protocol InfiniteCarouselDelegate {
    /// Tells the delegate that the figure at the specified index path was selected
    func infiniteCarousel(_ carousel: InfiniteCarousel, didSelectFigureAt indexPath: ICIndexPath)
}

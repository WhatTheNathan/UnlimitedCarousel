//
//  UnlimitedCarouselDelegate.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UnlimitedCarousel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfFigures
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Figure", for: indexPath) as! FigureCell
        cell.image.contentMode = .scaleToFill
        if let dataSource = self.dataSource {
            cell.image.sd_setImage(with: dataSource.picLinkForFigure(at: ICIndexPath(column: indexPath.section,row: indexPath.row), in: self))
        }
        return cell
    }
}

extension UnlimitedCarousel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.UnlimitedCarousel(self, didSelectFigureAt: ICIndexPath.init(column: indexPath.section, row: indexPath.row))
    }
    
    /// Call when you manually drag, scroll to the middle section
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let dataSource = self.dataSource else { return }
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: dataSource.numberOfSections(in: self)/2), at: .left, animated: false)
    }
    
    /// Call when auto srcoll, scroll to the middle section
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let dataSource = self.dataSource else { return }
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: dataSource.numberOfSections(in: self)/2), at: .left, animated: false)
    }
    
    /// compute the current page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let dataSource = self.dataSource else { return }
        let page = Int((scrollView.contentOffset.x + (collectionView.bounds.width) * 0.5) / (collectionView.bounds.width))
        let currentPage = page % dataSource.numberOfFigures(for: self)
        pageControl.currentPage = currentPage
    }
    
    /// stop auto scroll when you manually drag
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        endAutoScroll()
    }
    
    /// start auto scroll when you stop manuallt dragging
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}

//
//  InfiniteCarouselDelegate.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import UIKit

extension InfiniteCarousel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let dataSource = self.dataSource else { return 3 }
        return dataSource.numberOfSections(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource else { return }
        return dataSource.numberOfFigures(for: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Figure", for: indexPath) as! FigureCell
        cell.image.contentMode = .scaleToFill
//        cell.image.sd_setImage(with: URL(string: itemArray[indexPath.row].picture_url), placeholderImage: #imageLiteral(resourceName: "default_herald"))
        return cell
    }
    
    
}

extension InfiniteCarousel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
    /// 手动拖动调用，无动画移动到中间section
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let dataSource = self.dataSource else { return }
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: dataSource.numberOfSections(in: self)/2), at: .left, animated: false)
    }
    
    // 自动循环调用，无动画移动到中间section
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: dataSource.numberOfSections(in: self)/2), at: .left, animated: false)
    }
    
    // 计算当前页号
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int((scrollView.contentOffset.x + (CarouselFigure.bounds.width) * 0.5) / (CarouselFigure.bounds.width))
        let currentPage = page % itemArray.count
        pageControl.currentPage = currentPage
    }
    
    // 开始拖动时暂停自动循环
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        endAutoScroll()
    }
    
    // 停止拖动时开启自动循环
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}

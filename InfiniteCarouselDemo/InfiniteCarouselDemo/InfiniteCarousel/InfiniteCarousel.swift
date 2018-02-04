//
//  InfiniteCarousel.swift
//  InfiniteCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

//public enum CarouselDirection: String {
//    case left
//    case right
//}

public struct ICIndexPath {
    public var column = 0
    public var row = 0
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
}

class InfiniteCarousel: UIView {
    
    ///
//    open var carouselDirection: CarouselDirection = .right
    open var intervalSecond = 4
    
    ///
    open var dataSource: InfiniteCarouselDataSource?
    open var delegate: InfiniteCarouselDelegate?
    
    /// UI stuff
    private let flowLayout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private var pageControl = UIPageControl()
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func layoutSubviews() {
        guard let dataSource = self.dataSource else { return }
        guard let delegate = self.delegate else { return }
        
        flowLayout.itemSize = CGSize(width: frame.width, height: frame.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FigureCell.self, forCellWithReuseIdentifier: "Figure")
        
        pageControl.frame = CGRect(x: self.frame.width / 2, y: self.frame.height - 30, width: 20, height: 30)
        pageControl.numberOfPages = dataSource.numberOfFigures(for: self)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pageControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        pageControl.hidesForSinglePage = delegate.isPageControlHideForSinglePage()
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(intervalSecond), target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll(){
        guard let dataSource = self.dataSource else { return }
        guard let delegate = self.delegate else { return }
        
        // 获取现在的indexPath
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last!
        // 获取中间section的indexPath
        let middleIndexPath = IndexPath(item: currentIndexPath.item, section: dataSource.numberOfSections(in: self) / 2)
        // 滚动到中间的Section
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)
        
        var nextItem = middleIndexPath.item + 1
        var nextSection = middleIndexPath.section
        if nextItem == dataSource.numberOfFigures(for: self) {
            nextItem = 0
            nextSection += 1
        }
        collectionView.scrollToItem(at: IndexPath(item: nextItem, section: nextSection), at: .left, animated: true)
    }
    
    func endAutoScroll(){
        guard let endTimer = self.timer else{ return }
        endTimer.invalidate()
    }
    
}

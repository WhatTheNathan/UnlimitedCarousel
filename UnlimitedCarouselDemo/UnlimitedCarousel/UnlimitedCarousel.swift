//
//  UnlimitedCarousel.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
import SnapKit

public struct ICIndexPath {
    public var column = 0
    public var row = 0
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
}

public class UnlimitedCarousel: UIView {
    /**
      At each this interval, the picture scrolls once
      Default is `4.0`
     */
    open var intervalSeconds : TimeInterval = 4.0
    
    /**
      If titleLabel is hidden
      Default is true
     */
    public var isTitleHidden : Bool = true
    
    /* DataSource */
    public var dataSource: UnlimitedCarouselDataSource? {
        didSet {
            numOfSection = (dataSource?.numberOfSections(in: self))!
            numOfFigures = (dataSource?.numberOfFigures(for: self))!
            DispatchQueue.once(token: "UnlimitedCarousel") {
                updateUI()
            }
        }
    }
    
    /* Delegate */
    public var delegate: UnlimitedCarouselDelegate?
    
    /* TitleLabelConfig */
    public var config: TitleLabelConfig?
    
    // MARK: UI stuff
    internal let flowLayout = UICollectionViewFlowLayout()
    internal var collectionView: UICollectionView!
    internal var pageControl = UIPageControl()
    
    internal var numOfSection = 3
    internal var numOfFigures = 1
    
    fileprivate var timer: Timer?
    
    // Mark: initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        setupSubviews()
    }
    
    private func updateUI() {
        /* deal with dataSource's change */
        if numOfFigures == 1 { collectionView.isScrollEnabled = false }
        pageControl.numberOfPages = numOfFigures
        collectionView.scrollToItem(at: IndexPath(item: 0, section: numOfSection/2), at: .left, animated: false)
        
        collectionView.reloadData()
        startAutoScroll()
    }
    
    private func setupSubviews() {
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
        collectionView.register(FigureTitleCell.self, forCellWithReuseIdentifier: "FigureTitle")
        self.addSubview(collectionView)
        
        /* initial position */
        collectionView.scrollToItem(at: IndexPath(item: 0, section: numOfSection/2), at: .left, animated: false)
        
        pageControl.numberOfPages = numOfFigures
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pageControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        pageControl.hidesForSinglePage = true
        pageControl.isEnabled = false
        self.addSubview(pageControl)
        
        /* UI constraints */
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
    }
}

// MARK autoScroll Methods
extension UnlimitedCarousel {
    public func startAutoScroll() {
        endAutoScroll()
        if (self.numOfFigures != 1) {
            timer = Timer.scheduledTimer(timeInterval: intervalSeconds, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .commonModes)
        }
    }
    
    @objc func autoScroll(){
        /* the current indexPath */
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last!
        /* the middle section's indexPath */
        let middleIndexPath = IndexPath(item: currentIndexPath.item, section: numOfSection/2)
        /* scroll to the middle section */
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)
        
        var nextItem = middleIndexPath.item + 1
        var nextSection = middleIndexPath.section
        if nextItem == numOfFigures {
            nextItem = 0
            nextSection += 1
        }
        collectionView.scrollToItem(at: IndexPath(item: nextItem, section: nextSection), at: .left, animated: true)
    }
    
    func endAutoScroll(){
        timer?.invalidate()
        timer = nil
    }
}


extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

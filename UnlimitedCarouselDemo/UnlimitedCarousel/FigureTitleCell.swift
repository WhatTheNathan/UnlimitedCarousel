//
//  FigureTitleCell.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 2018/6/6.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
import SnapKit

class FigureTitleCell: UICollectionViewCell {
    var image = UIImageView()
    var titleLabel = UILabel()
    
    var config : TitleLabelConfig? { didSet { updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        setUpSubview()
    }
    
    private func setUpSubview() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(image)
        self.contentView.addSubview(titleLabel)
        
        image.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 42)
        titleLabel.frame = CGRect(x: 0, y: self.frame.height - 38, width: self.frame.width, height: 34)
        
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = config?.backgroundColorForTitleLabel() ?? UIColor.white
        titleLabel.font = config?.fontForTitleLabel() ?? UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
        titleLabel.textColor = config?.colorForTitleLabel() ?? UIColor.black
    }
    
    private func updateUI() {
        titleLabel.backgroundColor = config?.backgroundColorForTitleLabel()!
        titleLabel.font = config?.fontForTitleLabel()!
        titleLabel.textColor = config?.colorForTitleLabel()!
    }
}

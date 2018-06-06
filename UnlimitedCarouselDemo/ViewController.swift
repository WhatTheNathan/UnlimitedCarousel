//
//  ViewController.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 04/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var carousel: UnlimitedCarousel!
//    var carousel = UnlimitedCarousel()
    
    /// Model
    var itemArray: [FigureModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialModel()
        /// declare delegate and dataSource
//        carousel = UnlimitedCarousel(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 160))
        self.view.addSubview(carousel)
        carousel.delegate = self
        carousel.isTitleHidden = false
        carousel.config = self
        carousel.dataSource = self
    }
    
    private func initialModel() {
        var title = "测试1"
        var picture_url = "http://static.myseu.cn/2ee5594142adc6540d8c549a5c0279d1"
        var link = "https://myseu.cn/counter/%E8%BD%AE%E6%92%AD%E5%9B%BE%EF%BC%9A%E8"
        let figure_1 = FigureModel(title,link,picture_url)
        itemArray.append(figure_1)
        
        title = "测试2"
        picture_url = "http://static.myseu.cn/2ee5594142adc6540d8c549a5c0279d1"
        link = "http://mp.weixin.qq.com/s/JXZ8frYklX5Xfmii6hECKQ"
        let figure_2 = FigureModel(title,link,picture_url)
        itemArray.append(figure_2)
    }
}


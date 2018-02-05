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
        carousel.dataSource = self
    }
    
    private func initialModel() {
        var title = "一鸣惊人"
        var picture_url = "http://static.myseu.cn/2017-11-15-%E5%B0%8F%E7%8C%B4-2-.jpg"
        var link = "https://myseu.cn/counter/%E8%BD%AE%E6%92%AD%E5%9B%BE%EF%BC%9A%E8"
        let figure_1 = FigureModel(title,link,picture_url)
        itemArray.append(figure_1)
        
        title = "一带一路”我是演说家演讲比赛"
        picture_url = "http://static.myseu.cn/2017-10-14-E51C1849BAF50B7D4ECB9DE68E89D1AB.jpg"
        link = "http://mp.weixin.qq.com/s/JXZ8frYklX5Xfmii6hECKQ"
        let figure_2 = FigureModel(title,link,picture_url)
        itemArray.append(figure_2)
        
        title = "支教"
        picture_url = "http://www.heraldstudio.com/herald/static/img/80f48cd3eff8c08d9fd7129627ae8a68.jpg"
        link = "http://mp.weixin.qq.com/s/GVYxv0tX-4ez0OIZDC5aiQ"
        let figure_3 = FigureModel(title,link,picture_url)
        itemArray.append(figure_3)
    }
}


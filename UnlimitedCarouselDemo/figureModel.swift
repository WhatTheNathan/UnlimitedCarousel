//
//  figureModel.swift
//  UnlimitedCarouselDemo
//
//  Created by Nathan on 05/02/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

class FigureModel {
    var title : String = ""
    var link : String = ""
    var picture_url : String = ""
    
    init(_ title: String,
         _ link: String,
         _ picture_url: String) {
        self.title = title
        self.link = link
        self.picture_url = picture_url
    }
}

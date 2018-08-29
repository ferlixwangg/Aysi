//
//  ContenImages.swift
//  ContainDetail
//
//  Created by Ivan Riyanto on 28/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit
import Foundation

class ContentImages:NSObject {
    var category: String
    var title: String
    var categoryImage: String
    var contentImage: [String] = []
    
    init(category: String, title: String, categoryImage:String,contentImage:[String]) {
        self.category = category
        self.title = title
        self.categoryImage = categoryImage
        self.contentImage = contentImage
    }
}

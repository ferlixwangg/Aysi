//
//  HowToObject.swift
//  ContainDetail
//
//  Created by Cason Kang on 28/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import Foundation
import UIKit

class HowToObject:NSObject {
    var arrCategory: [String] = []
    var contentDict: [String:[ContentImages]] = [:]
    
    init(category:String, object:ContentImages) {
        self.arrCategory.append(category)
        self.contentDict[category] = []
        self.contentDict[category]?.append(object)
    }
    
    func addCategoryAndContent(category:String, object:ContentImages) {
        self.arrCategory.append(category)
        self.contentDict[category] = []
        self.contentDict[category]!.append(object)
    }
    
    func addContent(category:String, object:ContentImages) {
        self.contentDict[category]!.append(object)
    }
}

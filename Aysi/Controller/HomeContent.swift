//
//  HomeContent.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 28/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class HomeContent: NSObject{
    var childImageShown = [UIImage]()
    var childImageDetail = [UIImage]()
    var wifeImageShown = [UIImage]()
    var wifeImageDetail = [UIImage]()
    
    override init(){
    }
    
    init(childImageS: [UIImage], childImageL: [UIImage], wifeImageS: [UIImage], wifeImageL: [UIImage]) {
        self.childImageShown = childImageS
        self.childImageDetail = childImageL
        self.wifeImageShown = wifeImageS
        self.wifeImageDetail = wifeImageL
    }
}

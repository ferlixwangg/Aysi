//
//  ContentDetailViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 28/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var contentDetailImage: UIImageView!
    
    // MARK: - Variables
    var contentObtained = UIImage()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentDetailImage.image = contentObtained
    }
}

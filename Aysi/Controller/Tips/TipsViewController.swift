//
//  TipsViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 27/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tipsImage: UIImageView!
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet{
            if let imageView = tipsImage{
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsImage.image = UIImage(named: imageName)
    }
}

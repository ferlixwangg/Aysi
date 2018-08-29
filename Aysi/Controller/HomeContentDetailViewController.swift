//
//  HomeContentDetailViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 28/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class HomeContentDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var contentDetailImage: UIImageView!
    
    // MARK: - Variables
    var contentObtained = UIImage()
    var navTitle = String()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarItems()
        
        contentDetailImage.image = contentObtained
    }
    
    func setupNavBarItems() {
        // Nav Bar Title
        let imageView = UIImageView(image: UIImage(named: navTitle))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: 0, width: 110, height: 25))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
        
        // Nav bar buttons
        // Left Arrow Button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(HomeContentDetailViewController.backButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backButton.contentMode = .scaleAspectFit
        backButton.frame = CGRect(x: 10, y: customViewLeft.frame.midY-10, width: 13, height: 17)
        customViewLeft.addSubview(backButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

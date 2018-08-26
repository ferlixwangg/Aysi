//
//  AccountSettingsViewController.swift
//  Aysi
//
//  Created by Cason Kang on 24/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    @IBOutlet weak var simpanBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    private func setupNavBar() {
        let settingsTitle = UIImageView(image: #imageLiteral(resourceName: "SETTINGS"))
        settingsTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        settingsTitle.contentMode = .scaleAspectFit
        
        navigationItem.titleView = settingsTitle
        navigationItem.backBarButtonItem?.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

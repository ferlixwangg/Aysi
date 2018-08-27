//
//  HomeViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 25/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pageScrollView: UIScrollView!
    
    // MARK: - Variables
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarItems()
        
        // Transparent Nav Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (success, error) in
            if error != nil {
                print("Notification Authorization Unsuccessful")
            } else {
                print("Notification Authorization Successful")
            }
        })
        
        
        
//        let dataBayi = UserDefaults.standard.object(forKey: "BabyData") as? [String : String] ?? [String : String]()
//        print(dataBayi["childName"]!)
//        print(dataBayi["gender"]!)
//        print(dataBayi["dob"]!)
    }
    
    // MARK: - Functions
    func setupNavBarItems() {
        let navBarWidth = self.navigationController?.navigationBar.frame.width
        let navBarButtonViewWidth = (navBarWidth! - 140) / 2
        
        // Nav Bar Title
        let imageView = UIImageView(image: UIImage(named: "Settings"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: 0, width: 90, height: 20))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView

        // Nav bar buttons
        // Left Arrow Button
        let leftArrowButton = UIButton(type: .custom)
        leftArrowButton.setImage(UIImage(named: "Left arrow"), for: .normal)
        leftArrowButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: navBarButtonViewWidth, height: 32))
        leftArrowButton.contentMode = .scaleAspectFit
        leftArrowButton.frame = CGRect(x: customViewLeft.frame.width-30, y: customViewLeft.frame.midY-10, width: 13, height: 17)
        customViewLeft.addSubview(leftArrowButton)
        
        // Right Arrow Button
        let RightArrowButton = UIButton(type: .custom)
        RightArrowButton.setImage(UIImage(named: "Right arrow"), for: .normal)
        RightArrowButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        RightArrowButton.contentMode = .scaleAspectFit
        
        // Setting Button
        let SettingButton = UIButton(type: .custom)
        SettingButton.setImage(UIImage(named: "Settings icon"), for: .normal)
        SettingButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        SettingButton.contentMode = .scaleAspectFit
        
        let customViewRight = UIView(frame: CGRect(x: 0, y: 0, width: navBarButtonViewWidth, height: 32))
        RightArrowButton.frame = CGRect(x: 15, y: customViewRight.frame.midY-10, width: 13, height: 17)
        SettingButton.frame = CGRect(x: customViewRight.frame.width-20, y: customViewRight.frame.midY-10, width: 20, height: 20)
        customViewRight.addSubview(RightArrowButton)
        customViewRight.addSubview(SettingButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customViewRight)
    }
    
    @objc func settingButtonPressed() {
        performSegue(withIdentifier: "homeToAccountSetting", sender: self)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 120
        
        if offset > 1 {
            offset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.backgroundColor = color
        }
    }
}

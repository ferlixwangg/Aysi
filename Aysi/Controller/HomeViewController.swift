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
    @IBOutlet weak var navigationItemTop: UINavigationItem!
    
    // MARK: - Variables
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createNavBarTitle()
        createNavBarButtons()
        
        // Transparent Nav Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Notification
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (success, error) in
//            if error != nil {
//                print("Notification Authorization Unsuccessful")
//            } else {
//                print("Notification Authorization Successful")
//            }
//        })
        
        
        
//        let dataBayi = UserDefaults.standard.object(forKey: "BabyData") as? [String : String] ?? [String : String]()
//        print(dataBayi["childName"]!)
//        print(dataBayi["gender"]!)
//        print(dataBayi["dob"]!)
    }
    
    // MARK: - Functions
    func createNavBarTitle() {
        let image = #imageLiteral(resourceName: "SETTINGS")
        let titleView = UIImageView(image: image)
        
        titleView.frame = CGRect(x: 0, y: 0, width: 115, height: 23)
        titleView.contentMode = .scaleAspectFit
        
        navigationItemTop.titleView = titleView
    }
    
    func createNavBarButtons() {
        
        // Setting button
        let settingButton = UIButton(type: .custom)
        settingButton.setImage(UIImage(named: "Settings icon"), for: .normal)
        settingButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        settingButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        settingButton.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        let item4 = UIBarButtonItem(customView: settingButton)
        
        // Right Arrow button
        let rightArrowButton = UIButton(type: .custom)
        rightArrowButton.setImage(UIImage(named: "Right arrow"), for: .normal)
        rightArrowButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        rightArrowButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        rightArrowButton.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        rightArrowButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        let item3 = UIBarButtonItem(customView: rightArrowButton)
        item3.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 120)
        
        // Left Arrow button
        let leftArrowButton = UIButton(type: .custom)
        leftArrowButton.setImage(UIImage(named: "Left arrow"), for: .normal)
        leftArrowButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        leftArrowButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        leftArrowButton.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
        leftArrowButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        let item2 = UIBarButtonItem(customView: leftArrowButton)
        item2.imageInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        
        navigationItemTop.setRightBarButtonItems([item4, item3], animated: true)
        navigationItemTop.setLeftBarButtonItems([item2], animated: true)
    }
    
    @objc func settingButtonPressed() {
        performSegue(withIdentifier: "homeToAccountSetting", sender: self)
    }
    
    
}

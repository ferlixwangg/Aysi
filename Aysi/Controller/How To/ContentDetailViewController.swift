//
//  ContentDetailViewController.swift
//  ContainDetail
//
//  Created by Cason Kang on 29/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit

extension ContentDetailViewController: ContentDetailPageViewControllerDelegate {
    
    func ContentDetailPageViewController(ContentDetailPageViewController: ContentDetailPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func ContentDetailPageViewController(ContentDetailPageViewController: ContentDetailPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

class ContentDetailViewController: UIViewController {

    var object:HowToObject!
    var section:Int!
    var row:Int!
    var currentCategory = String()
    var listOfHowToImages:[String]!
    var categoryImage = String()
    var howToTitleImage = String()
    
    @IBOutlet weak var howToTitleImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCategory = object.arrCategory[section]
        listOfHowToImages = object.contentDict[currentCategory]![row].contentImage
        categoryImage = object.contentDict[currentCategory]![row].category
        howToTitleImage = object.contentDict[currentCategory]![row].title
        setupNavBarItems()
        howToTitleImageView.image = UIImage(named: howToTitleImage)
        howToTitleImageView.contentMode = .scaleAspectFit
    }
    
    func setupNavBarItems() {
        // Nav Bar Title
        let imageView = UIImageView(image: UIImage(named: "\(currentCategory) Title"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: 0, width: 110, height: 26))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
        
        // Nav bar buttons
        // Left Arrow Button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(ContentDetailViewController.backButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backButton.contentMode = .scaleAspectFit
        backButton.frame = CGRect(x: 10, y: customViewLeft.frame.midY-10, width: 20, height: 22)
        customViewLeft.addSubview(backButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contentDetailPageViewController = segue.destination as? ContentDetailPageViewController {
            contentDetailPageViewController.images = listOfHowToImages
            contentDetailPageViewController.ContentDelegate = self
            
        }
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

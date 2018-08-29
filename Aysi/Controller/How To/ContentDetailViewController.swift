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
        print(listOfHowToImages)
        categoryImage = object.contentDict[currentCategory]![row].category
        howToTitleImage = object.contentDict[currentCategory]![row].title
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contentDetailPageViewController = segue.destination as? ContentDetailPageViewController {
            contentDetailPageViewController.images = listOfHowToImages
            contentDetailPageViewController.ContentDelegate = self
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

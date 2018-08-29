//
//  ContentDetailPageViewController.swift
//  ContainDetail
//
//  Created by Cason Kang on 29/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit

protocol ContentDetailPageViewControllerDelegate: class {
    func ContentDetailPageViewController(ContentDetailPageViewController: ContentDetailPageViewController,didUpdatePageCount count: Int)
    
    func ContentDetailPageViewController(ContentDetailPageViewController: ContentDetailPageViewController,didUpdatePageIndex index: Int)
    
    
}

extension ContentDetailPageViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ContentDetailImageViewController
        if itemController.itemIndex > 0 {
            
            return vc[itemController.itemIndex-1]
            
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first as? ContentDetailImageViewController,
            let index = vc.index(of: firstViewController)
        {
            ContentDelegate?.ContentDetailPageViewController(ContentDetailPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ContentDetailImageViewController
        if itemController.itemIndex+1 < images.count {
            //             tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: itemController.itemIndex+1)
            return vc[itemController.itemIndex+1]
            
        }
        return nil
    }
    
}


class ContentDetailPageViewController: UIPageViewController {
    
    weak var ContentDelegate: ContentDetailPageViewControllerDelegate?
    
    var images:[String]! = nil
//    let images = ["PijatDada1","PijatDada2","PijatDada3","PijatDada4"]
    lazy var vc : [ContentDetailImageViewController] = { () -> [ContentDetailImageViewController?] in
        var a = [ContentDetailImageViewController]()
        for i in 0...images.count-1{
            a.append(getItemController(i)!)
        }
        
        return a
        }() as! [ContentDetailImageViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
        if images.count > 0 {
            let firstController = getItemController(0)!
            let startingViewController = [firstController]
            
            setViewControllers(startingViewController, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            
        }
        
        ContentDelegate?.ContentDetailPageViewController(ContentDetailPageViewController: self, didUpdatePageCount: images.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getItemController (_ itemIndex: Int) -> ContentDetailImageViewController? {
        if itemIndex < images.count{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ContentDetailImageViewController
            
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = images[itemIndex]
            return pageItemController
        }
        
        return nil
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

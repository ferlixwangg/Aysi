//
//  TipsPageViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 27/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

protocol TipsDelegate: class {
    func tipsPageCount(tipsPageViewController: TipsPageViewController,didUpdatePageCount count: Int)
    func tipsPageIndex(tipsPageViewController: TipsPageViewController,didUpdatePageIndex index: Int)
}

class TipsPageViewController: UIPageViewController {

    // MARK: - Variables
    weak var tipsDelegate: TipsDelegate?
    
    var allTips = ["Tahukah Anda 1", "Tahukah Anda 2", "Tahukah Anda 3", "Tahukah Anda 4", "Tahukah Anda 5", "Tahukah Anda 6", "Tahukah Anda 7", "Tahukah Anda 8"]
    var selectedTips = [String]()
    
    lazy var vc : [TipsViewController] = {
        return [getItemController(0),getItemController(1),getItemController(2),getItemController(3),getItemController(4)]
        }() as! [TipsViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allTips.shuffle()
        for i in 0...4{
            selectedTips.append(allTips[i])
        }
        
        delegate = self
        dataSource = self
        
        if selectedTips.count > 0 {
            let firstController = getItemController(0)!
            let startingViewController = [firstController]
            
            setViewControllers(startingViewController, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        tipsDelegate?.tipsPageCount(tipsPageViewController: self, didUpdatePageCount: selectedTips.count)
    }
    
    func getItemController (_ itemIndex: Int) -> TipsViewController? {
        if itemIndex < self.selectedTips.count{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "itemController") as! TipsViewController
            
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = self.selectedTips[itemIndex]
            return pageItemController
        }
        return nil
    }
}

extension TipsPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! TipsViewController
        if itemController.itemIndex > 0 {
            return vc[itemController.itemIndex-1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! TipsViewController
        if itemController.itemIndex+1 < selectedTips.count {
            return vc[itemController.itemIndex+1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first as? TipsViewController,
            let index = vc.index(of: firstViewController) {
            tipsDelegate?.tipsPageIndex(tipsPageViewController: self, didUpdatePageIndex: index)
        }
    }
}

// Extension for shuffle
extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

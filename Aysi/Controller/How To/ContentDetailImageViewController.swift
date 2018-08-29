//
//  ContentDetailImageViewController.swift
//  ContainDetail
//
//  Created by Cason Kang on 29/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit

class ContentDetailImageViewController: UIViewController {

    @IBOutlet weak var ContentDetailImage: UIImageView!
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet{
            
            if let imageView = ContentDetailImage{
                
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ContentDetailImage.image = UIImage(named: imageName)
        // Do any additional setup after loading the view.
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

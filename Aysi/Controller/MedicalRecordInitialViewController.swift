//
//  MedicalRecordInitialViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 30/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class MedicalRecordInitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed() {
        let vc = UIStoryboard(name: "MedicalRecord", bundle: nil).instantiateViewController(withIdentifier: "medRecVC2")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
}

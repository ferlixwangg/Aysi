//
//  MedicalRecordViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 29/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class MedicalRecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
}

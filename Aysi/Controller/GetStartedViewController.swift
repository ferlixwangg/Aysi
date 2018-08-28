//
//  GetStartedViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 28/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ayoMulaiButtonPressed() {
        let vc = UIStoryboard(name: "DataBayi", bundle: nil).instantiateViewController(withIdentifier: "dataBayiVC") as! DataBayiViewController
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func tambahAkunButtonPressed() {
        let vc = UIStoryboard(name: "InitialRegister", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! InitialRegisterViewController
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
    
}

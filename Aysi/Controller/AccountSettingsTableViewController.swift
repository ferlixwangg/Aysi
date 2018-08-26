//
//  AccountSettingsTableViewController.swift
//  Aysi
//
//  Created by Cason Kang on 26/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import Firebase

class AccountSettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var babyGender: UISegmentedControl!
    @IBOutlet weak var babyNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var contentNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var graphNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var weekdayNotifSwitchOutlet: UISwitch!    
    @IBOutlet weak var weekendNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var masukAkunOutlet: UIButton!
    @IBOutlet weak var saveBtnOutlet: UIBarButtonItem!
    var ref: DatabaseReference!
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func contentNotifSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func graphNotifSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func weekdayNotifSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func weekendNotifSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func masukAkunBtn(_ sender: UIButton) {
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && Auth.auth().currentUser != nil{
            print("LOGOUT")
            
            let vc = UIStoryboard(name: "InitialRegister", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
            present(vc, animated: true, completion: nil)
            
            try! Auth.auth().signOut()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadSettings()
        ref = Database.database().reference()
        
        //remove keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.emailTextField.delegate = self
        self.userNameTextField.delegate = self
        self.babyNameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //loadSettingsFromUserDefaults
    private func loadSettings(){
        
        if Auth.auth().currentUser == nil{
            masukAkunOutlet.isHidden = false
            masukAkunOutlet.isEnabled = true
            saveBtnOutlet.isEnabled = false
        } else {
            masukAkunOutlet.isHidden = true
            masukAkunOutlet.isEnabled = false
            saveBtnOutlet.isEnabled = true
            
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("child").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                 let data = snapshot.value as? [String: Any]
                
                guard let childName = data?["childName"] as? String,
                    let gender = data?["gender"] as? String,
                    let dob = data?["dob"] as? String,
                    childName != "",
                    gender != "",
                    dob != ""
                    else{
                        print("Data is empty")
                        return
                }
                
                print("success")
            }
        }
        
        if UserDefaults.standard.object(forKey: "contentNotif") != nil {
            contentNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "contentNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "contentNotif")
        }
        if UserDefaults.standard.object(forKey: "graphNotif") != nil {
            graphNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "graphNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "graphNotif")
        }
        if UserDefaults.standard.object(forKey: "weekdayNotif") != nil {
            weekdayNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "weekdayNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "weekdayNotif")
        }
        if UserDefaults.standard.object(forKey: "weekendNotif") != nil {
            weekendNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "weekendNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "weekendNotif")
        }
    }

    private func setupNavBar() {
            let settingsTitle = UIImageView(image: #imageLiteral(resourceName: "SETTINGS"))
            settingsTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
            settingsTitle.contentMode = .scaleAspectFit
            
            navigationItem.titleView = settingsTitle
            navigationItem.backBarButtonItem?.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}

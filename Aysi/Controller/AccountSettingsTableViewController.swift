//
//  AccountSettingsTableViewController.swift
//  Aysi
//
//  Created by Cason Kang on 26/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class AccountSettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var babyGender: UISegmentedControl!
    @IBOutlet weak var babyNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var notifTimeField: UITextField!
    @IBOutlet weak var contentNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var graphNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var weekdayNotifSwitchOutlet: UISwitch!    
    @IBOutlet weak var weekendNotifSwitchOutlet: UISwitch!
    @IBOutlet weak var masukAkunOutlet: UIButton!
    @IBOutlet weak var saveBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var tanggalLahirField: UITextField!

    var ref: DatabaseReference!
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var notifTime = String()
    var dob = String()
    var gender = String()
    var notifMaker = NotificationController()
    
    @IBAction func genderSelector(_ sender: UISegmentedControl) {
        if babyGender.selectedSegmentIndex == 0{
            gender = "Cewek"
        } else {
            gender = "Cowok"
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        
        guard let childName = babyNameTextField.text else { return }
        let babyData = [
            "childName" : childName,
            "gender" : gender,
            "dob" : dob
        ]
        if Auth.auth().currentUser != nil {
            ref?.child("child").child((Auth.auth().currentUser?.uid)!).updateChildValues(babyData) {
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error.localizedDescription).")
                } else {
                    print("Data saved successfully!")
                    UserDefaults.standard.set(babyData, forKey: "BabyData")
                }
            }
        } else {
            UserDefaults.standard.set(babyData, forKey: "BabyData")
        }
        
        notifMaker.removeCallNotifsWeekends()
        notifMaker.removeContentNotifs()
        notifMaker.removeVallNotifsWeekdays()
        notifMaker.removeChartNotifs()

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.locale = Locale(identifier: "id")
        print("dob is : \(dob)")
        let bDay = formatter.date(from: "\(dob) 20:00")!
        
        UserDefaults.standard.set(contentNotifSwitchOutlet.isOn, forKey: "contentNotif")
        UserDefaults.standard.set(graphNotifSwitchOutlet.isOn, forKey: "graphNotif")
        UserDefaults.standard.set(weekdayNotifSwitchOutlet.isOn, forKey: "weekdayNotif")
        UserDefaults.standard.set(weekendNotifSwitchOutlet.isOn, forKey: "weekendNotif")
        UserDefaults.standard.set(notifTime, forKey: "callNotifTime")
        if contentNotifSwitchOutlet.isOn == true {
            notifMaker.setContentNotifs(oriDay: bDay, babyName: childName)
        }
        
        let bDay2 = formatter.date(from: "\(dob) 20:30")
        if graphNotifSwitchOutlet.isOn == true {
            notifMaker.repeatingChartNotification(at: bDay2!, babyName: childName)
        }
        
        let notifTimeArr = notifTime.components(separatedBy: ":")
        
        let hour = Int(notifTimeArr[0])
        let minute = Int(notifTimeArr[1])
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        if weekdayNotifSwitchOutlet.isOn == true {
            notifMaker.setCallNotifications(days: [2,3,4,5,6], hour: hour!, minute: minute!, year: year, babyName: childName)
        }
        if weekendNotifSwitchOutlet.isOn == true {
            notifMaker.setCallNotifications(days: [1,7], hour: hour!, minute: minute!, year: year, babyName: childName)
        }
    }
    
    @IBAction func masukAkunBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "InitialRegister", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
        present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && Auth.auth().currentUser != nil{
            let vc = UIStoryboard(name: "InitialRegister", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
            present(vc, animated: true, completion: nil)
            try! Auth.auth().signOut()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.ref = Database.database().reference()
        loadSettings()
        createDatePicker()
        createTimePicker()
        
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
            
            userNameTextField.text = Auth.auth().currentUser?.displayName
            emailTextField.text = Auth.auth().currentUser?.email
        }
        
            let babyData = UserDefaults.standard.dictionary(forKey: "BabyData")
        babyNameTextField.text = babyData?["childName"] as? String
            gender = babyData?["gender"] as! String
            if gender == "Cowok" {
                babyGender.selectedSegmentIndex = 1
            } else {
                babyGender.selectedSegmentIndex = 0
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let dateConvert = formatter.date(from: babyData?["dob"] as! String)
            formatter.dateFormat = "dd MMMM yyyy"
            let dateDisplay = formatter.string(from: dateConvert!)
            tanggalLahirField.text = dateDisplay
            dob = babyData?["dob"] as! String
        
        //setting switch & field states
        if UserDefaults.standard.object(forKey: "callNotifTime") != nil {
            notifTimeField.text = UserDefaults.standard.string(forKey: "callNotifTime")
            notifTime = notifTimeField.text!
        } else {
            notifTimeField.text = "12:00"
            UserDefaults.standard.set("12:00", forKey: "callNotifTime")
            notifTime = "12:00"
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
            navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AccountSettingsTableViewController {
    // Create Time Picker and Toolbar
    func createTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.timeZone = .current
        timePicker.locale = Locale(identifier: "id")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AccountSettingsTableViewController.dismissTimePicker))
        doneButton.tintColor = UIColor.init(displayP3Red: 75/255, green: 154/255, blue: 212/255, alpha: 1.0)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16.0)!], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        notifTimeField.inputAccessoryView = toolbar
        notifTimeField.inputView = timePicker
    }
    
    // Time Picker Done Button
    @objc func dismissTimePicker() {
        // Format Date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // HH-mm
        notifTime = formatter.string(from: timePicker.date)
        print(notifTime)
        notifTimeField.text = notifTime
        view.endEditing(true)
    }
    
    // Create Date Picker and Toolbar
    func createDatePicker() {
        
        // Formatting the date picker type
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "id")
        var dateComponent = DateComponents()
        dateComponent.year = -5 // removing 5 years from today as the minimum date
        datePicker.minimumDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        dateComponent.year = 5 // adding 5 years from today as the maximum date
        datePicker.maximumDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        
        // Create Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AccountSettingsTableViewController.dismissDatePicker))
        doneButton.tintColor = UIColor.init(displayP3Red: 75/255, green: 154/255, blue: 212/255, alpha: 1.0)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16.0)!], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        tanggalLahirField.inputAccessoryView = toolbar
        tanggalLahirField.inputView = datePicker
    }
    
    // Used for Date Picker Done button
    @objc func dismissDatePicker() {
        // Format Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy" // dd-MM-yyyy
        formatter.locale = Locale(identifier: "id")
        dob = formatter.string(from: datePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        let dateConvert = formatter.date(from: dob)
        formatter.dateFormat = "dd MMMM yyyy"
        let dateDisplay = formatter.string(from: dateConvert!)
        
        tanggalLahirField.text = String(dateDisplay)
        view.endEditing(true)
    }
}

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
    var dob: String?
    var gender = String()
    var notifMaker = NotificationController()
    
    @IBAction func genderSelector(_ sender: UISegmentedControl) {
        if babyGender.selectedSegmentIndex == 0{
            gender = "Cewek"
        } else {
            gender = "Cowok"
        }
    }
    
    @IBAction func contentNotifSwitch(_ sender: UISwitch) {
        //alert for notif permission
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
            }
            else {
                let alertController = UIAlertController(title: "Tidak bisa membuat notifikasi!", message: "Aplikasi tidak mempunyai izin membuat notifikasi. Tolong berikan izin di setting jika ingin mendapatkan notifikasi.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (completion) in
                    self.contentNotifSwitchOutlet.setOn(false, animated: true)
                })
                
                alertController.addAction(defaultAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func graphNotifSwitch(_ sender: UISwitch) {
        //alert for notif permission
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
            }
            else {
                let alertController = UIAlertController(title: "Tidak bisa membuat notifikasi!", message: "Aplikasi tidak mempunyai izin membuat notifikasi. Tolong berikan izin di setting jika ingin mendapatkan notifikasi.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (completion) in
                    self.graphNotifSwitchOutlet.setOn(false, animated: true)
                })
                alertController.addAction(defaultAction)
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func weekdayNotifSwitch(_ sender: UISwitch) {
        //alert for notif permission
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
            }
            else {
                let alertController = UIAlertController(title: "Tidak bisa membuat notifikasi!", message: "Aplikasi tidak mempunyai izin membuat notifikasi. Tolong berikan izin di setting jika ingin mendapatkan notifikasi.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (completion) in
                    self.weekdayNotifSwitchOutlet.setOn(false, animated: true)
                })
                alertController.addAction(defaultAction)
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func weekendNotifSwitch(_ sender: UISwitch) {
        //alert for notif permission
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
            }
            else {
                let alertController = UIAlertController(title: "Tidak bisa membuat notifikasi!", message: "Aplikasi tidak mempunyai izin membuat notifikasi. Tolong berikan izin di setting jika ingin mendapatkan notifikasi.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (completion) in
                    self.weekendNotifSwitchOutlet.setOn(false, animated: true)
                })
                alertController.addAction(defaultAction)
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        guard let childName = babyNameTextField.text, childName != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan nama bayi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        let babyData = [
            "childName" : childName,
            "gender" : gender,
            "dob" : dob
        ]
        
        //If Logged in
        if Auth.auth().currentUser != nil {
            ref?.child("child").child((Auth.auth().currentUser?.uid)!).updateChildValues(babyData) {
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error.localizedDescription).")
                } else {
                    print("Data saved successfully!")
                    UserDefaults.standard.set(babyData, forKey: "BabyData")
                    let alertController = UIAlertController(title: "Sukses!", message: "Data telah tersimpan.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else { //Not Logged in
            UserDefaults.standard.set(babyData, forKey: "BabyData")
            let alertController = UIAlertController(title: "Sukses!", message: "Data telah tersimpan.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        //removing notifs
        notifMaker.removeCallNotifsWeekends()
        notifMaker.removeContentNotifs()
        notifMaker.removeVallNotifsWeekdays()
        notifMaker.removeChartNotifs()
        
        //setting trigger time for notifs
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.locale = Locale(identifier: "id")
        let bDay = formatter.date(from: "\(dob!) 20:00")! //notif time is set here
        
        //making notifs for content
        if contentNotifSwitchOutlet.isOn == true {
            notifMaker.setContentNotifs(oriDay: bDay, babyName: childName)
        }
        
        //making notifs for chart
        let bDay2 = formatter.date(from: "\(dob!) 20:30") //notif time is set here
        if graphNotifSwitchOutlet.isOn == true {
            notifMaker.repeatingChartNotification(at: bDay2!, babyName: childName)
        }
        
        //separating the hour and minute from notif time for call wife notif
        let notifTimeArr = notifTime.components(separatedBy: ":")
        
        let hour = Int(notifTimeArr[0])
        let minute = Int(notifTimeArr[1])
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        //weekday notifs 2-6 is monday to friday
        if weekdayNotifSwitchOutlet.isOn == true {
            notifMaker.setCallNotifications(days: [2,3,4,5,6], hour: hour!, minute: minute!, year: year, babyName: childName)
        }
        
        //weekend notifs 1 and 7 is saturday and sunday
        if weekendNotifSwitchOutlet.isOn == true {
            notifMaker.setCallNotifications(days: [1,7], hour: hour!, minute: minute!, year: year, babyName: childName)
        }
        
        //setting userdefaults for switch states
        UserDefaults.standard.set(contentNotifSwitchOutlet.isOn, forKey: "contentNotif")
        UserDefaults.standard.set(graphNotifSwitchOutlet.isOn, forKey: "graphNotif")
        UserDefaults.standard.set(weekdayNotifSwitchOutlet.isOn, forKey: "weekdayNotif")
        UserDefaults.standard.set(weekendNotifSwitchOutlet.isOn, forKey: "weekendNotif")
        UserDefaults.standard.set(notifTime, forKey: "callNotifTime")
    }
    
    //hidden button if not logged in
    @IBAction func masukAkunBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "InitialRegister", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
        present(vc, animated: true, completion: nil)
    }
    
    //sign out
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
        setupNavBarItems()
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
        
        masukAkunOutlet.backgroundColor = UIColor.init(displayP3Red: 61/255, green: 117/255, blue: 143/255, alpha: 1.0)
        masukAkunOutlet.layer.cornerRadius = 5
        masukAkunOutlet.layer.borderWidth = 1
        masukAkunOutlet.layer.borderColor = UIColor.init(displayP3Red: 61/255, green: 117/255, blue: 143/255, alpha: 1.0).cgColor
    }
    
    //return to remove keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //loadSettingsFromUserDefaults
    private func loadSettings(){
        //check if user is logged in for sign in button
        if Auth.auth().currentUser == nil{
            masukAkunOutlet.isHidden = false
            masukAkunOutlet.isEnabled = true
            saveBtnOutlet.isEnabled = true
            
        } else {
            masukAkunOutlet.isHidden = true
            masukAkunOutlet.isEnabled = false
            saveBtnOutlet.isEnabled = true
            
            userNameTextField.text = Auth.auth().currentUser?.displayName
            emailTextField.text = Auth.auth().currentUser?.email
        }
        
        //loading baby data from userDefaults
        let babyData = UserDefaults.standard.dictionary(forKey: "BabyData")
        babyNameTextField.text = babyData?["childName"] as? String
        gender = babyData?["gender"] as! String
        
        if gender == "Cowok" {
            babyGender.selectedSegmentIndex = 1
        } else {
            babyGender.selectedSegmentIndex = 0
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.dateFormat = "dd-MM-yyyy"
        
        let dateConvert = formatter.date(from: babyData?["dob"] as! String)
        datePicker.date = dateConvert!
        formatter.dateFormat = "dd MMMM yyyy"
        
        let dateDisplay = formatter.string(from: dateConvert!)
        tanggalLahirField.text = dateDisplay
        dob = (babyData?["dob"] as! String)
        
        //setting switch & field states
        if UserDefaults.standard.object(forKey: "callNotifTime") != nil {
            notifTimeField.text = UserDefaults.standard.string(forKey: "callNotifTime")
            notifTime = notifTimeField.text!
            formatter.dateFormat = "HH:mm"
            if let time = formatter.date(from: notifTime) {
                timePicker.date = time
            }
        } else {
            notifTimeField.text = "12:00"
            UserDefaults.standard.set("12:00", forKey: "callNotifTime")
            notifTime = "12:00"
            formatter.dateFormat = "HH:mm"
            if let time = formatter.date(from: notifTime) {
                timePicker.date = time
            }
        }
        
        if UserDefaults.standard.object(forKey: "contentNotif") != nil {
            contentNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "contentNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "contentNotif")
            contentNotifSwitchOutlet.setOn(false, animated: false)
        }
        
        if UserDefaults.standard.object(forKey: "graphNotif") != nil {
            graphNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "graphNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "graphNotif")
            graphNotifSwitchOutlet.setOn(false, animated: false)
        }
        
        if UserDefaults.standard.object(forKey: "weekdayNotif") != nil {
            weekdayNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "weekdayNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "weekdayNotif")
            weekdayNotifSwitchOutlet.setOn(false, animated: false)
        }
        
        if UserDefaults.standard.object(forKey: "weekendNotif") != nil {
            weekendNotifSwitchOutlet.setOn(UserDefaults.standard.bool(forKey: "weekendNotif"), animated: false)
        } else {
            UserDefaults.standard.set(false, forKey: "weekendNotif")
            weekendNotifSwitchOutlet.setOn(false, animated: false)
        }
    }

    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupNavBarItems() {
        // Nav Bar Title
        let imageView = UIImageView(image: UIImage(named: "Settings"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: 0, width: 90, height: 23))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
        
        // Nav bar buttons
        // Left Arrow Button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(AccountSettingsTableViewController.backButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backButton.contentMode = .scaleAspectFit
        backButton.frame = CGRect(x: 10, y: customViewLeft.frame.midY-10, width: 20, height: 22)
        customViewLeft.addSubview(backButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
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
        let dateConvert = formatter.date(from: dob!)
        formatter.dateFormat = "dd MMMM yyyy"
        let dateDisplay = formatter.string(from: dateConvert!)
        
        tanggalLahirField.text = String(dateDisplay)
        view.endEditing(true)
    }
}

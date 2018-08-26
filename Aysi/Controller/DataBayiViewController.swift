//
//  DataBayiViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 24/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import Firebase

class DataBayiViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var namaBayiField: UITextField!
    @IBOutlet weak var jenisKelaminField: UITextField!
    @IBOutlet weak var tanggalLahirField: UITextField!
    
    
    // MARK: - Variables
    let genderPicker = UIPickerView()
    let genderList = ["Laki-laki", "Perempuan"]
    var pickerMoved = Bool()
    
    let datePicker = UIDatePicker()
    var dob: String?
    
    let user = Auth.auth().currentUser
    
    var ref:DatabaseReference!
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createGenderPicker()
        createDatePicker()
        ref = Database.database().reference()
        
        // Changing Text Field Placeholder Color
        namaBayiField.attributedPlaceholder = NSAttributedString(string: "Nama Bayi", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        jenisKelaminField.attributedPlaceholder = NSAttributedString(string: "Jenis Kelamin", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        tanggalLahirField.attributedPlaceholder = NSAttributedString(string: "Tanggal Lahir", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        // For background tap gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func daftarButtonPressed() {
        guard let childName = namaBayiField.text, childName != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan nama bayi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let gender = jenisKelaminField.text, gender != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan jenis kelamin bayi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let dobFinal = dob, dobFinal != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan tanggal lahir bayi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let data = [
            "childName" : childName,
            "gender" : gender,
            "dob": dobFinal
        ]
        
        ref?.child("child").child("\(user!.uid)").updateChildValues(data) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error.localizedDescription).")
            } else {
                print("Data saved successfully!")
            }
        }
        
        moveToHomePage()
    }
    
    func moveToHomePage() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func jenisKelaminFieldPressed() {
        pickerMoved = false
    }
}

// MARK: - Text field extension
extension DataBayiViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Gender Picker View
extension DataBayiViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Create Category Picker and Toolbar
    func createGenderPicker() {
        
        genderPicker.delegate = self
//        genderPicker.backgroundColor = UIColor.init(displayP3Red: 237/255, green: 237/255, blue: 238/255, alpha: 1.0)
        
        // Create Toolbar for the Picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Elements for the toolbar (space and done)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DataBayiViewController.dismissCategoryPicker))
        doneButton.tintColor = UIColor.init(displayP3Red: 75/255, green: 154/255, blue: 212/255, alpha: 1.0)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 16.0)!], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        jenisKelaminField.inputAccessoryView = toolbar
        jenisKelaminField.inputView = genderPicker
    }
    
    @objc func dismissCategoryPicker(){
        if pickerMoved == false && jenisKelaminField.text == "" {
            jenisKelaminField.text = genderList[0]
        }
        view.endEditing(true)
    }
    
    // Set the number of column in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set the number of row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderList.count
    }
    
    // Set the title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
    
    // Define what to do if a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        jenisKelaminField.text = genderList[row]
        pickerMoved = true
    }
    
//     Set the style for each row
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label = UILabel()
//
//        if let view = view as? UILabel{
//            label = view
//        }
//
//        label.textColor = UIColor.init(displayP3Red: 27/255, green: 69/255, blue: 91/255, alpha: 1.0)
//        label.textAlignment = .center
//        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
//        label.text = genderList[row]
//        return label
//    }
}


// MARK: - Date Picker View
extension DataBayiViewController {
    
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DataBayiViewController.dismissDatePicker))
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

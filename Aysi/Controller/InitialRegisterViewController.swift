//
//  InitialRegisterViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 20/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import Firebase

class InitialRegisterViewController: UIViewController {

    // MARK: - Outlets
    // Login Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    
    // Sign Up Outlets
    @IBOutlet weak var nameSignUpField: UITextField!
    @IBOutlet weak var emailSignUpField: UITextField!
    @IBOutlet weak var passwordSignUpField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    // MARK: - Variables
    var ref: DatabaseReference!
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.signUpView.frame.origin.x = UIScreen.main.bounds.width
        self.signUpView.isHidden = true
        
        // Changing Text Field Placeholder Color
        emailField.attributedPlaceholder = NSAttributedString(string: "contoh@email.com", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Kata Sandi", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        nameSignUpField.attributedPlaceholder = NSAttributedString(string: "Nama", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        emailSignUpField.attributedPlaceholder = NSAttributedString(string: "contoh@email.com", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        passwordSignUpField.attributedPlaceholder = NSAttributedString(string: "Kata Sandi", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        confirmPasswordField.attributedPlaceholder = NSAttributedString(string: "Konfirmasi Kata Sandi", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(displayP3Red: 127/255, green: 165/255, blue: 182/255, alpha: 1.0)])
        
        // For background tap gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    // MARK: - Functions
    func moveToDataBayiPage() {
        let vc = UIStoryboard(name: "DataBayi", bundle: nil).instantiateViewController(withIdentifier: "dataBayiVC") as! DataBayiViewController
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
    
    func moveToHomePage() {
        let tabVC = UITabBarController()
        
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeNavigationVC") as! UINavigationController
        let chartVC = UIStoryboard(name: "Chart", bundle: nil).instantiateViewController(withIdentifier: "chartVC")
        let immunizationVC = UIStoryboard(name: "Immunization", bundle: nil).instantiateViewController(withIdentifier: "immunizationVC")
        let medicalRecordVC = UIStoryboard(name: "MedicalRecord", bundle: nil).instantiateViewController(withIdentifier: "medRecNavigationVC") as! UINavigationController
        
        tabVC.viewControllers = [homeVC, chartVC, immunizationVC, medicalRecordVC]
        tabVC.selectedViewController = homeVC
        
        present(tabVC, animated: true, completion: nil)
    }
    
    // MARK: - Sign In Process
    // Handling Sign In Process masuk button
    @IBAction func masukButtonPressed() {
        guard let email = emailField.text, email != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan email Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordField.text, password != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan kata sandi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                
                // Checking if the user already has the baby data
                self.ref.child("child").observeSingleEvent(of: .value) { (snapshot) in
                    if snapshot.hasChild((Auth.auth().currentUser?.uid)!) {
                        
                        self.ref.child("child").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
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
                            
                            let babyData = [
                                "childName" : childName,
                                "gender" : gender,
                                "dob" : dob
                            ]
                            
                            UserDefaults.standard.set(babyData, forKey: "BabyData")
                            self.moveToHomePage()
                        }
                    } else {
                        self.moveToDataBayiPage()
                    }
                }
            } else {
                
                let errorCode = error! as NSError
                var errorMessage = String()
                
                switch errorCode.code{
                case AuthErrorCode.invalidEmail.rawValue:
                    errorMessage = "Format email tidak tepat"
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "Kata sandi tidak tepat"
                case AuthErrorCode.userNotFound.rawValue:
                    errorMessage = "Akun Anda tidak valid"
                case AuthErrorCode.userDisabled.rawValue:
                    errorMessage = "Akun Anda telah diblokir"
                case AuthErrorCode.networkError.rawValue:
                    errorMessage = "Internet Anda sedang mengalami gangguan"
                case AuthErrorCode.userTokenExpired.rawValue:
                    errorMessage = "Telah terjadi perubahan pada akun Anda. Tolong masuk kembali ke akun Anda"
                case AuthErrorCode.tooManyRequests.rawValue:
                    errorMessage = "Data server sedang mengalami masalah. Silakan coba lagi beberapa saat"
                default:
                    errorMessage = error.debugDescription
                }
                
                let alertController = UIAlertController(title: "Eror", message: errorMessage, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func daftarButtonPressed() {
        self.signUpView.frame.origin.x = UIScreen.main.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.loginView.frame.origin.x = 0 - self.loginView.frame.width
            self.signUpView.center.x = self.view.frame.midX
        }
        
        self.signUpView.isHidden = false
    }
    
    
    // MARK: - SIgn Up Page
    @IBAction func buatButtonPressed() {
        guard let name = nameSignUpField.text, name != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan nama Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }

        guard let email = emailSignUpField.text, email != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan email Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }

        guard let password = passwordSignUpField.text, password != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Masukkan kata sandi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }

        guard let confirmPassword = confirmPasswordField.text, confirmPassword != "" else {
            let alertController = UIAlertController(title: "Eror", message: "Konfirmasi kata sandi Anda", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if password != confirmPassword {
            let alertController = UIAlertController(title: "Eror", message: "Konfirmasi kata sandi salah", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let createdAccount = Auth.auth().currentUser
                let changeRequest = createdAccount?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        self.moveToDataBayiPage()
                    } else {
                        let alertController = UIAlertController(title: "Eror", message: error.debugDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            } else {

                let errorCode = error! as NSError
                var errorMessage = String()

                switch errorCode.code{
                    case AuthErrorCode.invalidEmail.rawValue:
                        errorMessage = "Format email tidak tepat"
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        errorMessage = "Email sudah digunakan"
                    case AuthErrorCode.weakPassword.rawValue:
                        errorMessage = "Kata sandi harus lebih dari 6 karakter"
                    case AuthErrorCode.networkError.rawValue:
                        errorMessage = "Internet Anda sedang mengalami gangguan"
                    case AuthErrorCode.userTokenExpired.rawValue:
                        errorMessage = "Telah terjadi perubahan pada akun Anda. Tolong masuk kembali ke akun Anda"
                    case AuthErrorCode.tooManyRequests.rawValue:
                        errorMessage = "Data server sedang mengalami masalah. Silakan coba lagi beberapa saat"
                    default:
                        errorMessage = error.debugDescription
                }

                let alertController = UIAlertController(title: "Eror", message: errorMessage, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func masukSignUpButtonPressed() {
        self.loginView.frame.origin.x = 0 - self.loginView.frame.width
        UIView.animate(withDuration: 0.5) {
            self.signUpView.frame.origin.x = UIScreen.main.bounds.width
            
            self.loginView.center.x = self.view.frame.midX
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.signUpView.isHidden = true
        }
    }
}

// MARK: - Text field delegate
extension InitialRegisterViewController: UITextFieldDelegate {
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailSignUpField || textField == nameSignUpField || textField == passwordSignUpField || textField == confirmPasswordField {
            textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

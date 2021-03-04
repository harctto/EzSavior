//
//  RegisterPage.swift
//  EzSavior
//
//  Created by Hatto on 3/10/2563 BE.
//

import UIKit
import Firebase

class RegisterPage: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfrimPassword: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfSurname: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tfEmail(_ sender: Any) {
        if (tfEmail.text?.isValidEmail())! == false {
            let alert = UIAlertController(title: .none, message: "Email is invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        self.view.endEditing(true)
        if tfUsername.text == "" || tfEmail.text == "" || tfPassword.text == "" || tfConfrimPassword.text == "" || tfName.text == "" || tfSurname.text == "" {
            let alert = UIAlertController(title: .none, message: "Please fill all information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if tfPassword.text != tfConfrimPassword.text {
            let alert = UIAlertController(title: .none, message: "Password doesn't match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            let ref = Database.database().reference()
            ref.child("\(tfUsername.text!)").setValue(
                ["username" : "\(tfUsername.text!)" ,
                 "email" : "\(tfEmail.text!)" ,
                 "password" : "\(tfPassword.text!)" ,
                 "name" : "\(tfName.text!)" ,
                 "surname" : "\(tfSurname.text!)" ,
                 "nameuse" : "\(tfName.text!)" ,
                 "profilePicture" : "Dowoon.jpg",
                 "money" : ["balance" : "0"]
                ])
            let alert = UIAlertController(title: "Register done", message: .none, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
                self.performSegue(withIdentifier: "login", sender: nil)
            }))
            self.present(alert, animated: true)
            
        }
    }
    
    func adjustRegisterUI(){
        self.view.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
        self.btnRegister.layer.cornerRadius = 20
        self.btnRegister.layer.shadowColor = UIColor.darkGray.cgColor
        self.btnRegister.layer.shadowRadius = 3
        self.btnRegister.layer.shadowOpacity = 0.4
        self.btnRegister.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.btnBack.layer.cornerRadius = 20
        self.btnBack.layer.shadowColor = UIColor.darkGray.cgColor
        self.btnBack.layer.shadowRadius = 3
        self.btnBack.layer.shadowOpacity = 0.4
        self.btnBack.layer.shadowOffset = CGSize(width: 6, height: 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKB()
        // Do any additional setup after loading the view.
        adjustRegisterUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



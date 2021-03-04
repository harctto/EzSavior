//
//  ViewController.swift
//  EzSavior
//
//  Created by Hatto on 30/9/2563 BE.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    @IBAction func btnLogin(_ sender: Any) {
        self.view.endEditing(true)
        let ref = Database.database().reference()
        if tfUsername.text! == "" && tfPassword.text! == "" {
            let alert = UIAlertController(title: .none, message: "Invalid username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if tfUsername.text! != "" && tfPassword.text! == "" {
            let alert = UIAlertController(title: .none, message: "Password needed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if tfUsername.text! == "" && tfPassword.text! != "" {
            let alert = UIAlertController(title: .none, message: "Username needed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        else {
            ref.child("\(tfUsername.text!)/username").observeSingleEvent(of: .value) { (username) in
                let nameCheck=username.value
                
                if self.tfUsername.text == nameCheck as? String{
                 //   self.lbErrorAlert.text="your username \(nameCheck!) is correct"
                    ref.child("\(self.tfUsername.text!)/password").observeSingleEvent(of: .value) { (password) in
                        let passCheck=password.value
                        if self.tfPassword.text.unsafelyUnwrapped == (passCheck as AnyObject).description {
                  //          self.lbErrorAlert.text?.append("\nyour password is correct")
                            self.performSegue(withIdentifier: "application", sender: nil)
                        }
                        else{
                            let alert = UIAlertController(title: .none, message: "Invalid username or password", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                }
                else{
                    let alert = UIAlertController(title: .none, message: "Invalid username or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func adjustLoginUI() {
        self.btnLogin.layer.cornerRadius = 20
        self.btnLogin.layer.shadowColor = UIColor.darkGray.cgColor
        self.btnLogin.layer.shadowRadius = 3
        self.btnLogin.layer.shadowOpacity = 0.4
        self.btnLogin.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.tfUsername.layer.cornerRadius = 20
        self.tfUsername.layer.shadowColor = UIColor.darkGray.cgColor
        self.tfUsername.layer.shadowRadius = 3
        self.tfUsername.layer.shadowOpacity = 0.4
        self.tfUsername.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.tfPassword.layer.cornerRadius = 20
        self.tfPassword.layer.shadowColor = UIColor.darkGray.cgColor
        self.tfPassword.layer.shadowRadius = 3
        self.tfPassword.layer.shadowOpacity = 0.4
        self.tfPassword.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.view.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
    }
    
    override func viewDidLoad() {
        hideKB()
        super.viewDidLoad()
        adjustLoginUI()
    }
    
//    passing value
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "application" {
            let sender = segue.destination as? BaseTabbar
            sender?.currentUsername = self.tfUsername.text!
        }
    }
    
    
}



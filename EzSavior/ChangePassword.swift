//
//  ChangePassword.swift
//  EzSavior
//
//  Created by Hatto on 18/11/2563 BE.
//

import UIKit
import Firebase

class ChangePassword: UIViewController {

    @IBOutlet weak var viewChangeUsername: UIView!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var okbtn: UIButton!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var backinputview: UIView!
    @IBOutlet weak var backinputCFview: UIView!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputCFPassword: UITextField!
    var currentUsernameChangePage:String = ""
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOK(_ sender: Any) {
        let ref = Database.database().reference()
        if inputPassword.text == inputCFPassword.text {
            ref.child("\(currentUsernameChangePage)").updateChildValues(
                [
                    "password" : "\(inputPassword.text!)"
                ]
            )
            let alert = UIAlertController(title: "Password Changed", message: .none, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Password Doesn't Match", message: .none, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func adjust() {
        self.inputPassword.layer.cornerRadius = 10
        self.viewChangeUsername.layer.cornerRadius = 50
        self.cancelbtn.layer.cornerRadius = 10
        self.okbtn.layer.cornerRadius = 10
        self.backview.layer.cornerRadius = 50
        self.backinputview.layer.cornerRadius = 20
        self.backinputCFview.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        adjust()
        hideKB()
        self.view.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
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

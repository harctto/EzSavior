//
//  ChangeUsername.swift
//  EzSavior
//
//  Created by Hatto on 18/11/2563 BE.
//

import UIKit
import Firebase

class ChangeUsername: UIViewController {

    @IBOutlet weak var viewChangeUsername: UIView!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var okbtn: UIButton!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var backinputview: UIView!
    @IBOutlet weak var inputUsername: UITextField!
    var currentUsernameChangePage:String = ""
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOK(_ sender: Any) {
        let ref = Database.database().reference()
        ref.child("\(currentUsernameChangePage)").updateChildValues(
            [
                "nameuse" : "\(inputUsername.text!)"
            ]
        )
        
        let alert = UIAlertController(title: .none, message: "Username Changed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
        
    }
    
    func adjustUI() {
        self.inputUsername.layer.cornerRadius = 10
        self.viewChangeUsername.layer.cornerRadius = 50
        self.cancelbtn.layer.cornerRadius = 10
        self.okbtn.layer.cornerRadius = 10
        self.backview.layer.cornerRadius = 50
        self.backinputview.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        adjustUI()
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

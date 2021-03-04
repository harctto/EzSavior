//
//  ChangeProfilePicture.swift
//  EzSavior
//
//  Created by Hatto on 18/11/2563 BE.
//

import UIKit
import Firebase

class ChangeProfilePicture: UIViewController {

    @IBOutlet weak var viewShow: UIView!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var picture1: UIButton!
    @IBOutlet weak var picture2: UIButton!
    @IBOutlet weak var picture3: UIButton!
    @IBOutlet weak var picture4: UIButton!
    let ref = Database.database().reference()
    var currentUsernameChangeProfilePicture:String = ""
    
    @IBAction func btnPicture1(_ sender: Any) {
        ref.child("\(currentUsernameChangeProfilePicture)").updateChildValues(
            ["profilePicture" : "ezsavior_icon_1.png"]
        )
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPicture2(_ sender: Any) {
        ref.child("\(currentUsernameChangeProfilePicture)").updateChildValues(
            ["profilePicture" : "ezsavior_icon_2.png"]
        )
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPicture3(_ sender: Any) {
        ref.child("\(currentUsernameChangeProfilePicture)").updateChildValues(
            ["profilePicture" : "ezsavior_icon_3.png"]
        )
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPicture4(_ sender: Any) {
        ref.child("\(currentUsernameChangeProfilePicture)").updateChildValues(
            ["profilePicture" : "ezsavior_icon_4.png"]
        )
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewSetup() {
        self.picture1.setBackgroundImage(UIImage.init(named: "ezsavior_icon_1.png"), for: .normal)
        self.picture2.setBackgroundImage(UIImage.init(named: "ezsavior_icon_2.png"), for: .normal)
        self.picture3.setBackgroundImage(UIImage.init(named: "ezsavior_icon_3.png"), for: .normal)
        self.picture4.setBackgroundImage(UIImage.init(named: "ezsavior_icon_4.png"), for: .normal)
        self.picture1.layer.masksToBounds = true
        self.picture2.layer.masksToBounds = true
        self.picture3.layer.masksToBounds = true
        self.picture4.layer.masksToBounds = true
        self.picture1.layer.cornerRadius = picture1.frame.height/2
        self.picture2.layer.cornerRadius = picture1.frame.height/2
        self.picture3.layer.cornerRadius = picture1.frame.height/2
        self.picture4.layer.cornerRadius = picture1.frame.height/2
        self.cancelbtn.layer.cornerRadius = 10
        self.viewShow.backgroundColor = UIColor.init(rgb: 0xF3D4FA)
        self.viewShow.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        hideKB()
        self.view.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
        // Do any additional setup after loading the view.
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

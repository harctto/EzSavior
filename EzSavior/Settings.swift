//
//  SettingsViewController.swift
//  EzSavior
//
//  Created by Hatto on 8/10/2563 BE.
//

import UIKit
import Firebase

class Settings: UIViewController, UITabBarControllerDelegate {

    
    @IBOutlet weak var outletProfileChange: UIButton!
    @IBOutlet weak var outletChangeUsername: UIButton!
    @IBOutlet weak var outletChangePassword: UIButton!
    @IBOutlet weak var outletLogout: UIButton!
    
    @IBOutlet weak var profilePictureShow: UIImageView!
    @IBOutlet weak var usernameShow: UILabel!
    var currentUsernameSettings:String = ""
    
    @IBAction func btnLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Logout", message: .none, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "login", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    func outletAdjust() {
        outletProfileChange.contentHorizontalAlignment = .left
        outletChangeUsername.contentHorizontalAlignment = .left
        outletChangePassword.contentHorizontalAlignment = .left
        outletLogout.contentHorizontalAlignment = .left
    }
    
    func loadSettingsData() {
        let ref = Database.database().reference().child("\(currentUsernameSettings)/")
        ref.child("nameuse").observeSingleEvent(of: .value, with: { (nameuse) in
            self.usernameShow.text = nameuse.value as? String
        })
        
        ref.child("profilePicture").observeSingleEvent(of: .value){ (profilePic) in
            let picName:String = profilePic.value as! String
            self.profilePictureShow.image = UIImage.init(named: picName)
            self.profilePictureShow.layer.cornerRadius = self.profilePictureShow.frame.height/2
        }
        
        self.usernameShow.layer.masksToBounds = true
        self.usernameShow.layer.cornerRadius = 20
        self.usernameShow.layer.shadowColor = UIColor.darkGray.cgColor
        self.usernameShow.layer.shadowRadius = 3
        self.usernameShow.layer.shadowOpacity = 0.4
        self.usernameShow.layer.shadowOffset = CGSize(width: 6, height: 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let valueTabbar = tabBarController as! BaseTabbar
        currentUsernameSettings = String(describing: valueTabbar.currentUsername)
        
        outletAdjust()
        loadSettingsData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        outletAdjust()
        loadSettingsData()
        print("settings loaded")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeUsername" {
            let sender = segue.destination as? ChangeUsername
            sender?.currentUsernameChangePage = self.currentUsernameSettings
        }
        else if segue.identifier == "changePassword" {
            let sender = segue.destination as? ChangePassword
            sender?.currentUsernameChangePage = self.currentUsernameSettings
        }
        else if segue.identifier == "changeProfilePicture" {
            let sender = segue.destination as? ChangeProfilePicture
            sender?.currentUsernameChangeProfilePicture = self.currentUsernameSettings
        }
    }
    

}

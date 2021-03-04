//
//  BaseTabbar.swift
//  EzSavior
//
//  Created by Hatto on 16/11/2563 BE.
//

import UIKit

class BaseTabbar: UITabBarController, UITabBarControllerDelegate {
    
    var currentUsername:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.delegate = self
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

//
//  HomeViewController.swift
//  EzSavior
//
//  Created by Hatto on 8/10/2563 BE.
//

import UIKit
import Firebase

class Home: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var homeview: UIView!
    @IBOutlet weak var lbCurrentUsername: UILabel!
    @IBOutlet weak var lbBalanced: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var mainButton: AddButton!
    @IBOutlet weak var btnOutcome: ChooseBtn!
    @IBOutlet weak var btnIncome: ChooseBtn!
    @IBOutlet weak var lbIncome: Label!
    @IBOutlet weak var lbOutcome: Label!
    
    var currentUsername:String = ""
    var dataArray:[String] = [""]
    var dataRow:Int = 0
    let ref = Database.database().reference()
    var countforrow:Int = 0
    var keepdate:[Any]=[]

    
    //loadDataFromFirebase
    func loaddata(){
        ref.child("\(currentUsername)/data/").observeSingleEvent(of: .value){ [self]
            (data) in
            
            if let datadate = data.value as? NSDictionary{
                keepdate = datadate.allKeys
            }
            
            print("keepdate=",keepdate)
            
        }
        
        //load countforrow
        ref.child("\(currentUsername)/data").observeSingleEvent(of: .value){
            (data) in
            self.countforrow = Int(data.childrenCount)
            self.homeTableView.reloadData()
            if self.countforrow == 0 {
                self.homeTableView.isHidden = true
            }
        }
        
        //load Username
        ref.child("\(currentUsername)/nameuse").observeSingleEvent(of: .value, with: { (username) in
            
            self.lbCurrentUsername.text = username.value as? String
        })
        
        //load balance
        ref.child("\(currentUsername)/money/balance").observeSingleEvent(of: .value){ (balance) in
            self.lbBalanced.text = ("     ฿ \(balance.value as! String)")
        }
        
        //load Picture
        ref.child("\(currentUsername)/profilePicture").observeSingleEvent(of: .value){ (profilePic) in
            let picName:String = profilePic.value as! String
            self.profilePicture.image = UIImage.init(named: picName)
            self.profilePicture.layer.cornerRadius = 50
        }

        loadView()

        //for reload table
        self.homeTableView.reloadData()
        
        //adjustUI
        self.homeview.layer.masksToBounds = true
        self.homeview.layer.cornerRadius = 50
        self.homeview.layer.backgroundColor = UIColor.init(rgb: 0xB9D4DB).cgColor
        self.lbBalanced.layer.cornerRadius = 18
        self.lbBalanced.layer.backgroundColor = UIColor.init(red: 242/255, green: 164/255, blue: 144/255, alpha: 1).cgColor
        self.lbBalanced.font = .systemFont(ofSize: 17, weight: .semibold)
        self.lbBalanced.textColor=UIColor.white
    }
    
    @IBAction func btnAdding(_ sender: Any) {
        if mainButton.imageView?.transform != .identity {
            //self.secondButton.alpha = 1
            animate(true)
        } else {
            animate(false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countforrow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! HomeTableViewCell
        
        tableView.rowHeight = cell.cellview.frame.height+25
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        
        let ref = Database.database().reference().child("\(currentUsername)/data")
        ref.observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                cell.textLabel?.numberOfLines = 100
                //cell.textLabel?.text = data.allKeys[indexPath.row] as? String
                cell.txtdate.text = data.allKeys[indexPath.row] as? String
                cell.txtdate.backgroundColor = UIColor.clear
                
                cell.cellview.backgroundColor = UIColor.init(red: 242/255, green: 164/255, blue: 144/255, alpha: 1)
                cell.cellview.layer.cornerRadius = 20
                cell.cellview.layer.shadowColor = UIColor.darkGray.cgColor
                cell.cellview.layer.shadowRadius = 3
                cell.cellview.layer.shadowOpacity = 0.4
                cell.cellview.layer.shadowOffset = CGSize(width: 6, height: 6)
                cell.backgroundColor = UIColor.clear
            }
        })
        return cell
    }
    
    
    func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: Any] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loaddata()
        print("Home Page Loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaddata()
        print("Home Page Loaded")
    }
    
    override func viewDidLoad() {
        let valueTabbar = tabBarController as! BaseTabbar
        currentUsername = String(describing: valueTabbar.currentUsername)
        
        loaddata()
        
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addingIncome" {
            let sender = segue.destination as! Income
            sender.currentUsernameAddingPage = currentUsername
        }
        else if segue.identifier == "addingOutcome" {
            let sender = segue.destination as! Outcome
            sender.currentUsernameAddingPage = currentUsername
        }
        else if segue.identifier == "datesent" {
            let vc = segue.destination as! PopUpViewController
            vc.monthsent = homeTableView.indexPathForSelectedRow!.row
            vc.keepdate = keepdate
            vc.currentUsername = currentUsername
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //animate button
    override func viewDidLayoutSubviews() {
        
        self.mainButton.imageView?.contentMode = .center
        self.mainButton.imageView?.clipsToBounds = false
        
        self.btnIncome.center = self.btnOutcome.center
        self.btnOutcome.center = self.mainButton.center
        
        self.btnIncome.alpha = 0
        self.lbIncome.alpha = 0
        self.lbOutcome.alpha = 0
        
    }
    
    func animate(_ isStart: Bool) {
        
        if isStart {
            UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut, animations: {
                self.btnOutcome.transform = CGAffineTransform(translationX: -30, y: -30)
                
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.btnOutcome.transform = CGAffineTransform(translationX: -30, y: -90)
                    UIView.animate(withDuration: 0.2,delay:0.2, animations: {
                        self.lbOutcome.alpha = 1
                    })
                    
                    UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
                        self.btnIncome.alpha = 1
                        self.btnIncome.transform = CGAffineTransform(translationX: 0, y: -90)
                        UIView.animate(withDuration: 0.2,delay:0.2, animations: {
                            self.lbIncome.alpha = 1
                        })
                    })
                })
            }).startAnimation()
        } else {
            UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut, animations: {
                
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
                    self.lbIncome.alpha = 0
                    self.btnIncome.transform = .identity
                    self.btnIncome.alpha = 0
                    
                    UIView.animate(withDuration: 0.3, delay: 0.3 , options: .curveEaseInOut, animations: {
                        self.btnOutcome.transform = .identity
                        self.lbOutcome.alpha = 0
                    })
                })
            }).startAnimation()
        }
    }
}

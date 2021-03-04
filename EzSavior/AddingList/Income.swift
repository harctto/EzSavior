//
//  Income.swift
//  EzSavior
//
//  Created by Hatto on 30/11/2563 BE.
//

import UIKit
import DropDown
import Firebase

class Income: UIViewController {

    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var subTopView: UIView!
    @IBOutlet weak var typeChooseView: UIView!
    @IBOutlet weak var lbChoosen: UILabel!
    @IBOutlet weak var imgChoosen: UIImageView!
    @IBOutlet weak var monthChooseView: UIView!
    @IBOutlet weak var selectMonth: UILabel!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btndone: UIButton!
    @IBOutlet weak var moneyInput: UITextField!
    @IBOutlet weak var tfNotes: UITextField!
    
    let ref = Database.database().reference()
    var fDate:String = ""
    var countforlist:Int = 0
    var keepType:String = ""
    var inORout:String = "income"
    var currentUsernameAddingPage:String = ""
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    let format = DateFormatter()
    let date = Date()
    let images = ["gift.png","salary.png","sales.png","prize.png","else.png"]
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "Gift",
            "Salary",
            "Sales",
            "Prize",
            "Else"
        ]
        let imagesDD = [
            "Gift.png",
            "Salary.png",
            "Sales.png",
            "Prize.png",
            "Else.png"
        ]
        menu.cellNib = UINib(nibName: "OutcomeDDCell", bundle: nil)
        menu.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? OutcomeDDCell else {
                return
            }
            cell.DDImage.image = UIImage(named: imagesDD[index])
        }
        return menu
    }()
    
    func chooseTypeSetup() {
        menu.anchorView = typeChooseView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        typeChooseView.addGestureRecognizer(gesture)
        typeChooseView.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        typeChooseView.layer.cornerRadius = 20
        
        menu.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        menu.textColor = .white
        menu.selectedTextColor = UIColor.black
        menu.separatorColor = UIColor.init(rgb: 0xC4C9F5)
        menu.textColor = UIColor.black
        
        //selectionMethod
        menu.selectionAction = { index,title in
            self.keepType = title
            self.lbChoosen.text = title
            self.imgChoosen.image = UIImage(named: self.images[index])
        }
    }
    
    @objc func didTapTopItem() {
        menu.show()
    }
    
    func adjustUI() {
        self.view.backgroundColor = UIColor.init(rgb: 0xE5F1FF)
        
        self.TopView.layer.masksToBounds = true
        self.TopView.layer.cornerRadius = 50
        self.TopView.layer.backgroundColor = UIColor.init(rgb: 0x0D7848).cgColor
        self.subTopView.layer.backgroundColor = UIColor.init(rgb: 0x0D7848).cgColor
        
        self.typeChooseView.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        self.typeChooseView.layer.cornerRadius = 20
        self.typeChooseView.layer.shadowColor = UIColor.darkGray.cgColor
        self.typeChooseView.layer.shadowRadius = 3
        self.typeChooseView.layer.shadowOpacity = 0.4
        self.typeChooseView.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.monthChooseView.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        self.monthChooseView.layer.cornerRadius = 20
        self.monthChooseView.layer.shadowColor = UIColor.darkGray.cgColor
        self.monthChooseView.layer.shadowRadius = 3
        self.monthChooseView.layer.shadowOpacity = 0.4
        self.monthChooseView.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.btndone.backgroundColor = UIColor.init(rgb: 0x0D7848)
        self.btndone.layer.cornerRadius = 15
        self.btndone.layer.shadowColor = UIColor.darkGray.cgColor
        self.btndone.layer.shadowRadius = 3
        self.btndone.layer.shadowOpacity = 0.4
        self.btndone.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.btncancel.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        self.btncancel.layer.cornerRadius = 15
        self.btncancel.layer.shadowColor = UIColor.darkGray.cgColor
        self.btncancel.layer.shadowRadius = 3
        self.btncancel.layer.shadowOpacity = 0.4
        self.btncancel.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.tfNotes.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        self.tfNotes.layer.cornerRadius = 20
        self.tfNotes.layer.shadowColor = UIColor.darkGray.cgColor
        self.tfNotes.layer.shadowRadius = 3
        self.tfNotes.layer.shadowOpacity = 0.4
        self.tfNotes.layer.shadowOffset = CGSize(width: 6, height: 6)
        
        self.moneyInput.backgroundColor = UIColor.init(rgb: 0x0D7848)
        self.moneyInput.layer.cornerRadius = 20
        self.moneyInput.layer.shadowColor = UIColor.darkGray.cgColor
        self.moneyInput.layer.shadowRadius = 3
        self.moneyInput.layer.shadowOpacity = 0.4
        self.moneyInput.layer.shadowOffset = CGSize(width: 6, height: 6)
    }
    
    @IBAction func chooseMonth(_ sender: UIButton) {
        datePicker.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        datePicker.tintColor = UIColor.white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0,
                                  y: UIScreen.main.bounds.size.height - 200,
                                  width: UIScreen.main.bounds.size.width,
                                  height: 200)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0,
                                          y: UIScreen.main.bounds.size.height - 200,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 25))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor.init(rgb: 0x0D7848)
        toolBar.backgroundColor = UIColor.init(rgb: 0x0D7848)
        self.view.addSubview(toolBar)
    }
    
    //Change date value realtime
    @objc func dateChanged(_ sender: UIDatePicker?) {
        format.dateFormat = "MMM d, yyyy"
        format.locale = Locale(identifier: "en")
        
        if let date = sender?.date {
            self.selectMonth.text = format.string(from: date)
            print("Picked the date \(format.string(from: date))")
            self.fDate = format.string(from: date)
        }
        
        format.dateFormat = "MMMM yyyy"
        format.locale = Locale(identifier: "en")
        
        if let date = sender?.date {
            self.fDate = format.string(from: date)
            print(fDate)
        }
    }

    //done
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if moneyInput.text == "" && keepType == ""{
            let alert = UIAlertController(title: .none, message: "Please Input Money", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (UIAlertAction) in
            }))
            self.present(alert, animated: true)
        }
        
        //Income Method
        else if inORout == "income" {
            
            //Create new DB id not exists
            ref.child("\(currentUsernameAddingPage)/monthly/\(fDate)").observe(.value) { snapshot in
                if snapshot.exists() {
                    return
                }
                else {
                    return self.ref.child("\(self.currentUsernameAddingPage)/monthly/").updateChildValues(
                        ["\(self.fDate)" :
                            ["allIncome" : "0" ,
                             "allOutcome" : "0"
                            ]
                        ]
                    )
                }
            }
            
            // fetching countforlist
            ref.child("\(currentUsernameAddingPage)/data/\(selectMonth.text!)/income").observeSingleEvent(of: .value){ [self](data) in
                countforlist = Int(data.childrenCount)
                print("list",countforlist)
                
                // adding data
                ref.child("\(currentUsernameAddingPage)/data/\(selectMonth.text!)/income").updateChildValues(
                    [ "list\(countforlist+1)" :
                        ["category" : "\(keepType)" ,
                         "money" : "\(moneyInput.text!)" ,
                         "note" : "\(tfNotes.text!)"
                        ]
                    ]
                )
                
                // fetching balance
                var totalbalance:Int=0
                ref.child("\(currentUsernameAddingPage)/money/balance").observeSingleEvent(of: .value){ (balance) in
                    totalbalance = Int(balance.value as! String)!
                    print(totalbalance)
                    print("finish fetching balance")
                    
                    // update balance
                    ref.child("\(currentUsernameAddingPage)/money/balance").setValue(
                        String(totalbalance+Int(moneyInput.text!)!)
                    )
                    print("finish update balance")
                }
                
                // fetching Income
                var income:Int=0
                ref.child("\(currentUsernameAddingPage)/monthly/\(fDate)/allIncome").observeSingleEvent(of: .value){ (allIncome) in
                    income = Int(allIncome.value as! String)!
                    
                    // update Income
                    ref.child("\(currentUsernameAddingPage)/monthly/\(fDate)").updateChildValues(
                        [
                            "allIncome" : "\(String(income+Int(moneyInput.text!)!))"
                        ]
                    )
                }
            }
            let alert = UIAlertController(title: .none, message: "List added", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        } // end if income
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        hideKB()
        super.viewDidLoad()
        print("Income user : \(currentUsernameAddingPage)")
        format.dateFormat = "MMM d, yyyy"
        format.locale = Locale(identifier: "en")
        selectMonth.text = format.string(from: date)
        print(selectMonth.text!)
        
        format.dateFormat = "MMMM yyyy"
        format.locale = Locale(identifier: "en")
        fDate = format.string(from: date)
        print(fDate)
        
        adjustUI()
        chooseTypeSetup()
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}

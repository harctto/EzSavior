//
//  PopUpViewController.swift
//  EzSavior
//
//  Created by Khing Thananut on 2/12/2563 BE.
//

import UIKit
import Firebase

class PopUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let ref = Database.database().reference()
    var currentUsername:String=""
    var countforincome:Int=0
    var countforoutcome:Int=0

    var monthsent:Int=0
    var keepdate:[Any]=[]
    @IBOutlet weak var tableIncome: UITableView!
    @IBOutlet weak var tableOutcome: UITableView!
    @IBOutlet weak var back: UIButton!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loaddata(){
        
              //load countforrow
              ref.child("\(currentUsername)/data/").observeSingleEvent(of: .value){ [self]
                  (data) in
                  
                  if let datadate = data.value as? NSDictionary{
                      keepdate = datadate.allKeys
                  }
                  
                  print("keepdate=",keepdate)
                  
              }
              
        ref.child("\(currentUsername)/data/\(keepdate[monthsent])/income").observeSingleEvent(of: .value, with: { [self] (income) in
            
            countforincome=Int(income.childrenCount)
        })
        
        ref.child("\(currentUsername)/data/\(keepdate[monthsent])/outcome").observeSingleEvent(of: .value, with: { [self] (outcome) in
            
            self.countforoutcome=Int(outcome.childrenCount)
        })
        
        print("load pop up fin")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 50 { //income
            return countforincome
        }
        else { //outcome
            return countforoutcome
        }
    }
    
    func istable(){
        var isempty:Bool
        ref.child("\(currentUsername)/data/\(keepdate[monthsent])/income").observeSingleEvent(of: .value, with: { [self] (income) in
            if income.exists() == false {
                tableIncome.isHidden = true
            }
            else {
                tableIncome.isHidden = false
            }
            })
        
        ref.child("\(currentUsername)/data/\(keepdate[monthsent])/outcome").observeSingleEvent(of: .value, with: { [self] (outcome) in
            if outcome.exists() == false {
                tableOutcome.isHidden = true
            }
            else {
                tableOutcome.isHidden = false
            }
            })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 50 { //income
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! HomeTableInfoCell
            tableView.rowHeight = cell.viewInfoCell.frame.height+15
            tableView.separatorColor = UIColor.clear
            tableView.backgroundColor = UIColor.init(red: 242/255, green: 164/255, blue: 144/255, alpha: 1)
            tableView.layer.cornerRadius = 20
            
            
            let ref = Database.database().reference().child("\(currentUsername)/data")
            
            //cell.imgIconType.image = UIImage.init(named: "food.png")
            print("tableview income")
            
            var incomearray = [[String]](repeating: [String](repeating: "", count: 3), count: countforincome )
            ref.child("\(keepdate[monthsent])/income").observe(.value, with: { [self] (list) in
                            if let listdata = list.value as? NSDictionary{
                                var count:Int=0

                                for i in listdata{

                                    ref.child("\(keepdate[self.monthsent])/income/\(i.key)").observe(.value, with: { (sub) in
                                        if let sublist = sub.value as? NSDictionary{
                                            incomearray[count][0] = "\(sublist.value(forKey: "money")!)"
                                            incomearray[count][1] = "\(sublist.value(forKey: "category")!)"
                                            incomearray[count][2] = "\(sublist.value(forKey: "note")!)"
                                            
                                            cell.lbMoney.text = incomearray[indexPath.row][0]
                                            cell.lbType.text = incomearray[indexPath.row][1]
                                            cell.lbNotes.text = incomearray[indexPath.row][2]
                                            cell.imgIconType.image = UIImage.init(named: incomearray[indexPath.row][1]+".png")
                                            print(incomearray)
                                            print("count=",count)
                                            count+=1

                                    }
                                })

                            }
                        }//end
                    })
            cell.viewInfoCell.layer.cornerRadius = 20
            cell.viewInfoCell.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
            cell.viewInfoCell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.viewInfoCell.layer.shadowRadius = 3
            cell.viewInfoCell.layer.shadowOpacity = 0.4
            cell.viewInfoCell.layer.shadowOffset = CGSize(width: 6, height: 6)
            cell.backgroundColor=UIColor.clear
            return cell
        }
        
        else { //outcome
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! HomeTableInfoOutcomeCell
            tableView.rowHeight = cell.viewInfoCell.frame.height+15
            tableView.separatorColor = UIColor.clear
            tableView.backgroundColor = UIColor.init(red: 242/255, green: 164/255, blue: 144/255, alpha: 1)
            tableView.layer.cornerRadius = 20

            let ref = Database.database().reference().child("\(currentUsername)/data")

            //cell.imgIconType.image = UIImage.init(named: "travel.png")
            print("tableview out")
            //here
            
            var outcomearray = [[String]](repeating: [String](repeating: "", count: 3), count: countforoutcome )
            ref.child("\(keepdate[monthsent])/outcome").observe(.value, with: { [self] (list) in
                            if let listdata = list.value as? NSDictionary{
                                var count:Int=0

                                for i in listdata{

                                    ref.child("\(keepdate[self.monthsent])/outcome/\(i.key)").observe(.value, with: { (sub) in
                                        if let sublist = sub.value as? NSDictionary{
                                            outcomearray[count][0] = "\(sublist.value(forKey: "money")!)"
                                            outcomearray[count][1] = "\(sublist.value(forKey: "category")!)"
                                            outcomearray[count][2] = "\(sublist.value(forKey: "note")!)"
                                            
                                            cell.lbMoney.text = outcomearray[indexPath.row][0]
                                            cell.lbType.text = outcomearray[indexPath.row][1]
                                            cell.lbNotes.text = outcomearray[indexPath.row][2]
                                            cell.imgIconType.image = UIImage.init(named: outcomearray[indexPath.row][1]+".png")

                                            print(outcomearray)
                                            print("count=",count)
                                            count+=1

                                    }
                                })

                            }
                        }//end
                    })
            cell.backgroundColor=UIColor.clear
            cell.viewInfoCell.layer.cornerRadius = 20
            cell.viewInfoCell.backgroundColor = UIColor.init(rgb: 0xB9D4DB)
            cell.viewInfoCell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.viewInfoCell.layer.shadowRadius = 3
            cell.viewInfoCell.layer.shadowOpacity = 0.4
            cell.viewInfoCell.layer.shadowOffset = CGSize(width: 6, height: 6)
            return cell
            
        }
    }
    

    override func viewDidLoad() {
        istable()
        super.viewDidLoad()
        loaddata()
        view.backgroundColor = UIColor.init(rgb: 0xB7C5E8)
        print("keepdate=",keepdate[monthsent])
        print("keepdate []",keepdate)
        print("monthsent",monthsent)
        back.backgroundColor = UIColor.init(red: 242/255, green: 164/255, blue: 144/255, alpha: 1)
        back.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    
}

extension PopUpViewController {
    func setTableViewDataSourceDelegate
        <D:UITableViewDelegate & UITableViewDataSource>
        (_ dataSourceDelegate: D, forRow row:Int)
    {
        tableIncome.delegate = dataSourceDelegate
        tableIncome.dataSource = dataSourceDelegate
        tableIncome.reloadData()
        
        tableOutcome.delegate = dataSourceDelegate
        tableOutcome.dataSource = dataSourceDelegate
        tableOutcome.reloadData()
    }
}

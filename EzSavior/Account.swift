//
//  AccountViewController.swift
//  EzSavior
//
//  Created by Hatto on 8/10/2563 BE.
//

import UIKit
import Firebase
import Charts
import DropDown

class Account: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var analyticsview: UIView!
    @IBOutlet weak var incomeShow: UILabel!
    @IBOutlet weak var outcomeShow: UILabel!
    @IBOutlet weak var monthShow: UILabel!
    @IBOutlet weak var chartShow: PieChartView!
    @IBOutlet weak var chooseMonthView: UIView!
    var currentUsernameAccount:String = ""
    let date = Date()
    let format = DateFormatter()
    var fDate:String = ""
    let ref = Database.database().reference()
    var allincome:Int = 0
    var alloutcome:Int = 0
    let menu:DropDown = DropDown()
    
    //CreatePieChartWithFirebase
    func pieChartSetup() {
        let ref = Database.database().reference()
        ref.child("\(currentUsernameAccount)/monthly/\(fDate)").observe(.value){ (data) in
            guard let a = data.value as? NSDictionary else {
                return
            }
            guard let income = a.value(forKey: "allIncome") as? String else {
                return
            }
            guard let outcome = a.value(forKey: "allOutcome") as? String else {
                return
            }
            guard let valueIncome = Double(income) else {
                return
            }
            guard let valueOutcome = Double(outcome) else {
                return
            }
            self.chartShow.chartDescription?.enabled = false
            self.chartShow.drawHoleEnabled = false
            self.chartShow.rotationAngle = 0
            self.chartShow.rotationEnabled = false
            self.chartShow.isUserInteractionEnabled = true

            var chartInfo:[PieChartDataEntry] = Array()
            chartInfo.append(PieChartDataEntry(value: valueIncome, label: "Income"))
            chartInfo.append(PieChartDataEntry(value: valueOutcome, label: "Outcome"))

            let dataset = PieChartDataSet(entries: chartInfo, label: "")

            let incomecolor = UIColor.init(rgb: 0x589CB2)
            let outcomecolor = UIColor.init(rgb: 0xE67380)

            dataset.colors = [incomecolor , outcomecolor]
            dataset.drawValuesEnabled = false

            self.chartShow.data = PieChartData(dataSet: dataset)
        }
    }
    
    //adjustUI
    func accountadjust(){
        self.monthShow.text = fDate
        self.incomeShow.layer.masksToBounds = true
        self.outcomeShow.layer.masksToBounds = true
        self.incomeShow.layer.cornerRadius = 16
        self.outcomeShow.layer.cornerRadius = 16
    }
    
    //loadShowDataFromFirebase
    func loaddata() {
        let valueTabbar = tabBarController as! BaseTabbar
        currentUsernameAccount = String(describing: valueTabbar.currentUsername)

        let ref = Database.database().reference()
        ref.child("\(String(describing: valueTabbar.currentUsername))/monthly/\(self.fDate)/allIncome").observeSingleEvent(of: .value, with: { snapshot in
            self.incomeShow.text = snapshot.value as? String
            self.incomeShow.textColor = .black
        })
        
        ref.child("\(String(describing: valueTabbar.currentUsername))/monthly/\(self.fDate)/allOutcome").observeSingleEvent(of: .value, with: { [self] snapshot in
            self.outcomeShow.text = snapshot.value as? String
            self.outcomeShow.textColor = .black
        })
    }
    
    //setup-Menu
    func chooseMonthMenuSetup() {
        //observeDB
        ref.child("\(currentUsernameAccount)/monthly").observe(.value){ month in
            guard let keepMonth = month.value as? NSDictionary else {
                return
            }
            
            //convert value
            let allMonth:[String] = keepMonth.allKeys as! [String]
            
            var convertArray:[Date] = []
            var keepmonth:[String] = []
            
            //dateFormat
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            //Convert String to Date for prepare sorting
            for dat in allMonth {
                let date = dateFormatter.date(from: dat)
                if let date = date {
                    convertArray.append(date)
                }
            }
            
            //sorting method
            let sortingDate = convertArray.sorted(by: { $0.compare($1) == .orderedAscending })
        
            //append sorted to keepmonth
            for i in 0...sortingDate.count-1 {
                keepmonth.append(dateFormatter.string(from: sortingDate[i]))
            }
            
            self.menu.dataSource = keepmonth
        }
        
        //create Menu by dropdown
        menu.anchorView = chooseMonthView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        chooseMonthView.addGestureRecognizer(gesture)
        chooseMonthView.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        chooseMonthView.layer.cornerRadius = 20
        
        menu.backgroundColor = UIColor.init(rgb: 0xC5DCE9)
        menu.textColor = .white
        menu.selectedTextColor = UIColor.black
        
        //selectionMethod
        menu.selectionAction = { index,title in
            self.fDate = title
            self.monthShow.text = title
            self.pieChartSetup()
            self.loaddata()
        }
        
    }
    
    @objc func didTapTopItem() {
        menu.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.format.dateFormat = "MMMM yyyy"
        self.format.calendar = Calendar(identifier: .iso8601)
        self.format.locale = Locale(identifier: "en")
        self.fDate = format.string(from: date)
        loaddata()
        accountadjust()
        pieChartSetup()
        chooseMonthMenuSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loaddata()
        accountadjust()
        pieChartSetup()
        chooseMonthMenuSetup()
        print("Accout Page Loaded")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

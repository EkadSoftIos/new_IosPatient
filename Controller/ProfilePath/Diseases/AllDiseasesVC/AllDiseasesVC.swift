//
//  AllDiseasesVC.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class AllDiseasesVC: UIViewController {
    @IBOutlet var dieseasesTableView: UITableView!
    @IBOutlet var addView: UIView!
    
    var model: UserDataModel?
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.addView.rotate(angle: 180)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setEmptyTableView()
        self.navigationItem.title = "Diseases".localized
    }
    func setEmptyTableView(){
        if model?.message?.tblPatientDisease?.count == 0{
            dieseasesTableView.setEmptyView()
        }else{
            dieseasesTableView.restore()
        }
    }
    func setupTableView(){
        dieseasesTableView.register(DieseasesCell.nib, forCellReuseIdentifier: "DieseasesCell")
        dieseasesTableView.separatorStyle = .none
        dieseasesTableView.delegate = self
        dieseasesTableView.dataSource = self
        dieseasesTableView.reloadAnimationTable()
    }
    @IBAction func add_Click(_ sender: Any) {
        let vc = AddDieseasesVC()
        vc.Delegete = self
        vc.isUpdate = false
        vc.model = model
        show(vc, sender: nil)
    }
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "yyyy-MM-dd"
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return ""
       }
   }

}
extension AllDiseasesVC: AddDieseases , DeleteDiseases{
    func Data(isAdded: Bool) {
        callApiAdd()
    }
    
    
}

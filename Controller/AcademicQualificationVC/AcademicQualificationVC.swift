//
//  AcademicQualificationVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AcademicQualificationVC: UIViewController {
    
    var academicQualifications: [TblEmployeeAcademicQualification]?
    
    @IBOutlet var acadimicTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Academic Qualification".localized
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
 
    }
    func setupTableView(){
        acadimicTableView.register(AcademicQualificationCell.nib, forCellReuseIdentifier: "AcademicQualificationCell")
        acadimicTableView.delegate = self
        acadimicTableView.dataSource = self
        acadimicTableView.separatorStyle = .none
    }


}
extension AcademicQualificationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academicQualifications?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademicQualificationCell") as! AcademicQualificationCell
        cell.selectionStyle = .none
        
        cell.acadimicDate.text = String(academicQualifications?[indexPath.row].yearOfComplete ?? 0000)
         let imgURL = URL(string: "\(Constants.baseURLImage)\(academicQualifications?[indexPath.row].qualificationImagePath ?? "")")
        cell.academicImage?.kf.indicatorType = .activity
               cell.academicImage?.kf.setImage(with: imgURL)
        cell.acadimicFrom.text = academicQualifications?[indexPath.row].qualificationFromname_Localized ?? ""
        cell.acadimicName.text = academicQualifications?[indexPath.row].graduationType_Localized ?? ""
        cell.acadimicQualification.text = academicQualifications?[indexPath.row].qualificationEn ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

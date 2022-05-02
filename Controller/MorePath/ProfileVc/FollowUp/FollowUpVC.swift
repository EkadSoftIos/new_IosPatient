//
//  FollowUpVC.swift
//  E4 Patient
//
//  Created by Nada on 9/29/21.
//

import UIKit

class FollowUpVC: UIViewController {
    
    var followUpData: [FollowUpCardList]?

    @IBOutlet weak var followUpTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Follow Up"
        
        if followUpData?.count == 0{
            followUpTB.setEmptyView()
        }else{
            followUpTB.restore()
        }
        
        followUpTB.rowHeight = 44
        followUpTB.estimatedRowHeight = UITableView.automaticDimension
        followUpTB.separatorStyle = .none
        followUpTB.delegate = self
        followUpTB.dataSource = self
        followUpTB.register(UINib(nibName: "FollowUpCell", bundle: nil), forCellReuseIdentifier: "FollowUpCell")
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension FollowUpVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followUpData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowUpCell", for: indexPath) as! FollowUpCell
        cell.selectionStyle = .none
        
        cell.noteLbl.text = followUpData?[indexPath.row].notes ?? ""
        cell.tempLbl.text = followUpData?[indexPath.row].temperature ?? ""
        cell.hyperLbl.text = followUpData?[indexPath.row].hypertension ?? ""
        cell.weightLbl.text = followUpData?[indexPath.row].weight ?? ""
        cell.heightLbl.text = followUpData?[indexPath.row].height ?? ""
        cell.diabetesLbl.text = followUpData?[indexPath.row].diabetes ?? ""
        let milisecond = followUpData?[indexPath.row].createDate ?? ""
        cell.dateLbl.text = convertDateFormat(inputDate: milisecond)
        
//        cell.trachBtn.tag = indexPath.row
//        cell.trachBtn.addTarget(self, action: #selector(moveBtn(sender:)), for: .touchUpInside)
//        cell.editBtn.tag = indexPath.row
//        cell.editBtn.addTarget(self, action: #selector(moveBtn(sender:)), for: .touchUpInside)
        
        return cell
    }
//    @objc func moveBtn(sender: UIButton) {
//        let indexPath = sender.tag
//    }
//    @objc func editBtn(sender: UIButton) {
//        let indexPath = sender.tag
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
         let oldDate = olDateFormatter.date(from: inputDate) ?? Date()
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy"
        convertDateFormatter.locale = Locale(identifier: "en_US_POSIX")
         return convertDateFormatter.string(from: oldDate)
    }
}

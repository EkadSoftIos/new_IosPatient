//
//  AppointmentHistoryPopup.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class AppointmentHistoryPopup: UIViewController {

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var historyPopUpTableView: UITableView!
    var patientNameString = ""
    var doctorNameString = ""
    var appointmentHistoryArray : [AppointmentHistory]?
    override func viewDidLoad() {
        super.viewDidLoad()
setupTableView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        historyPopUpTableView.reloadData()
    }
    func setupTableView(){
        historyPopUpTableView.register(AppointmentHistoryPopupCell.nib, forCellReuseIdentifier: "AppointmentHistoryPopupCell")
        historyPopUpTableView.delegate = self
        historyPopUpTableView.dataSource = self
        historyPopUpTableView.separatorStyle = .none
    }
    @IBAction func close_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
extension AppointmentHistoryPopup: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentHistoryArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentHistoryPopupCell") as! AppointmentHistoryPopupCell
        cell.selectionStyle = .none
        let appointmentHistoryModel = appointmentHistoryArray?[indexPath.row]
        if appointmentHistoryModel?.historyStatus == 1 {
            cell.appointmentHistoryLBL.text = "\(patientNameString)\(" ")\(appointmentHistoryModel?.historyStatusName ?? "")"
        }else if appointmentHistoryModel?.historyStatus == 2{
            cell.appointmentHistoryLBL.text = "\(doctorNameString)\(" ")\(appointmentHistoryModel?.historyStatusName ?? "")"
        }else if appointmentHistoryModel?.historyStatus == 3{
            cell.appointmentHistoryLBL.text = "\(patientNameString)\(" ")\(appointmentHistoryModel?.historyStatusName ?? "")"
        }else if appointmentHistoryModel?.historyStatus == 4{
            cell.appointmentHistoryLBL.text = "\(doctorNameString)\(" ")\(appointmentHistoryModel?.historyStatusName ?? "")"
        }else if appointmentHistoryModel?.historyStatus == 5{
            cell.appointmentHistoryLBL.text = "\(doctorNameString)\(" ")\(appointmentHistoryModel?.historyStatusName ?? "")"

        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

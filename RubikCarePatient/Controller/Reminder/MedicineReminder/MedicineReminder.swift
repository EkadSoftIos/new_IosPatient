//
//  MedicineReminder.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 23/05/2022.
//

import UIKit

class MedicineReminder: UIViewController {

    @IBOutlet weak var medicineTB: UITableView!
    @IBOutlet weak var noDataBG: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func didTappedAddMedicine(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddReminderVC")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - Setup View
extension MedicineReminder {
    fileprivate func setupUI() {
        self.title = "Medicine Reminder"
        searchView.ShadowView(view: searchView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        registerTB()
    }
    
    fileprivate func registerTB() {
        medicineTB.delegate = self
        medicineTB.dataSource = self
        medicineTB.separatorStyle = .none
        medicineTB.rowHeight = UITableView.automaticDimension
        medicineTB.estimatedRowHeight = 44
        medicineTB.register(UINib(nibName: "MedicineReminderTBCell", bundle: nil), forCellReuseIdentifier: "MedicineReminderTBCell")
    }
}

//MARK: - UITableView Delegate
extension MedicineReminder: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SetReminderVC")

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - UITableView DataSource
extension MedicineReminder: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineReminderTBCell", for: indexPath) as! MedicineReminderTBCell
        
        return cell
    }
}

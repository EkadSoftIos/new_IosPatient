//
//  ConsultationLogVC.swift
//  E4 Patient
//
//  Created by Nada on 8/30/21.
//

import UIKit

class ConsultationLogVC: UIViewController {

    @IBOutlet weak var searchBGView: UIView!
    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var consultationTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        consultationTB.delegate = self
        consultationTB.dataSource = self
        consultationTB.register(UINib(nibName: "ConsultationLogTBCell", bundle: nil), forCellReuseIdentifier: "ConsultationLogTBCell")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBGView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
        filterBGView.setupShadowView(cornerRadius: 13, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
    }

    @IBAction func filterBtnPressed(_ sender: Any) {
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension ConsultationLogVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultationLogTBCell", for: indexPath) as! ConsultationLogTBCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

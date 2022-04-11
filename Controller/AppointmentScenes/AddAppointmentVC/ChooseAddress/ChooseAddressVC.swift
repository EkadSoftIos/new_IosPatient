//
//  ChooseAddressVC.swift
//  E4 Patient
//
//  Created by Nada on 8/29/21.
//

import UIKit

class ChooseAddressVC: UIViewController {

    @IBOutlet weak var addressTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressTB.estimatedRowHeight = 44
        addressTB.rowHeight = UITableView.automaticDimension
        addressTB.delegate = self
        addressTB.dataSource = self
        addressTB.register(UINib(nibName: "AppointmentAddressCell", bundle: nil), forCellReuseIdentifier: "AppointmentAddressCell")
    }

}
extension ChooseAddressVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentAddressCell", for: indexPath) as! AppointmentAddressCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

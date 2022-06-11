//
//  PatientAttachememntsVC.swift
//  E4 Patient
//
//  Created by Nada on 10/5/21.
//

import UIKit

class PatientAttachememntsVC: UIViewController {
    
    var userData: UserDataMessage? 
    var indexPath: Int?
    
    @IBOutlet weak var userDate: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var attachementTb: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Patient attachments"
        attachementTb.delegate = self
        attachementTb.dataSource = self
        attachementTb.separatorStyle = .none
        attachementTb.register(UINib(nibName: "AttachementTBCell", bundle: nil), forCellReuseIdentifier: "AttachementTBCell")
        setData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.ShadowView(view: bgView, radius: 10, opacity: 0.4, shadowRadius: 6, color: UIColor.darkGray.cgColor)
    }
    func setData(){
          self.attachementTb.reloadData()
          userName.text = "\(userData?.patientFirstName ?? "")" + " \(userData?.patientLastName ?? "")"
          
          let image = "\(Constants.baseURLImage)\(userData?.patientProfileImage ?? "")"
          print("image: \(image)")
          userImg.kf.setImage(with: URL(string: (image)),placeholder: UIImage(named: "profile"))
          Animation.roundView(userImg)
          userId.text = "patient ID \("\(userData?.patientID ?? 0)")"
         let milisecond = userData?.createDate ?? ""
          userDate.text = "joined " + convertDateFormat(inputDate: milisecond)

      }
    func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let oldDate = olDateFormatter.date(from: inputDate) ?? Date()
         let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMMM dd yyyy"
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let newOne = newDateFormatter.date(from: "\(oldDate)") ?? Date()
        let dateString = newDateFormatter.string(from: newOne)
//        let enDateString = dateString.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.-:").inverted)

         return dateString
    }

}
extension PatientAttachememntsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData?.visitSummery?[indexPath ?? 0].bookingSummaryFiles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachementTBCell", for: indexPath) as! AttachementTBCell
        
        cell.selectionStyle = .none
        
        let image = "\(Constants.baseURLImage)\(userData?.visitSummery?[self.indexPath ?? 0].bookingSummaryFiles?[indexPath.row].bookingSummaryFilesPath ?? "")"
        print("image: \(image)")
        cell.attachImg.kf.setImage(with: URL(string: (image)),placeholder: UIImage(named: "profile"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ShowAttachementImageVC") as! ShowAttachementImageVC
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.imgPath = "\(Constants.baseURLImage)\(userData?.visitSummery?[self.indexPath ?? 0].bookingSummaryFiles?[indexPath.row].bookingSummaryFilesPath ?? "")"
        
        present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

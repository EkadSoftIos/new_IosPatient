//
//  NotificationsVC.swift
//  E4Doctor
//
//  Created by Nada on 11/27/21.
//

import UIKit

class NotificationsVC: UIViewController {

    var notListData: [NotificationListData]? {
        didSet {
            self.notificationTB.reloadData()
        }
    }
 
    @IBOutlet weak var notificationTB: UITableView!
    @IBOutlet weak var deleteAllBtn: UIButton!
    @IBOutlet weak var screenTitleLBL: UILabel!
    @IBOutlet weak var readAllBtn: UIButton!
    var image = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y:  UIScreen.main.bounds.height / 2, width: 40, height: 40))
    
//    private let moreNetwork: MoreAPIProtocol = MoreAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications"

        // Do any additional setup after loading the view.
        notificationTB.delegate = self
        notificationTB.dataSource = self
        notificationTB.estimatedRowHeight = 44
        notificationTB.rowHeight = UITableView.automaticDimension
        notificationTB.register(UINib(nibName: "NotificationsTBCell", bundle: nil), forCellReuseIdentifier: "NotificationsTBCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        readAllBtn.setTitle("ReadAll".localized, for: .normal)
        deleteAllBtn.setTitle("DeleteAll".localized, for: .normal)
        getAllNotifications()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        deleteAllBtn.layer.cornerRadius = 9
        deleteAllBtn.layer.borderColor = #colorLiteral(red: 0.06777852029, green: 0.4943161011, blue: 0.8171316981, alpha: 1)
        deleteAllBtn.layer.borderWidth = 1
        readAllBtn.layer.cornerRadius = 9
    }
    

    func getAllNotifications() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: NotificationListModel.self, router: APIRouter.notificationList) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
               
            case.success(let data):
                self.notListData = data.message
            case.failure(let err):
                print(err)
            }
        }
    }
    func MarkAllAsRead() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: SuccessModel.self, router: APIRouter.readAllNotifications) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
                
            case.success(let data):
                if data.successtate == 200 {
                    self.getAllNotifications()
                } else {
                    print(data.message ?? "")
                }
            case.failure(let err):
                print(err)
            }
        }
    }
    func DeleteAllNot() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.DeleteAllAPI()
        }))
        self.present(alert, animated: true, completion: nil)
        
        

    }
    func DeleteAllAPI(){
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: SuccessModel.self, router: APIRouter.deleteAllNotification) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
                
            case.success(let data):
                if data.successtate == 200 {
                    self.getAllNotifications()
                } else {
                    print(data.message ?? "")
                }
            case.failure(let err):
                print(err)
            }
        }
    }
    @IBAction func deleteAllMessagesBtnPressed(_ sender: Any) {
        if notListData?.count != 0 {
            DeleteAllNot()
        }
    }
    @IBAction func readAllMessagesBtnPressed(_ sender: Any) {
        if notListData?.count != 0 {
            MarkAllAsRead()
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
    }
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notListData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTBCell", for: indexPath) as! NotificationsTBCell
        
        cell.selectionStyle = .none
        tableView.separatorColor = .clear
//        cell.notifyTitle.text = notListData?[indexPath.row].notificationTitle
        cell.notifyDesc.text = notListData?[indexPath.row].notificationDetailsMessage
        cell.userNameLBL.text = notListData?[indexPath.row].fromUserName
        
        let notifyImg = notListData?[indexPath.row].fromUserImageURL ?? ""
        let imgURL = URL(string: "\(Constants.baseURLImage)\(notifyImg)")
        cell.NotifyImg?.kf.indicatorType = .activity
        cell.NotifyImg?.kf.setImage(with: imgURL)
        
        
        cell.deleteMsgBtn.tag = notListData?[indexPath.row].userNotificationID ?? 0
        cell.deleteMsgBtn.addTarget(self, action: #selector(deleteOneMessage), for: .touchUpInside)
        cell.readMsgBtn.tag = notListData?[indexPath.row].userNotificationID ?? 0
        cell.readMsgBtn.addTarget(self, action: #selector(readOneMessage), for: .touchUpInside)
        if notListData?[indexPath.row].isRead == true{
            cell.readMsgBtn.setImage(UIImage (named: "readMsg"), for: .normal)
//            cell.readMsgBtn.isHidden = true
        }else{
            cell.readMsgBtn.setImage(UIImage (named: "unreadMsg"), for: .normal)
//            cell.readMsgBtn.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    @objc func deleteOneMessage(sender: UIButton) {
        DeleteOneNot(NotId: sender.tag)
    }
    @objc func readOneMessage(sender: UIButton) {
        
        MarkOneNotAsRead(NotId: sender.tag)
    }
    
    func DeleteOneNot(NotId : Int) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.deleteOneAPI(NotId: NotId)
        }))
        self.present(alert, animated: true, completion: nil)


        
    }
    func deleteOneAPI(NotId : Int) {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: SuccessModel.self, router: APIRouter.deleteNotification(notificationId: NotId)) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
                
            case.success(let data):
                if data.successtate == 200 {
                    self.getAllNotifications()
                } else {
                    print(data.message ?? "")
                }
            case.failure(let err):
                print(err)
            }
        }
    }
    func MarkOneNotAsRead(NotId : Int) {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: SuccessModel.self, router: APIRouter.readNotification(notificationId: NotId)) {[weak self] (result) in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
                
            case.success(let data):
                if data.successtate == 200 {
                    self.getAllNotifications()
                } else {
                    print(data.message ?? "")
                }
            case.failure(let err):
                print(err)
            }
        }
    }

}

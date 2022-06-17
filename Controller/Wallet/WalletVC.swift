//
//  WalletVC.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 03/06/2022.
//

import UIKit

class WalletVC: UIViewController {

    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var rechargeBtn: UIButton!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var currentBalanceLbl: UILabel!
    @IBOutlet weak var receivedBalanceLbl: UILabel!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var walletColl: UICollectionView!
    @IBOutlet weak var collBGView: UIView!
    @IBOutlet weak var collViewHeightConst: NSLayoutConstraint!
    
    private(set) var currentTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private(set) var segmentedIndex = 0
    var walletListData: [WalletTransactionData]? {
        didSet {
            walletColl.reloadData()
        }
    }
    var receivedListData: [WalletTransactionData] = []
    var usedListData: [WalletTransactionData] = []
    
    var walletSummary: WalletData? {
        didSet {
            currentBalanceLbl.text = "\(walletSummary?.totalCurrentBalance ?? 0.0) EGP"
            receivedBalanceLbl.text = "\(walletSummary?.totalIncome ?? 0.0) EGP"
            availableBalanceLbl.text = "\(walletSummary?.totalAvaliableBalance ?? 0.0) EGP"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Wallet".localized
        rechargeBtn.layer.cornerRadius = 13
        goBtn.layer.cornerRadius = 13
        balanceView.ShadowView(view: balanceView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        dateView.ShadowView(view: dateView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        fromView.ShadowView(view: fromView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        toView.ShadowView(view: toView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        collBGView.ShadowView(view: collBGView, radius: 10, opacity: 0.4, shadowRadius: 2, color: UIColor.lightGray.cgColor)
        
        walletColl.delegate = self
        walletColl.dataSource = self
        walletColl.register(UINib(nibName: "WalletCell", bundle: nil), forCellWithReuseIdentifier: "WalletCell")
        
        getWalletBalance()
        self.getWalletTransactions(fromDate: "", toDate: "")
        delegateTF()
        showDatePicker()
        let firstDay = Date().startOfMonth()
        let lastDay = Date().endOfMonth()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-d"
        fromTF.text = format.string(from: firstDay)
        toTF.text = format.string(from: lastDay)
        
    }
    
    fileprivate func delegateTF(){
        fromTF.delegate = self
        toTF.delegate = self
    }
    
    func getWalletBalance() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: WalletModel.self, router: .walletballence) {[weak self] result in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
            case.success(let data):
                self.walletSummary = data.message
            case.failure(let err):
                print(err)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    
    func getWalletTransactions(fromDate: String, toDate: String) {
        showUniversalLoadingView(true)
        let para: [String: Any] =
        [
           "datefrom": fromDate,
           "dateto": toDate
        ]
        NetworkClient.performRequest(_type: WalletTransactionModel.self, router: .walletTransaction(params: para)) {[weak self] result in
            guard let self = self else {return}
            showUniversalLoadingView(false)
            switch result {
            case.success(let data):
                print(data)
                if data.successtate == 200 {
                    self.walletListData = data.message
                    self.receivedListData = []
                    self.usedListData = []
                    if (data.message?.count ?? 0) > 0 {
                        for data in data.message ?? [] {
                            if data.factor == 1 {
                                self.receivedListData.append(data)
                            } else if data.factor == -1 {
                                self.usedListData.append(data)
                            }
                        }
                        self.noDataLbl.isHidden = true
                    } else {
                        self.noDataLbl.isHidden = false
                    }
                } else {
                    print(data.message ?? "")
                }
            case.failure(let err):
                print(err)
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
            }
        }
    }
    
    @IBAction func didTappedRechargeBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreditCardVC") as! CreditCardVC
        
        vc.patientId = walletSummary?.patientID ?? 0
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTappedGoBtn(_ sender: Any) {
        guard fromTF.text != "" else {return}
        guard toTF.text != "" else {return}
        
        getWalletTransactions(fromDate: fromTF.text!, toDate: toTF.text!)
    }
    
    @IBAction func didTappedSegmentcontrol(_ sender: UISegmentedControl) {
        segmentedIndex = sender.selectedSegmentIndex
        walletColl.reloadData()
    }
    
}

extension WalletVC: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedIndex == 0 {
            let count = walletListData?.count ?? 0
            collViewHeightConst.constant = CGFloat((count * 100) + 100)
            return count
        } else if segmentedIndex == 1 {
            let count = receivedListData.count
            collViewHeightConst.constant = CGFloat((count * 100) + 100)
            return count
        } else {
            let count = usedListData.count
            collViewHeightConst.constant = CGFloat((count * 100) + 100)
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath)as! WalletCell
        
        var data: [WalletTransactionData] = []
        if segmentedIndex == 0 {
            data = walletListData ?? []
        } else if segmentedIndex == 1 {
            data = receivedListData
        } else {
            data = usedListData
        }
        
        cell.serviceName.text = data[indexPath.item].consultationServiceNameLocalized ?? ""
        cell.doctorName.text = data[indexPath.row].doctorName ?? ""
        cell.dateLbl.text = data[indexPath.item].transactionDate?.changeDateFormatString(dateFormatFrom: ConstantsStrings.dateFormatYMDTHMS, dateFormatTo: ConstantsStrings.dateFormatDayNameDMY) ?? ""
        cell.walletLbl.text = "\(data[indexPath.item].amount ?? 0)EGP"
        
        if data[indexPath.item].factor == 1 {
            cell.expenseImg.image = UIImage(named: "Expense")
        } else {
            cell.expenseImg.image = UIImage(named: "ic_next-1")
        }
        
        let serviceFk = data[indexPath.item].consultationServiceFk
        switch serviceFk {
        case 1:
            cell.serviceImg.image = UIImage(named: "ic_clinic")
        case 2:
            cell.serviceImg.image = UIImage(named: "ic_video call")
        case 3:
            cell.serviceImg.image = UIImage(named: "ic_home visit")
        default:
            cell.serviceImg.image = UIImage(named: "ic_video call immediate-1")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }
    
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

//MARK: - TextField as a Data Picker view

extension WalletVC : UITextFieldDelegate{
    
    fileprivate func showDatePicker(){
         datePicker.datePickerMode = .date
//         if #available(iOS 13.4, *) {
//             datePicker.preferredDatePickerStyle = .wheels
//         }
         //ToolBar
         toolbar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(done));
         let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(cancel));
         
         toolbar.setItems([doneButton ,spaceButton ,cancelButton], animated: false)
     }
    
    @objc func done(){
       switch currentTextField {
       case fromTF:
        fromTF.text = datePicker.date.convertDateToString(dateFormat: ConstantsStrings.dateFormatYYY_MM_DD)
        toTF.isEnabled = true
        datePicker.minimumDate = datePicker.date
       case toTF :
        toTF.text = datePicker.date.convertDateToString(dateFormat: ConstantsStrings.dateFormatYYY_MM_DD)
       default:
           break
       }
        view.endEditing(true)
    }
      
    @objc func cancel(){
       switch currentTextField {
       case fromTF:
           toTF.text = ""
        toTF.text = ""
        toTF.isEnabled = false
        datePicker.minimumDate = nil
       case toTF :
           toTF.text = ""
       default:
           break
       }
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        currentTextField.inputAccessoryView = toolbar
        currentTextField.inputView = datePicker
        
    }
    
    
}


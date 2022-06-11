//
//  OrdersFilterVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/9/22.
//
//

import PKHUD
import UIKit
import iOSDropDown
import SwiftMessages


enum ExpandedType:Int {
    case date = 1
    case msOP
}

//MARK: View -
protocol OrdersFilterViewProtocol: AnyObject {
    var toDateText:String? { get set }
    var fromDateText:String? { get set }
    var presenter: OrdersFilterPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func reloadDropDown(optionArray:[String], optionIds:[Int])
    func showMessageAlert(title: String, message: String)
}

class OrdersFilterVC: UIViewController {

    // MARK: - Public properties -
    
    @IBOutlet var bodysView: [UIView]!
    @IBOutlet weak var msLabel: UILabel!
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var dateFooterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var bottomShadowsViews: [UIView]!
    @IBOutlet var bodySubViewsViewsList: [UIView]!
    @IBOutlet var dropdownImgViewList: [UIImageView]!
    var presenter: OrdersFilterPresenterProtocol!
    
    
    
    var handler:((OrdersFilter) -> Void)?
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OrdersFilter", bundle: nil)
        presenter = OrdersFilterPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        presenter.viewDidLoad()
    }
    
    func setupLayoutUI() {
        HUD.show(.progress)
        title = "Filter".localized
        dateFooterView.isHidden = true
        msLabel.text = presenter.type.opsDashboardTitle
        shadowsViews.forEach({ $0.applyShadow(0.2) })
        bottomShadowsViews.forEach({
            $0.applyShadow(0.15, shadowRadius: 2, shadowOffset: CGSize(width: -1, height: 2))
        })
        setupExpendedView(.date)
        setupExpendedView(.msOP)
        dropDown.isSearchEnable = false
        dropDown.arrowColor = .selectedPCColor ?? .black
        dropDown.placeholder = presenter.type.dropDownPlaceholder
        dropDown.font = UIFont.font(style: .regular, size: 14)
        dropDown.selectedRowColor = .selectedPCColor ?? .blue
        dropDown.didSelect { [weak self] (selectedText, index, id) in
            guard let self = self else { return }
            self.presenter.didSelectRow(at: index, with: id)
        }
        tableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func fromDateBtnTapped(_ sender: Any) {
        let datePickerDialog = DatePickerDialog(textColor: .darkGray, buttonColor: .black, font: .font(style: .regular, size: 14))
        let code = Languagee.language.code
        datePickerDialog.locale = Locale(identifier: code)
        datePickerDialog.show("Date Picker".localized,
                              doneButtonTitle: "Done".localized,
                              cancelButtonTitle: "Cancel".localized,
                              minimumDate: presenter.toDate == nil ? presenter.toDate:nil,
                              maximumDate: presenter.toDate ?? Date(),
                              datePickerMode: UIDatePicker.Mode.date,
                              window: view.window)
        { [weak self] (date) -> Void in
            guard let self = self else { return }
            if let dt = date {
                self.presenter.fromDate = dt
            }
        }
    }
    
    @IBAction func toDateBtnTapped(_ sender: Any) {
        let datePickerDialog = DatePickerDialog(textColor: .darkGray, buttonColor: .black, font: .font(style: .regular, size: 14))
        let code = Languagee.language.code
        datePickerDialog.locale = Locale(identifier: code)
        datePickerDialog.show("Date Picker".localized,
                              doneButtonTitle: "Done".localized,
                              cancelButtonTitle: "Cancel".localized,
                              minimumDate: presenter.fromDate,
                              maximumDate: Date(),
                              datePickerMode: UIDatePicker.Mode.date,
                              window: view.window)
        { [weak self] (date) -> Void in
            guard let self = self else { return }
            if let dt = date {
                self.presenter.toDate = dt
            }
        }
    }
    
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        if !presenter.canSearch{ return }
        handler?(presenter.filter)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        tableView.reloadData()
        dateFooterView.isHidden = true
        dropDown.selectedIndex = -1
    }
    
    @IBAction func expandedBtnTapped(_ sender: UIButton) {
        guard let expandedType = ExpandedType(rawValue: sender.tag)
        else { return  }
        setupExpendedView( expandedType)
    }
    
    private func setupExpendedView(_ expandedType:ExpandedType){
        guard let bodyView = bodysView
                .first(where: { $0.tag == expandedType.rawValue }),
              let dropdownImgView = dropdownImgViewList
                .first(where: { $0.tag == expandedType.rawValue})
        else { return  }
        let bodySubViewsViews = bodySubViewsViewsList.filter({ $0.tag == expandedType.rawValue })
        dropdownImgView.isHighlighted = !dropdownImgView.isHighlighted
        let isExpand = dropdownImgView.isHighlighted
        
        bodySubViewsViews.forEach({ $0.alpha = isExpand ? 0.5:0 })
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard self != nil else { return }
            //rotate image
            if isExpand {
                dropdownImgView.transform = .identity
            }else{
                dropdownImgView.transform = dropdownImgView.transform.rotated(by: .pi)
            }
            bodyView.isHidden = isExpand
            bodySubViewsViews.forEach({ $0.alpha = isExpand ? 0:1 })
        }
    }
}

// MARK: - Extensions -
extension OrdersFilterVC: OrdersFilterViewProtocol {
    
    var toDateText:String? {
        get{ toDateLabel.text  }
        set{ toDateLabel.text = newValue  }
    }
    
    var fromDateText:String? {
        get{ fromDateLabel.text }
        set{ fromDateLabel.text = newValue  }
    }
    
    func reloadDropDown(optionArray:[String], optionIds:[Int]){
        if HUD.isVisible { HUD.flash(.success) }
        dropDown.optionArray = optionArray
        dropDown.optionIds = optionIds
    }
    
    func showMessageAlert(title: String, message: String) {
        if HUD.isVisible { HUD.flash(.error) }
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
}

extension OrdersFilterVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        presenter.didSelectRow(at: indexPath)
        dateFooterView.isHidden = indexPath.row != 2
    }
    
}

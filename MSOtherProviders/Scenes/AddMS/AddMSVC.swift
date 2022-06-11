//
//  AddMSVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/6/22.
//
//

import UIKit
import PKHUD
import iOSDropDown
import KafkaRefresh
import SwiftMessages

//MARK: View -
protocol AddMSViewProtocol: AnyObject {
    var presenter: AddMSPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */

    func reloadData()
    func showMessageAlert(title:String, message:String)
    func reloadDropDown(optionArray:[String])
}

class AddMSVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet var bottomShadowsViews: [UIView]!
    @IBOutlet weak var msSearchLabel: UILabel!
    @IBOutlet weak var chooseMSLabel: UILabel!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var presenter: AddMSPresenterProtocol!
    
    var handler:(([Service]) -> Void)?
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "AddMS", bundle: nil)
        presenter = AddMSPresenter(view: self)
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
        title = presenter.type.addMSTitle
        shadowsViews.forEach({ $0.applyShadow(0.3) })
        bottomShadowsViews.forEach({
            $0.applyShadow(0.15, shadowRadius: 2, shadowOffset: CGSize(width: -1, height: 2))
        })
        addBtn.setTitle(presenter.type.addMSTitle, for: .normal)
        searchTextField.placeholder = presenter.type.msSearchPlaceholder
        searchTextField.delegate = self
        msSearchLabel.text = presenter.type.msSearchText
        chooseMSLabel.text = presenter.type.chooseMSText
        categoryDropDown.arrowColor = .selectedPCColor ?? .black
        categoryDropDown.placeholder = presenter.type.dropDownPlaceholder
        categoryDropDown.font = UIFont.font(style: .regular, size: 14)
        categoryDropDown.selectedRowColor = .selectedPCColor ?? .blue
//        categoryDropDown.didSelect { [weak self] (selectedText, index, id) in
//            guard let self = self else { return }
//            print("categoryDropDown.didSelect:\(selectedText), \(index), \(id)")
//        }
        tableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
        tableView.bindFootRefreshHandler({ [weak self] in
            guard let self = self else { return }
            self.presenter.loadMore()
        }, themeColor: .selectedPCColor, refreshStyle: .native)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        let searchText = showSearchResultVC()
        let selectedIndex = categoryDropDown.selectedIndex
        presenter.fetchSearchedData(text: searchText, selectedIndex: selectedIndex)
    }
    
    func showSearchResultVC() -> String? {
        view.endEditing(true)
        guard let text = searchTextField.text, !text.isBlank
        else { return nil }
        return text
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func addMSBtnTapped(_ sender: Any) {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows,
             !selectedIndexPaths.isEmpty else {
                 showMessageAlert(title: .error, message: .chooseMS)
            return
        }
        print(selectedIndexPaths)
        handler?(presenter.services(for: selectedIndexPaths))
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions -
// MARK: - UITextFieldDelegate Extension -
extension AddMSVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let searchText = showSearchResultVC()
        presenter.fetchSearchedData(text: searchText)
        return false
    }
    
}

extension AddMSVC: AddMSViewProtocol {
    
    func reloadData(){
        stopLoading()
        if HUD.isVisible { HUD.flash(.success) }
        tableView.reloadData()
    }
    
    func reloadDropDown(optionArray:[String]){
        categoryDropDown.optionArray = optionArray
    }
    
    func showMessageAlert(title: String, message: String) {
        stopLoading()
        if HUD.isVisible { HUD.flash(.error) }
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    private func stopLoading(){
        
        tableView.endRefreshing(presenter.canFetchMore)
    }
    
}

extension AddMSVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

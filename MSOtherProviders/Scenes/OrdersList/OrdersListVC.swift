//
//  OrdersListVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//
//

import UIKit
import PKHUD
import KafkaRefresh
import SwiftMessages

//MARK: View -
protocol OrdersListViewProtocol: AnyObject {
    var presenter: OrdersListPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func reloadData()
    func showMessageAlert(title: String, message: String)
}

class OrdersListVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var presenter: OrdersListPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OrdersList", bundle: nil)
        presenter = OrdersListPresenter(view: self)
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
        title = presenter.type.ordersListTitle
        searchTextField.delegate = self
        shadowsViews.forEach ({ $0.applyShadow(0.3) })
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        tableView.bindFootRefreshHandler({ [weak self] in
            guard let self = self else { return }
            self.presenter.loadMore()
        }, themeColor: .selectedPCColor, refreshStyle: .native)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func filterBtnTapped(_ sender: Any) {

    }

}

// MARK: - Extensions -
// MARK: - UITextFieldDelegate Extension -
extension OrdersListVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = searchTextField.text?.trimmingCharacters(in: .whitespaces),
            !text.isEmpty
        else { return false }
        //presenter.showSearchResultVC(searchText: text)
        return false
    }
    
}
extension OrdersListVC: OrdersListViewProtocol {
    
    func reloadData(){
        stopLoading()
        HUD.flash(.success)
        tableView.reloadData()
    }
    
    func showMessageAlert(title: String, message: String) {
        stopLoading()
        HUD.flash(.error)
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    private func stopLoading(){
        tableView.endRefreshing(presenter.canFetchMore)
    }
}

extension OrdersListVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30 //presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        //presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

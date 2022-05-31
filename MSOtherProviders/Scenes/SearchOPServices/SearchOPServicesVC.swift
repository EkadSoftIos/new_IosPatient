//
//  SearchOPServicesVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/29/22.
//
//

import UIKit
import KafkaRefresh
import SwiftMessages

//MARK: View -
protocol SearchOPServicesViewProtocol: AnyObject {
    var presenter: SearchOPServicesPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func reloadData()
    func setSearchText(_ text:String)
    func showMessageAlert(title:String, message:String)
}

class SearchOPServicesVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findServicesBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    var presenter: SearchOPServicesPresenterProtocol!
    
    
    var msRequest:MSOPServicesRequest {
        get{ presenter.msRequest }
        set{ presenter.msRequest = newValue }
    }
    
    // MARK: - Private properties -
    
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "SearchOPServices", bundle: nil)
        presenter = SearchOPServicesPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewDidLoad()
    }

    func setupLayout() {
        title = presenter.title
        showUniversalLoadingView(true)
        searchTextField.delegate = self
        shadowsViews.forEach ({ $0.applyShadow(0.3) })
        searchTextField.placeholder = presenter.searchPlaceholder
        findServicesBtn.setTitle( presenter.findServicesBtnTitle, for: .normal)
        tableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
        tableView.bindFootRefreshHandler({ [weak self] in
            guard let self = self else { return }
            self.presenter.loadMore()
        }, themeColor: .selectedPCColor, refreshStyle: .native)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func findServicesBtnTapped(_ sender: Any) {
        guard let opTypeFk = presenter.msRequest.opTypeFk else {
            showMessageAlert(title: "Error".localized, message: "")
            return
        }
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows,
             !selectedIndexPaths.isEmpty else {
            showMessageAlert(title: "Error".localized, message: "Please choose at least one".localized)
            return
        }
        let vc = OtherProvidersListVC()
        vc.type = opTypeFk
        vc.request = .services(presenter.services(for: selectedIndexPaths))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        tableView.reloadData()
    }

    @IBAction func searchBtnTapped(_ sender: Any) {
        showSearchResultVC()
    }
    
    func showSearchResultVC(){
        view.endEditing(true)
        guard let text = searchTextField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return  }
        presenter.fetchSearchedData(text: text)
    }
    
}

// MARK: - Extensions -
// MARK: - UITextFieldDelegate Extension -
extension SearchOPServicesVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showSearchResultVC()
        return false
    }
    
}

// MARK: - SearchOPServicesViewProtocol Extension -
extension SearchOPServicesVC: SearchOPServicesViewProtocol {
    
    func reloadData(){
        tableView.reloadData()
        stopLoading()
    }
    
    func setSearchText(_ text: String) {
        searchTextField.text = text
    }
    
    func showMessageAlert(title: String, message: String) {
        stopLoading()
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    private func stopLoading(){
        showUniversalLoadingView(false)
        tableView.endRefreshing(presenter.canFetchMore)
    }
    
}

extension SearchOPServicesVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

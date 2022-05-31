//
//  EPrescriptionListVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//
//

import UIKit
import KafkaRefresh
import SwiftMessages



//MARK: View -
protocol EPrescriptionListViewProtocol: AnyObject {
    var presenter: EPrescriptionListPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func reloadData()
    func showMessageAlert(title:String, message:String)
    func showOtherProvidersList(request:RequestType)
}

class EPrescriptionListVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var tableView: UITableView!
    var presenter: EPrescriptionListPresenterProtocol!
    
    var type:MSType{
        get{ presenter.type }
        set{ presenter.type = newValue }
    }
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "EPrescriptionList", bundle: nil)
        presenter = EPrescriptionListPresenter(view: self)
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
        title = "E-Prescriptions".localized
        showUniversalLoadingView(true)
        tableView.bindFootRefreshHandler({ [weak self] in
            guard let self = self else { return }
            self.presenter.loadMore()
        }, themeColor: .selectedPCColor, refreshStyle: .native)
        tableView.register(UINib(nibName: "EPrescriptionCell", bundle: nil), forCellReuseIdentifier: "EPrescriptionCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - Extensions -
// MARK: - EPrescriptionListViewProtocol -
extension EPrescriptionListVC: EPrescriptionListViewProtocol {

    func reloadData(){
        tableView.reloadData()
        stopLoading()
    }
    
    func showMessageAlert(title: String, message: String) {
        stopLoading()
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    private func stopLoading(){
        showUniversalLoadingView(false)
        tableView.endRefreshing(presenter.canFetchMore)
    }
    
    func showOtherProvidersList(request:RequestType){
        let vc = OtherProvidersListVC()
        vc.type = presenter.type
        vc.request = request
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: -  UITableViewDelegate, UITableViewDataSource -
extension EPrescriptionListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = presenter.numberOfEPrescriptions
        if numberOfRows == 0 { tableView.setEmptyMessage() }
        else { tableView.hiddenEmptyMessage() }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EPrescriptionCell", for: indexPath) as! EPrescriptionCell
        
        presenter.configEPrescriptionCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

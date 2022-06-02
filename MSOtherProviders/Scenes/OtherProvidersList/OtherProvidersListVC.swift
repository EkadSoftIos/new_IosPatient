//
//  OtherProvidersListVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//
//

import UIKit
import Kingfisher
import KafkaRefresh
import SwiftMessages

typealias Image = UIImage

//MARK: View -
protocol OtherProvidersListViewProtocol: AnyObject {
    var userLocation:String { get set }
    var searchResultText:String { get set }
    var presenter: OtherProvidersListPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */

    func reloadData()
    func showLoading()
    func setEP(display: EPrescriptionDisplay)
    func showMessageAlert(title:String, message:String)
}

class OtherProvidersListVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var epDateLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var docAvatarImgView: UIImageView!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    var presenter: OtherProvidersListPresenterProtocol!
    
    var type:MSType{
        get{ presenter.type }
        set{ presenter.type = newValue }
    }
    
    var request:RequestType?{
        get{ presenter.request }
        set{ presenter.request = newValue }
    }
    
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OtherProvidersList", bundle: nil)
        presenter = OtherProvidersListPresenter(view: self)
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
        title = presenter.title
        doctorView.isHidden = true
        showUniversalLoadingView(true)
        shadowsViews.forEach ({ $0.applyShadow(0.2) })
        tableView.bindFootRefreshHandler({ [weak self] in
            guard let self = self else { return }
            self.presenter.loadMore()
        }, themeColor: .selectedPCColor, refreshStyle: .native)
        tableView.register(UINib(nibName: "OtherProviderCell", bundle: nil), forCellReuseIdentifier: "OtherProviderCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func filterCityBtnTapped(_ sender: UIButton) {
        let alert = FilterAlertVC()
        alert.hander = { [weak self] sort in
            guard let self = self else { return }
            showUniversalLoadingView(true)
            self.presenter.sortList(accordingTo: sort)
        }
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
    
    @IBAction func chooseCityBtnTapped(_ sender: UIButton) {
        let vc = AULocationVC()
        vc.type = .countries
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func nearByBtnTapped(_ sender: UIButton) {
        
    }
}

// MARK: - Extensions -
// MARK: - OtherProvidersListViewProtocol -
extension OtherProvidersListVC: OtherProvidersListViewProtocol {
    
    var userLocation: String{
        get { userLocationLabel.text ?? "" }
        set { userLocationLabel.text = newValue }
    }
    
    var searchResultText: String {
        get { searchResultLabel.text ?? "" }
        set { searchResultLabel.text = newValue }
    }
    
    
    func reloadData(){
        tableView.reloadData()
        stopLoading()
    }
    
    func showMessageAlert(title: String, message: String) {
        stopLoading()
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    func setEP(display: EPrescriptionDisplay) {
        doctorView.isHidden = false
        doctorView.applyShadow(0.3)
        doctorNameLabel.text = display.name
        epDateLabel.text = display.date
        docAvatarImgView.kf.indicatorType = .activity
        docAvatarImgView.kf.setImage(with: display.imageURL, placeholder: UIImage(named: "ProfileImage"))
    }
    
    func showLoading(){
        showUniversalLoadingView(true)
        tableView.footRefreshControl.resumeRefreshAvailable()
    }
    
    private func stopLoading(){
        showUniversalLoadingView(false)
        tableView.endRefreshing(presenter.canFetchMore)
    }
    
}

// MARK: -  UITableViewDelegate, UITableViewDataSource -
extension OtherProvidersListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = presenter.numberOfRows
        if numberOfRows == 0 { tableView.setEmptyMessage() }
        else { tableView.hiddenEmptyMessage() }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherProviderCell", for: indexPath) as! OtherProviderCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
}

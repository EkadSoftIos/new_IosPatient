//
//  AULocationVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/2/22.
//
//

import UIKit
import APESuperHUD
import SwiftMessages
import SKCountryPicker

//MARK: View -
protocol AULocationViewProtocol: AnyObject {
    var navTitle:String? { get set }
    var presenter: AULocationPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func showAppSetting()
    func reloadData()
    func showListVC(type:AULocationType)
    func popToOPListVC(location:Location)
    func popToOPListVC(country:ULCountry, city:City, area:Area)
    func showMessageAlert(title:String, message:String)
}

class AULocationVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowViews: [UIView]!
    @IBOutlet weak var tableView: UITableView!
    var presenter: AULocationPresenterProtocol!
    
    var type: AULocationType{
        get{ presenter.type }
        set{ presenter.type = newValue }
    }
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "AULocation", bundle: nil)
        presenter = AULocationPresenter(view: self)
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
        APESuperHUD.show(style: .loadingIndicator(type: .standard), message: .loading)
        shadowViews.forEach({ $0.applyShadow(0.15) })
        tableView.register(UINib(nibName: "AULocationCell", bundle: nil), forCellReuseIdentifier: "AULocationCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func autoLocationBtnTapped(_ sender: UIButton) {
        print("AU: autoLocationBtnTapped")
        presenter.autoLocation()
    }
}

// MARK: - Extensions -
extension AULocationVC: AULocationViewProtocol {
    
    var navTitle:String? {
        get{ title }
        set{ title = newValue }
    }
    
    func reloadData(){
        APESuperHUD.dismissAll(animated: true)
        tableView.reloadData()
    }
    
    func showAppSetting() {
        openAppSettings()
    }
    
    func showMessageAlert(title: String, message: String) {
        APESuperHUD.dismissAll(animated: true)
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    func showListVC(type:AULocationType){
        let vc = AULocationVC()
        vc.type = type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToOPListVC(location:Location) {
        guard let opListVC = getRootVC() else { return }
        opListVC.presenter.userLocation(location: location)
        navigationController?.popToViewController(opListVC, animated: true)
    }
    
    func popToOPListVC(country:ULCountry, city:City, area:Area) {
        guard let opListVC = getRootVC() else { return }
        opListVC.presenter.userLocation(
            country: country,
            city: city,
            area: area
        )
        navigationController?.popToViewController(opListVC, animated: true)
    }
    
    private func getRootVC() -> OtherProvidersListVC? {
        for vc in self.navigationController!.viewControllers as Array {
            if vc.isKind(of: OtherProvidersListVC.self),
               let opListVC = vc as? OtherProvidersListVC {
                return opListVC
            }
        }// end Loop
        return nil
    }//end func
}

extension AULocationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = .init(scaleX: 0, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.transform = .identity
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AULocationCell", for: indexPath) as! AULocationCell
        presenter.config(cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
}

//
//  FilterAlertVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//
//

import UIKit
import SwiftMessages

//MARK: View -
protocol FilterAlertViewProtocol: AnyObject {
    var presenter: FilterAlertPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func showMessageAlert(title: String, message: String)
}

class FilterAlertVC: UIViewController {

    // MARK: - Public properties -
    var hander:((SortType)-> Void)?
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var dailogView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: FilterAlertPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "FilterAlert", bundle: nil)
        presenter = FilterAlertPresenter(view: self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dailogView.alpha = 0
        dailogView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.makeFadeInAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        makeFadeOutAnimation()
    }
    
    func makeFadeInAnimation(){
        UIView.animate(withDuration: 0.4){ [weak self] in
            guard let self = self else { return }
            self.dailogView.alpha = 1
            self.dailogView.transform = CGAffineTransform.identity
        }
    }

    func makeFadeOutAnimation(){
        UIView.animate(withDuration: 0.4){ [weak self] in
            guard let self = self else { return }
            self.dailogView.alpha = 0
            self.dailogView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }
    }
    
    func setupLayoutUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent( 0.6)
        shadowsViews.forEach({ $0.applyShadow(0.2)})
        tableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        guard let selectedIndexPath = tableView.indexPathsForSelectedRows?.first else {
            showMessageAlert(title: .error, message: "Please select filter".localized)
            return
        }
        hander?(presenter.selectedSort(at: selectedIndexPath))
        dismiss(animated: true)
    }
    
    @IBAction func dissmisPage(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// MARK: - Extensions -
extension FilterAlertVC: FilterAlertViewProtocol {
    
    func showMessageAlert(title: String, message: String) {
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
}

// MARK: -  UITableViewDelegate, UITableViewDataSource -
extension FilterAlertVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }
}

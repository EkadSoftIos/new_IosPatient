//
//  BookedMSVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//
//

import UIKit
import SwiftMessages

//MARK: View -
protocol BookedMSViewProtocol: AnyObject {
    var presenter: BookedMSPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */

    func updateView(qrcode:Image, barcode:Image, doctorName:String?)
    func showMessageAlert(title: String, message: String)
}

class BookedMSVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var qrcodeImageView: UIImageView!
    var presenter: BookedMSPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "BookedMS", bundle: nil)
        presenter = BookedMSPresenter(view: self)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupLayoutUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func myOrdersBtnTapped(_ sender: Any) {
        guard let vc = navigationController?.getRootVC(vc: OPsDashboardVC.self) as? OPsDashboardVC
        else { return  }
        //showOrdersList
        vc.showOrdersList(delay: 0.0)
        navigationController?.popTo(vc: vc)
    }
    
    @IBAction func backToHomeBtnTapped(_ sender: Any) {
        navigationController?.popTo(vc: OPsDashboardVC.self)
    }
    

}

// MARK: - Extensions -
extension BookedMSVC: BookedMSViewProtocol {
    
    func updateView(qrcode:Image, barcode:Image, doctorName:String?) {
        doctorLabel.text = doctorName
        qrcodeImageView.image = qrcode
        barcodeImageView.image = barcode
    }
    
    func showMessageAlert(title: String, message: String) {
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
}

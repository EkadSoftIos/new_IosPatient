//
//  OPProfileVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//
//

import UIKit
import Kingfisher
import SwiftMessages

//MARK: View -
protocol OPProfileViewProtocol: AnyObject {
    var presenter: OPProfilePresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func setBranchDetails(display:OPBranchDetailsDispaly)
    func showMessageAlert(title: String, message: String)
}

class OPProfileVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var roundedViews: [UIView]!
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var msSummaryView: UIView!
    @IBOutlet weak var msSummaryLabel: UILabel!
    @IBOutlet weak var msStackView: UIStackView!
    @IBOutlet weak var addBtnMSStackView: UIStackView!
    @IBOutlet weak var epPhotosView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var msPreRquestTitleLabel: UILabel!
    @IBOutlet weak var msPreRequestLabel: UILabel!
    @IBOutlet weak var msPreRequestView: UIView!
    
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var branchAddressLabel: UILabel!

    @IBOutlet weak var msLabel: UILabel!
    @IBOutlet weak var msImageView: UIImageView!
    var presenter: OPProfilePresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OPProfile", bundle: nil)
        presenter = OPProfilePresenter(view: self)
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
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
        roundedViews.forEach({ $0.roundCorners([.topLeft, .topRight], radius: 10) })
    }
    
    func setupLayoutUI() {
        title = presenter.type.opProfileTitle
        shadowsViews.forEach({ $0.applyShadow(0.3)})
        msImageView.image = UIImage(named: presenter.type.msImageNamed)
        addBtnMSStackView.isHidden = presenter.canAddMS
        epPhotosView.isHidden = presenter.canAddMS
        msSummaryLabel.text = presenter.type.msSummary
        msPreRquestTitleLabel.text = presenter.type.msPreRequest
        msLabel.text = presenter.type.msOPsDashboardBtnTitle
        msPreRequestView.isHidden = true
    }
    
    @IBAction func bookingBtnTapped(_ sender: Any) {
        
    }
    
}

// MARK: - Extensions -
extension OPProfileVC: OPProfileViewProtocol {
    
    func setBranchDetails(display:OPBranchDetailsDispaly) {
        providerNameLabel.text = display.providerName
        branchNameLabel.text = display.branchName
        branchAddressLabel.text = display.branchAddress
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
        if let msPreRequest = display.msPreRequest {
            msPreRequestView.isHidden = false
            msPreRequestLabel.attributedText = msPreRequest
        }else{
            msPreRequestView.isHidden = true
        }
    }
    
    func showMessageAlert(title: String, message: String) {
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
}

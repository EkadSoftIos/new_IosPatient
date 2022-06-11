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
    
    
    func reloadImages()
    func reloadMSSummary()
    func setBranchDetails(display:OPBranchDetailsDispaly)
    func showMessageAlert(title: String, message: String)
    func showBookedServices(_ order:OrderInfo, ep:EPrescription?)
}

class OPProfileVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var roundedViews: [UIView]!
    @IBOutlet var shadowsViews: [UIView]!
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
    @IBOutlet weak var msSummaryStackView: UIStackView!
    
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
        msPreRquestTitleLabel.text = presenter.type.msPreRequest
        msLabel.text = presenter.type.msOPsDashboardBtnTitle
        msPreRequestView.isHidden = true
        if !presenter.canAddMS {
            epPhotosView.removeFromSuperview()
            addBtnMSStackView.removeFromSuperview()
        }
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    @IBAction func uploadEPrescription(_ sender: UIButton) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overCurrentContext
        imagePickerController.modalTransitionStyle = .crossDissolve
        present(imagePickerController, animated: true)
    }
    
    @IBAction func addMSList(_ sender: UIButton) {
        let vc = AddMSVC()
        vc.presenter.type = presenter.type
        vc.presenter.request = presenter.msOPServicesRequest
        vc.handler = { [weak self] (msList) in
            guard let self = self else { return }
            self.presenter.addNewServices(servicesList: msList)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bookingBtnTapped(_ sender: Any) {
        presenter.bookingServices()
    }
    
}

// MARK: - Extensions -
extension OPProfileVC: OPProfileViewProtocol {
    
    func reloadImages() {
        collectionView.reloadData()
    }
    
    func setBranchDetails(display:OPBranchDetailsDispaly) {
        providerNameLabel.text = display.providerName
        branchNameLabel.text = display.branchName
        branchAddressLabel.text = display.branchAddress
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
        
        func showPreRequestAnimate(isHidden:Bool){
            UIView.animate(withDuration: 0.5) {
                self.msPreRequestView.isHidden = isHidden
            }
        }
        if let msPreRequest = display.msPreRequest {
            showPreRequestAnimate(isHidden: false)
            msPreRequestLabel.attributedText = msPreRequest
        }else{
            showPreRequestAnimate(isHidden: true)
        }
    }
    
    func showMessageAlert(title: String, message: String) {
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    func reloadMSSummary(){
        msSummaryStackView.removeAllArrangedSubviews()
        if presenter.numberOfSummaryItems <= 0 {
            return
        }
        for index in 0...presenter.numberOfSummaryItems - 1{
            let msView = MSView.instance
            presenter.config(msView: msView, index: index)
            msSummaryStackView.addArrangedSubview(msView)
        }
        UIView.animate(withDuration: 0.5) {
            self.msSummaryStackView.isHidden = false
        }
    }
    
    func showBookedServices(_ order:OrderInfo, ep:EPrescription?){
        let vc = BookedMSVC()
        vc.presenter.order = order
        vc.presenter.eprescription = ep
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource -
extension OPProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfImagesItems = presenter.numberOfImagesItems
        UIView.animate(withDuration: 0.5) {
            if numberOfImagesItems == 0 {
                self.epPhotosView.isHidden = true
            }else{
                self.epPhotosView.isHidden = false
            }
        }
        return numberOfImagesItems
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height
        let width = height * 3/4
        return CGSize(width: width, height: height)
    }
    
    
}

// MARK: - ImagePickerDelegate -
extension OPProfileVC: ImagePickerDelegate{
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if images.isEmpty { return }
        presenter.add(images: images)
        imagePicker.dismiss(animated: true)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    
}

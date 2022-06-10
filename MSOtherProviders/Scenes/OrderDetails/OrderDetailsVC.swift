//
//  OrderDetailsVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/10/22.
//
//

import UIKit
import PKHUD
import Kingfisher
import SwiftMessages

//MARK: View -
protocol OrderDetailsViewProtocol: AnyObject {
    var presenter: OrderDetailsPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func setupOrderDetails(display:OrderDetailsDisplay)
    func showMessageAlert(title: String, message: String)
}

class OrderDetailsVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var epPhotosView: UIView!
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var branchAddressLabel: UILabel!
    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var msListStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: OrderDetailsPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OrderDetails", bundle: nil)
        presenter = OrderDetailsPresenter(view: self)
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
    }
    
    func setupLayoutUI() {
        HUD.show(.progress)
        title = "Order Details".localized
        epPhotosView.isHidden = true
        msListStackView.isHidden = true
        shadowsViews.forEach({ $0.applyShadow(0.3)})
        collectionView.register(UINib(nibName: "EPImageCell", bundle: nil), forCellWithReuseIdentifier: "EPImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

// MARK: - Extensions -
extension OrderDetailsVC: OrderDetailsViewProtocol {
    
    func showMessageAlert(title: String, message: String) {
        if HUD.isVisible { HUD.flash(.error) }
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    func setupOrderDetails(display:OrderDetailsDisplay){
        HUD.flash(.success)
        qrcodeImageView.image = display.qrcode
        barcodeImageView.image = display.barcode
        branchNameLabel.text = display.branchName
        providerNameLabel.text = display.providerName
        branchAddressLabel.text = display.branchAddress
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
        func showEPPhotoAnimate(isHidden:Bool){
            UIView.animate(withDuration: 0.5) {
                self.epPhotosView.isHidden = isHidden
            }
        }
        if display.isMSListFound{
            reloadMSList()
        }else{
            msListStackView.removeFromSuperview()
        }
        if display.isEPPhotoFound{
            collectionView.reloadData()
            showEPPhotoAnimate(isHidden: false)
        }else{
            epPhotosView.removeFromSuperview()
        }
    }
    
    private func reloadMSList(){
        msListStackView.removeAllArrangedSubviews()
        if presenter.numberOfMSItems <= 0 { return }
        for index in 0...presenter.numberOfMSItems - 1{
            let msView = MSView.instance
            presenter.config(msView: msView, index: index)
            msListStackView.addArrangedSubview(msView)
        }
        UIView.animate(withDuration: 0.5) {
            self.msListStackView.isHidden = false
        }
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource -
extension OrderDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfImagesItems = presenter.numberofImages
        UIView.animate(withDuration: 0.5) {
            self.epPhotosView.isHidden = numberOfImagesItems == 0
        }
        return numberOfImagesItems
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EPImageCell", for: indexPath) as! EPImageCell
        presenter.config(cell: cell, indexPath: indexPath)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height - 20
        return CGSize(width: height, height: height)
    }
    
    
}

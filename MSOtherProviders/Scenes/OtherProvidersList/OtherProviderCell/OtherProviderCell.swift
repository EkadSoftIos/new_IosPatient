//
//  OtherProviderCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import UIKit
import Kingfisher

protocol OtherProviderCellProtocol{
    func config(display:OtherProviderDisplay, indexPath:IndexPath, presenter:OtherProviderCellPresenter)
}

protocol OtherProviderCellPresenter:AnyObject {
    func bookingOP(for indexPath:IndexPath)
}

class OtherProviderCell: UITableViewCell, OtherProviderCellProtocol {
   
    
    // MARK: - Public properties -
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var priceServicesLabel: UILabel!
    @IBOutlet weak var priceBeforeDiscountLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var conainerView: UIView!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var servicesView: UIView!
    @IBOutlet weak var servicesImgeView: UIImageView!
    @IBOutlet weak var priceView: UIView!
    
    
    // MARK: - Private properties -
    private var indexPath:IndexPath!
    private weak var presenter:OtherProviderCellPresenter?
    
    // MARK: - layoutSubviews  -
    override func layoutSubviews() {
        super.layoutSubviews()
        conainerView.applyShadow(0.3)
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
    }
    
    // MARK: - config  -
    func config(display:OtherProviderDisplay, indexPath:IndexPath, presenter:OtherProviderCellPresenter) {
        selectionStyle = .none
        self.indexPath = indexPath
        self.presenter = presenter
        providerNameLabel.text = display.providerName
        branchLabel.text = display.branchName
        servicesLabel.text = display.servicesText
        priceServicesLabel.text = display.price
        priceBeforeDiscountLabel.text = display.priceBeforeDiscount
        priceBeforeDiscountLabel.setStrikethroughStyle()
        discountLabel.text = display.discount
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
        servicesImgeView.image = UIImage(named: display.msImage)
        discountView.isHidden = display.isUploadedEP
        servicesView.isHidden = display.isUploadedEP
        priceView.isHidden = display.isUploadedEP
    }
    
    // MARK: - bookingBtnTapped  -
    @IBAction func bookingBtnTapped(_ sender: Any) {
        presenter?.bookingOP(for: indexPath)
    }
    

}


struct OtherProviderDisplay{
    
    let providerName:String
    let avatar:URL?
    let branchName:String
    let servicesText:String
    let price:String
    let discount:String
    let priceBeforeDiscount:String
    let isUploadedEP:Bool
    let msImage:String
    
    init(branch:OtherProviderBranch, servicesNum:Int, msImage:String){
        self.msImage = msImage
        self.isUploadedEP = servicesNum == 0
        providerName = branch.otherProviderNameLocalized
        branchName = branch.branchNameLocalized
        avatar = URL(string: "\(URLs.baseURLImage)\(branch.otherProviderImage)")
        servicesText = branch.avaliableCount.stringServicesValue(servicesNum)
        price =  branch.priceAfter.stringValue
        priceBeforeDiscount = branch.priceBefore.stringValue
        discount = branch.discountPercentage.stringValue
    }
}

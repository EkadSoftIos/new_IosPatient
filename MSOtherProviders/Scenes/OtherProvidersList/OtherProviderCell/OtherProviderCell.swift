//
//  OtherProviderCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import UIKit
import Kingfisher

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
        servicesText = String(format: "%d/%d %@", branch.avaliableCount, servicesNum,  "Services".localized)
        price = String(format: "%.02f\("EGP".localized)", branch.priceAfter)
        priceBeforeDiscount = String(format: "%.02f\("EGP".localized)", branch.priceBefore)
        discount = String(format: "%.01f%", branch.discountPercentage)
    }
}


protocol OtherProviderCellProtocol{
    func config(display:OtherProviderDisplay)
}

class OtherProviderCell: UITableViewCell, OtherProviderCellProtocol {
   
    
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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        conainerView.applyShadow(0.3)
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
    }
    
    func config(display: OtherProviderDisplay) {
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

}

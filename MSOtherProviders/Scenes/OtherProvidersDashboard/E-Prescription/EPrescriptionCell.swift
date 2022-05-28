//
//  EPrescriptionCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/25/22.
//

import UIKit
import MapKit

extension MSType{
    
    var btnName:String{
        switch self {
        case .labs: return "labs".localized
        case .rays: return "rays".localized
        }
    }
    
}

struct EPrescriptionDisplatCell{
    let name:String
    let date:String
    let imageURL:URL?
    let msBtnName:String
    
    init(_ ep:LastPrescription, msType:MSType){
        name = ep.doctorNameLocalized
        date = ep.preescriptionDate
        imageURL = URL(string: "\(URLs.baseURLImage)\(ep.doctorProfileImage ?? "")")
        msBtnName = msType.btnName
    }
}

protocol EPrescriptionCellProtocol{
    func config(display:EPrescriptionDisplatCell)
}

class EPrescriptionCell: UITableViewCell {

    
    @IBOutlet weak var msBtn:UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
    }
    
    @IBAction func msBtnBtnTapped(_ sender: Any) {
        
        
    }
    
}

extension EPrescriptionCell:EPrescriptionCellProtocol{
    func config(display: EPrescriptionDisplatCell) {
        shadowView.applyShadow(0.3)
        nameLabel.text = display.name
        dateLabel.text = display.date
        msBtn.setTitle(display.msBtnName, for: .normal)
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.imageURL)
    }
}

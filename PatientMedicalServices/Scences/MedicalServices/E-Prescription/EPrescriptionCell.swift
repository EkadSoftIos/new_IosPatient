//
//  EPrescriptionCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/25/22.
//

import UIKit
import MapKit

struct EPrescriptionDisplatCell{
    let name:String
    let date:String
    let imageURL:URL?
    
    init(_ ep:LastPrescription){
        name = ep.doctorNameLocalized
        date = ep.preescriptionDate
        imageURL = URL(string: "\(URLs.baseURLImage)\(ep.doctorProfileImage)")
    }
}

protocol EPrescriptionCellProtocol{
    func config(display:EPrescriptionDisplatCell)
}

class EPrescriptionCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
    }
    
    @IBAction func labsBtnTapped(_ sender: Any) {
        
        
    }
    
}

extension EPrescriptionCell:EPrescriptionCellProtocol{
    func config(display: EPrescriptionDisplatCell) {
        shadowView.applyShadow(0.3)
        nameLabel.text = display.name
        dateLabel.text = display.date
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.imageURL)
    }
}

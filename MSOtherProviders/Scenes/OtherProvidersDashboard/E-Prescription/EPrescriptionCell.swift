//
//  EPrescriptionCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/25/22.
//

import UIKit
import Kingfisher

extension MSType{
    
    var btnName:String{
        switch self {
        case .labs: return "Labs".localized
        case .rays: return "Rays".localized
        }
    }
    
}

struct EPrescriptionDisplay{
    let name:String
    let date:String
    let imageURL:URL?
    let msBtnName:String
    
    init(_ ep:EPrescription, msType:MSType){
        name = ep.doctorNameLocalized
        date = ep.preescriptionDate.dateFormated
        imageURL = URL(string: "\(URLs.baseURLImage)\(ep.doctorProfileImage ?? "")")
        msBtnName = msType.btnName
    }
}

protocol EPrescriptionCellPresenter:AnyObject{
    func showOtherProvidersList(indexPath:IndexPath)
}

protocol EPrescriptionCellProtocol{
    func config(display:EPrescriptionDisplay, indexPath:IndexPath, presenter:EPrescriptionCellPresenter)
}

class EPrescriptionCell: UITableViewCell {

    
    // MARK: - public properties -
    @IBOutlet weak var msBtn:UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Private properties -
    private var indexPath:IndexPath!
    private weak var presenter:EPrescriptionCellPresenter?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImgView.cornerRadius = avatarImgView.frame.height / 2
    }
    
    @IBAction func msBtnBtnTapped(_ sender: Any) {
        presenter?.showOtherProvidersList(indexPath: indexPath)
    }
    
}

extension EPrescriptionCell:EPrescriptionCellProtocol{
   
    func config(display: EPrescriptionDisplay, indexPath: IndexPath, presenter: EPrescriptionCellPresenter) {
        
        self.indexPath = indexPath
        self.presenter = presenter
        shadowView.applyShadow(0.3)
        nameLabel.text = display.name
        dateLabel.text = display.date
        msBtn.setTitle(display.msBtnName, for: .normal)
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: display.imageURL, placeholder: UIImage(named: "ProfileImage"))
    }
    
   
}

//
//  EPImageCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/10/22.
//

import UIKit
import Kingfisher

protocol EPImageCellProtocol {
    func config(url:URL?, with isMore:Bool)
}



class EPImageCell: UICollectionViewCell, EPImageCellProtocol {

    
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var epImageView: UIImageView!


    func config(url:URL?, with isMore:Bool){
        moreView.isHidden = !isMore
        moreLabel.text = "+ More".localized
        epImageView.kf.indicatorType = .activity
        epImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
    }
}

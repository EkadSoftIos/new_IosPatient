//
//  PhotoCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var clinicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }

}

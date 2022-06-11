//
//  MyFavoriteCell.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class MyFavoriteCell: UITableViewCell {
    @IBOutlet var favouriteView: UIView!
    @IBOutlet weak var doctorIMG: UIImageView!
    @IBOutlet weak var doctorNameLBL: UILabel!
    @IBOutlet weak var consultantInLBL: UILabel!
    @IBOutlet weak var specialLBL: UILabel!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var feesLBL: UILabel!
    @IBOutlet weak var favBTN: UIButton!
    @IBOutlet weak var rateLBL: UILabel!
    @IBOutlet var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favouriteView.ShadowView(view: favouriteView, radius: 10, opacity: 2, shadowRadius: 2, color: UIColor.lightGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
    
}

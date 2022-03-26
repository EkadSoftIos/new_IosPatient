//
//  AllSearchCell.swift
//  E4 Patient
//
//  Created by mohab on 30/04/2021.
//

import UIKit

class AllSearchCell: UITableViewCell {
    
    var doctorCanDo: [Int] = [] {
        didSet {
            for service in doctorCanDo {
                print(service)
                switch service {
                case 1:
                    can1Imagee.image = #imageLiteral(resourceName: "f1")
                case 2:
                    can2Image.image = #imageLiteral(resourceName: "ic_call")
                case 3:
                    can3Image.image = #imageLiteral(resourceName: "ic_home_visit")
                case 4:
                    can4Image.image = #imageLiteral(resourceName: "f4")
                case 5:
                    can5IImage.image = #imageLiteral(resourceName: "ic_help_call")
                default:
                    return
                }
            }
        }
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var doctorImage: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var rateLbl: UILabel!
    @IBOutlet var can1Imagee: UIImageView!
    @IBOutlet var can2Image: UIImageView!
    @IBOutlet var can3Image: UIImageView!
    @IBOutlet var can4Image: UIImageView!
    @IBOutlet var can5IImage: UIImageView!
    @IBOutlet var sponsoredLbl: UILabel!
    @IBOutlet var detailsOneLbl: UILabel!
    @IBOutlet var detailsTwoLbl: UILabel!
    @IBOutlet var detailsThreeLbl: UILabel!
    @IBOutlet weak var bookingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.ShadowView(view: mainView, radius: 10, opacity: 0.3, shadowRadius: 4, color: UIColor.darkGray.cgColor)
        bookingView.layer.cornerRadius = 11
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

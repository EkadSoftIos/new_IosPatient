//
//  AllAddressCell.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class AllAddressCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var defultAdressBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var adressLbl: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    var defultHandelr: ActionClouser?
    var deleteHandelr: ActionClouser?
    var editHandelr: ActionClouser?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.2, shadowRadius: 6, color: UIColor.darkGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAddressButtonClicked(_ sender: Any) {
        editHandelr?()
    }
    @IBAction func delete_CLick(_ sender: Any) {
        deleteHandelr?()
    }
    @IBAction func defult_Click(_ sender: Any) {
        defultHandelr?()
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}
typealias ActionClouser = ()  -> Void

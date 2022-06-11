//
//  EmergencyContactsCell.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class EmergencyContactsCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var relationLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var phonrLbl: UILabel!
    @IBOutlet var delteBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    
    var editHandelr: ActionClouser?
    var deleteHandelr: ActionClouser?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.2, shadowRadius: 6, color: UIColor.darkGray.cgColor)
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
    @IBAction func edit_Click(_ sender: Any) {
        editHandelr?()
    }
    @IBAction func delete_Click(_ sender: Any) {
        deleteHandelr?()
    }
}

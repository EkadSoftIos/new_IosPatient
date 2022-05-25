//
//  MedicationCell.swift
//  E4 Patient
//
//  Created by mohab on 19/01/2021.
//

import UIKit

class MedicationCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var medImage: UIImageView!
    @IBOutlet var detailsOneLbl: UILabel!
    @IBOutlet var repeatLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var quantityLbl: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var reminderBtn: UIButton!
    
    var deleteHandelr: ActionClouser?
    var editHandelr: ActionClouser?
    override func awakeFromNib() {
        super.awakeFromNib()
        reminderBtn.setTitle("SetReminder".localized, for: .normal)
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
    
    @IBAction func delete_CLick(_ sender: Any) {
        deleteHandelr?()
    }
    
}

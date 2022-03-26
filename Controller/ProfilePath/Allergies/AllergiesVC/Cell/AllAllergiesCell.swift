//
//  AllAllergiesCell.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//

import UIKit
import TransitionButton
class AllAllergiesCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var detailsOneLBl: UILabel!
    @IBOutlet var detailsTwoLbl: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var deleteBtn: TransitionButton!
    
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
    @IBAction func edit_CLick(_ sender: Any) {
        editHandelr?()
    }
    @IBAction func delete_CLick(_ sender: Any) {
        deleteHandelr?()
    }
    
}

//
//  ProfileCell.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var detailsoneLbl: UILabel!
    @IBOutlet var detailsTwoLbl: UILabel!
    @IBOutlet var detailsThreeLbl: UILabel!
    @IBOutlet var countLbl: UILabel!
    @IBOutlet var stackHeight: NSLayoutConstraint!
    @IBOutlet var lineView: UIView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var countView: UIView!
    var editHandelr: ActionClouser?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.ShadowView(view: cellView, radius: 10, opacity: 0.3, shadowRadius: 6, color: UIColor.darkGray.cgColor)
    }
    override func prepareForReuse() {
        detailsoneLbl.text = nil
        detailsTwoLbl.text = nil
        detailsThreeLbl.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func edit_Click(_ sender: Any) {
        editHandelr?()
    }
    static var nib : UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String {
        return String(describing: self)
    }
}

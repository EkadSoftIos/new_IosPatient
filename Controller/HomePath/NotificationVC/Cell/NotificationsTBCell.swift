//
//  NotificationsTBCell.swift
//  E4Doctor
//
//  Created by Nada on 11/27/21.
//

import UIKit

class NotificationsTBCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var readMsgBtn: UIButton!
    @IBOutlet weak var deleteMsgBtn: UIButton!
    @IBOutlet weak var notifyDesc: UILabel!
    @IBOutlet weak var notifyTitle: UILabel!
    @IBOutlet weak var userNameLBL: UILabel!

    @IBOutlet weak var NotifyImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotifyImg.layer.cornerRadius = NotifyImg.frame.width / 2
    }
    
}

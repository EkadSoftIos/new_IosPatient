//
//  WalletCell.swift
//  E4 Patient
//
//  Created by Ahmed Kassem on 04/06/2022.
//

import UIKit

class WalletCell: UICollectionViewCell {

    @IBOutlet weak var expenseImg: UIImageView!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var serviceImg: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

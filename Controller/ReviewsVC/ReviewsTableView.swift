//
//  ReviewsTableViewCe.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import Foundation
import UIKit
extension ReviewsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorReviewData?.patientReviewList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell") as! ReviewsCell
        cell.selectionStyle = .none
        cell.ShadowView(view: cell, radius: 10, opacity: 2, shadowRadius: 0.3, color: UIColor.darkGray.cgColor)
        let patientImg = doctorReviewData?.patientReviewList?[indexPath.row].patient?.personalImage ?? ""
        let imgURL = URL(string: "\(Constants.baseURLImage)\(patientImg)")
        cell.patientImg?.kf.indicatorType = .activity
        cell.patientImg?.kf.setImage(with: imgURL)
        cell.rateDate.text = doctorReviewData?.patientReviewList?[indexPath.row].createDate ?? ""
        let fName = doctorReviewData?.patientReviewList?[indexPath.row].patient?.firstName ?? ""
        let lName = doctorReviewData?.patientReviewList?[indexPath.row].patient?.lastName ?? ""
        cell.patientName.text = fName + lName
        cell.patientRate.text = "\(doctorReviewData?.patientReviewList?[indexPath.row].totalRate ?? 0.0)"
        cell.patientFeedback.text = doctorReviewData?.patientReviewList?[indexPath.row].patientNote ?? ""
        
        let doctorImg = doctorReviewData?.profileImage ?? ""
        let doctorImgURL = URL(string: "\(Constants.baseURLImage)\(doctorImg)")
        cell.patientImg?.kf.indicatorType = .activity
        cell.doctorIMG?.kf.setImage(with: doctorImgURL)
        cell.doctorNameLBL.text = doctorReviewData?.doctorName ?? ""
        cell.doctorReplyDateLBL.text = doctorReviewData?.patientReviewList?[indexPath.row].doctorReplyDate ?? ""
        cell.doctorReplyLBL.text = doctorReviewData?.patientReviewList?[indexPath.row].doctorReply ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
        return 400
    }
    
}

//
//  SortVC.swift
//  E4 Patient
//
//  Created by mohab on 03/05/2021.
//

import UIKit
import DLRadioButton

protocol SortDelegate: AnyObject {
    func sort(id: Int)
    func resetSort()
}

class SortVC: UIViewController, BaseViewProtocol {
    
    var sortType: Int?
    
    weak var sortDelegate: SortDelegate?

    @IBOutlet weak var professionalTitleBtn: DLRadioButton!
    @IBOutlet weak var priceHighToLowBtn: DLRadioButton!
    @IBOutlet weak var priceLowToHighBtn: DLRadioButton!
    @IBOutlet weak var topratedBtn: DLRadioButton!
    @IBOutlet var sortView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sortView.ShadowView(view: sortView, radius: 10, opacity: 0.3, shadowRadius: 2, color: UIColor.darkGray.cgColor)
    }
    
    @IBAction func professionalTitleBtnPressed(_ sender: Any) {
        sortType = 4
        selected(btn1: professionalTitleBtn, btn2: topratedBtn, btn3: priceLowToHighBtn, btn4: priceHighToLowBtn)
    }
    @IBAction func priceHighToLowBtnPressed(_ sender: Any) {
        sortType = 3
        selected(btn1: priceHighToLowBtn, btn2: priceLowToHighBtn, btn3: topratedBtn, btn4: professionalTitleBtn)
    }
    @IBAction func priceLowToHighBtnPressed(_ sender: Any) {
        sortType = 2
        selected(btn1: priceHighToLowBtn, btn2: priceHighToLowBtn, btn3: topratedBtn, btn4: professionalTitleBtn)
    }
    @IBAction func topRatedBtnPressed(_ sender: Any) {
        sortType = 1
        selected(btn1: topratedBtn, btn2: priceLowToHighBtn, btn3: priceHighToLowBtn, btn4: professionalTitleBtn)
    }
    func selected(btn1: UIButton, btn2: UIButton, btn3: UIButton, btn4: UIButton) {
        btn1.isSelected = true
        btn2.isSelected = false
        btn3.isSelected = false
        btn4.isSelected = false
    }
    @IBAction func dissmiss_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func search_Click(_ sender: Any) {
        if sortType == nil {
            showAlert(message: "Select sort type")
            return
        }
        self.sortDelegate?.sort(id: sortType ?? 0)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reset_Click(_ sender: Any) {
        self.sortDelegate?.resetSort()
        self.dismiss(animated: true, completion: nil)
    }
    
 

}

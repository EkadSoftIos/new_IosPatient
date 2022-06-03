//
//  HomeVC.swift
//  E4 Patient
//
//  Created by mohab on 18/01/2021.
//

import UIKit
import FSPagerView
class HomeVC: BaseViewControll,UITextFieldDelegate {
    @IBOutlet var lastVisitLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var userIMG: UIImageView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTXT: UITextField!
    @IBOutlet var sliderControl: UIPageControl!
    @IBOutlet var SpecializationsCollection: UICollectionView!
    @IBOutlet var doctorServiseCollection: UICollectionView!
    @IBOutlet var medicalServiseCollection: UICollectionView!
    @IBOutlet var topDoctorCollection: UICollectionView!
    @IBOutlet var topOffersCollection: UICollectionView!
    
    @IBOutlet weak var welcomeLBL: UILabel!
    @IBOutlet weak var howDoYouLBL: UILabel!
    @IBOutlet weak var youCanFindLBL: UILabel!
    @IBOutlet weak var lastVisitLBL: UILabel!
    @IBOutlet weak var specializationLBL: UILabel!
    @IBOutlet weak var seeallSpecBTN: UIButton!
    @IBOutlet weak var doctorServiceLBL: UILabel!
    @IBOutlet weak var medicalServiceLBL: UILabel!
    @IBOutlet weak var seeAllTopDoctorBTN: UIButton!
    
    @IBOutlet weak var seeAllTopOfferBTN: UIButton!
    @IBOutlet weak var topOfferLBL: UILabel!
    @IBOutlet weak var topDoctorLBL: UILabel!
    
    
    @IBOutlet var pagerSlider: FSPagerView!{
        didSet{
            self.pagerSlider.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellSlider")
        }}
    let doctorServiseArr = [UIImage(named: "home1"), UIImage(named: "home2"), UIImage(named: "home3"), UIImage(named: "home4"), UIImage(named: "home5")]
    let meedicalServiseArr = [(UIImage(named: "ic_hospital"), "Hospital".localized),(UIImage(named: "ms2"), "Pharmacy"),(UIImage(named: "ms3"), "Lab"),(UIImage(named: "ms4"), "X-Rays")]
    var homeResponse: HomeModel?
    
    let btn = BadgedButtonItem(with: AppImages.notLogo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        pagerSlider.transformer = FSPagerViewTransformer(type: .linear)
        searchView.ShadowView(view: searchView, radius: 10, opacity: 0.4, shadowRadius: 4, color: UIColor.lightGray.cgColor)
        searchTXT.delegate = self
        setupPagerSlider()
        setupCollectionView()
        
        self.navigationItem.rightBarButtonItem = btn

        btn.tapAction = {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Home".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
    }
    
    func setupCollectionView(){
        SpecializationsCollection.register(SpecializationsCell.nib, forCellWithReuseIdentifier: "SpecializationsCell")
        SpecializationsCollection.delegate = self
        SpecializationsCollection.dataSource = self
        
        doctorServiseCollection.register(DoctorServicesCell.nib, forCellWithReuseIdentifier: "DoctorServicesCell")
        doctorServiseCollection.delegate = self
        doctorServiseCollection.dataSource = self
        
        
        medicalServiseCollection.register(MedicalServicesCell.nib, forCellWithReuseIdentifier: "MedicalServicesCell")
        medicalServiseCollection.delegate = self
        medicalServiseCollection.dataSource = self
        
        
        topDoctorCollection.register(TopDoctorCell.nib, forCellWithReuseIdentifier: "TopDoctorCell")
        topDoctorCollection.delegate = self
        topDoctorCollection.dataSource = self
        
        
        topOffersCollection.register(TopOffersCell.nib, forCellWithReuseIdentifier: "TopOffersCell")
        topOffersCollection.delegate = self
        topOffersCollection.dataSource = self
    }
    func setupPagerSlider(){
        pagerSlider.delegate = self
        pagerSlider.dataSource = self
        pagerSlider.automaticSlidingInterval = 2.0
        pagerSlider.isInfinite = true
        pagerSlider.transformer = FSPagerViewTransformer(type: .linear)
        pagerSlider.transformer = FSPagerViewTransformer(type: .linear)
        pagerSlider.itemSize = CGSize(width: pagerSlider.frame.width - 90, height: 142)
        pagerSlider.backgroundColor
            = .clear
    }

    @IBAction func seeallDoctors_Click(_ sender: Any) {
        let vc = AllSearchVC()
//        vc.model = homeResponse
        self.show(vc, sender: nil)
    }
    @IBAction func search_Click(_ sender: Any) {
        let vc = AllSearchVC()
//        vc.model = homeResponse
//        let vc  = AddAppointmentVC()
        self.show(vc, sender: nil)
    }
    @IBAction func seeAllSpecialization_Click(_ sender: Any) {
        let vc = SearchOeVc()
        vc.model = homeResponse
        self.show(vc, sender: nil)
    }
    @IBAction func seeAllTopOffers_Click(_ sender: Any) {
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let vc = AllSearchVC()
        vc.searchtext = textField.text ?? ""
        self.show(vc, sender: nil)
    }
}

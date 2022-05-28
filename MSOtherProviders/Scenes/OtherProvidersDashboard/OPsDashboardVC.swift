//
//  OPsDashboardVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/28/22.
//
//

import UIKit
import Kingfisher
import FSPagerView
import SwiftMessages



//MARK: View -
protocol OPsDashboardViewProtocol: AnyObject {
    var presenter: OPsDashboardPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func reloadData()
    func showMessageAlert(title:String, message:String)
}

class OPsDashboardVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var roundedViews: [UIView]!
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var msLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet var pagerSlider: FSPagerView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: OPsDashboardPresenterProtocol!
    
    // MARK: - Private properties -
    var type:MSType{
        get{ presenter.type }
        set{ presenter.type = newValue }
    }
        
    // MARK: - Initializers -
    init() {
        super.init(nibName: "OPsDashboard", bundle: nil)
        presenter = OPsDashboardPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundedViews.forEach({ $0.roundCorners([.topLeft, .topRight], radius: 10) })
    }
    
    private func setupLayout(){
        setupPagerSlider()
        title = presenter.title
        showUniversalLoadingView(true)
        msLabel.text = presenter.msLabelTitle
        searchTextField.delegate = self
        searchTextField.placeholder = presenter.searchPlaceholder
        shadowsViews.forEach ({ $0.applyShadow(0.3) })
        tableView.register(UINib(nibName: "EPrescriptionCell", bundle: nil), forCellReuseIdentifier: "EPrescriptionCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupPagerSlider(){
        pagerSlider.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellSlider")
        pagerSlider.isInfinite = true
        pagerSlider.automaticSlidingInterval = 5.0
        pagerSlider.interitemSpacing = 10
        pagerSlider.transformer = FSPagerViewTransformer(type: .linear)
        pagerSlider.itemSize = CGSize(width: pagerSlider.frame.width - 100, height: pagerSlider.frame.height - 40)
        pagerSlider.backgroundColor
            = .clear
        pageControl.currentPage = 5
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(UIColor.selectedPCColor, for: .selected)
        pageControl.setFillColor(UIColor.normalPCColor, for: .normal)
        pagerSlider.delegate = self
        pagerSlider.dataSource = self
    }
    
    
    
    @IBAction func showOrdersList(_ sender: UIButton) {
        
    }
    
   
    @IBAction func uploadEPrescription(_ sender: UIButton) {
        
    }
    
    @IBAction func showEPrescriptionsList(_ sender: UIButton) {
        
    }
    
    @IBAction func showTestList(_ sender: UIButton) {
        showSearchResultVC()
    }
    
    @IBAction func showSearchTestList(_ sender: UIButton) {
        guard let text = searchTextField.text?.trimmingCharacters(in: .whitespaces),
            !text.isEmpty
        else { return }
        showSearchResultVC(searchText: text)
    }
    
    func showSearchResultVC(searchText:String? = nil){
        view.endEditing(true)
    }
}

// MARK: - Extensions -
// MARK: - UITextFieldDelegate Extension -
extension OPsDashboardVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = searchTextField.text?.trimmingCharacters(in: .whitespaces),
            !text.isEmpty
        else { return false }
        showSearchResultVC(searchText: text)
        return false
    }
    
}
// MARK: - OPsDashboardViewProtocol Extension -
extension OPsDashboardVC: OPsDashboardViewProtocol {
    
    func reloadData(){
        showUniversalLoadingView(false)
        pagerSlider.reloadData()
        tableView.reloadData()
    }
    
    func showMessageAlert(title: String, message: String) {
        showUniversalLoadingView(false)
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
}

extension OPsDashboardVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfEPrescriptions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EPrescriptionCell", for: indexPath) as! EPrescriptionCell
        
        presenter.configEPrescriptionCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

extension OPsDashboardVC : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let numberOfItems = presenter.numberOfAds
        pageControl.numberOfPages = numberOfItems
        return numberOfItems
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellSlider", at: index)
        presenter.configAdCell(cell: cell, index: index)
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
    
}

protocol FSPagerViewCellProtocol{
    func config(display:SliderDisplayCell)
}

extension FSPagerViewCell: FSPagerViewCellProtocol {
    
    func config(display:SliderDisplayCell) {
        //imageView?.image = UIImage(named: display)
        imageView?.kf.indicatorType = .activity
        imageView?.kf.setImage(with: display.imgURL)
        imageView?.cornerRadius = 20
        imageView?.contentMode = .scaleToFill
        textLabel?.superview?.isHidden = true
        contentView.layer.shadowOpacity = 0.3
    }
    
}


extension UIColor{
    
    public static let normalPCColor = UIColor(named: "normalPCColor")
    public static let selectedPCColor = UIColor(named: "selectedPCColor")
    
}

extension UIView{
    
    func applyShadow(_ shadowOpacity:Float = 1) {
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = shadowOpacity
    }
    
    
    func applyCustomShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        shadowLayer.path = cgPath
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.addSublayer(shadowLayer)
    }
    
}


//
//  OPsDashboardVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/28/22.
//
//

import UIKit
import PKHUD
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
    func showOtherProvidersList(request:RequestType)
}

class OPsDashboardVC: UIViewController {

    // MARK: - Public properties -
    @IBOutlet var roundedViews: [UIView]!
    @IBOutlet var shadowsViews: [UIView]!
    @IBOutlet weak var msLabel: UILabel!
    @IBOutlet weak var adsLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet var pagerSlider: FSPagerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msImageView: UIImageView!
    
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
        HUD.show(.progress)
        title = presenter.title
        msLabel.text = presenter.msLabelTitle
        searchTextField.delegate = self
        msImageView.image = UIImage(named: presenter.type.msImageNamed)
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
    
    
    @IBAction func uploadEPrescription(_ sender: UIButton) {
        //showBottomSheet()
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overCurrentContext
        imagePickerController.modalTransitionStyle = .crossDissolve
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction func showOrdersList(_ sender: UIButton) {
        
    }
    
    @IBAction func showEPrescriptionsList(_ sender: UIButton) {
        let vc = EPrescriptionListVC()
        vc.type = presenter.type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showMSList(_ sender: UIButton) {
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
        searchTextField.text = ""
        let vc = SearchOPServicesVC()
        var msRequest = presenter.msRequest
        msRequest.searchText =  searchText
        vc.msRequest = msRequest
        navigationController?.pushViewController(vc, animated: true)
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
        HUD.flash(.success)
        pagerSlider.reloadData()
        tableView.reloadData()
    }
    
    func showMessageAlert(title: String, message: String) {
        
        showMessage(title: title, sub: message, type: Theme.error, layout: .centeredView)
    }
    
    
    func showOtherProvidersList(request:RequestType){
        let vc = OtherProvidersListVC()
        vc.type = presenter.type
        vc.request = request
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - OPsDashboardVC UITableViewDelegate UITableViewDataSource -
extension OPsDashboardVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = presenter.numberOfEPrescriptions
        if numberOfRows == 0 { tableView.setEmptyMessage() }
        else { tableView.hiddenEmptyMessage() }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EPrescriptionCell", for: indexPath) as! EPrescriptionCell
        
        presenter.configEPrescriptionCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - OPsDashboardVC FSPagerViewDelegate FSPagerViewDataSource -
extension OPsDashboardVC : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let numberOfItems = presenter.numberOfAds
        pageControl.numberOfPages = numberOfItems
        adsLabel.isHidden = numberOfItems > 0
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


// MARK: - OPsDashboardVC ImagePickerDelegate -
extension OPsDashboardVC: ImagePickerDelegate{
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if images.isEmpty { return }
        imagePicker.dismiss(animated: true)
        showOtherProvidersList(request: .uploadImage(images))
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    
}


// MARK: - OPsDashboardVC UIImagePickerControllerDelegate -
extension OPsDashboardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            showOtherProvidersList(request: .uploadImage([image]))
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            showOtherProvidersList(request: .uploadImage([image]))
        }
    }
    
    
    //MARK: showBottomSheet
    private func showBottomSheet() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            showPickerController(sourceType: .photoLibrary)
            return
        }
        let alertController = UIAlertController(title: "Photo Source".localized, message: "Choose Source".localized, preferredStyle: .actionSheet)
        let cameraAlertAction = UIAlertAction(title: "Camera".localized, style: .default) { _ in
            self.showPickerController(sourceType: .camera)
        }
        alertController.addAction(cameraAlertAction)
        let photoLibraryAlertAction = UIAlertAction(title: "Photo Library".localized, style: .default) { _ in
            self.showPickerController(sourceType: .photoLibrary)
        }
        alertController.addAction(photoLibraryAlertAction)
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        present(alertController, animated: true)
    }
    
    //MARK: showPickerController
    private func showPickerController(sourceType:UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
}

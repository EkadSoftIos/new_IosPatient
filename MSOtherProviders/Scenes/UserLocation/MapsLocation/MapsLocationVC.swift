//
//  MapsLocationVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//
//
import PKHUD
import UIKit
import MapKit
import Kingfisher
import SwiftMessages

//MARK: View -
protocol MapsLocationViewProtocol: AnyObject {
    var presenter: MapsLocationPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    
    func showAppSetting()
    func configBranch(display:OPMapDisplay)
    func addMarkers(opDisplayList:[OPMapDisplay])
    func zoomToUserLocation(coordinate:CLLocationCoordinate2D)
    func showMessageAlert(title: String, message: String,  isError:Bool)
}

extension MapsLocationViewProtocol {
    func showMessageAlert(title: String, message: String, isError:Bool = true){
        showMessageAlert(title: title, message: message, isError: isError)
    }
}

class MapsLocationVC: UIViewController {
    
    // MARK: - Public properties -
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var servicesView: UIView!
    @IBOutlet weak var priceView: UIView!

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var branchAvatarImgView: UIImageView!
    @IBOutlet weak var priceBeforeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var servicesImgeView: UIImageView!
    var presenter: MapsLocationPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "MapsLocation", bundle: nil)
        presenter = MapsLocationPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        branchView.applyShadow(0.3)
        branchAvatarImgView.cornerRadius = branchAvatarImgView.frame.height / 2
    }
    func setupLayoutUI() {
        HUD.show(.progress)
        title = "Select your location".localized
        branchView.isHidden = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }

    @IBAction func bookingBtnTapped(_ sender: UIButton) {
        guard let branch = presenter.branch else { return }
        let vc = OPProfileVC()
        vc.presenter.branch = branch
        vc.presenter.type = presenter.type
        vc.presenter.request = presenter.request
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions -
// MARK: - MapsLocationViewProtocol -
extension MapsLocationVC: MapsLocationViewProtocol {
    
    func showAppSetting() {
        openAppSettings()
    }
    
    func showMessageAlert(title: String, message: String, isError:Bool = true) {
        if HUD.isVisible { HUD.flash(.error) }
        let theme = isError ?  Theme.error:.info
        showMessage(title: title, sub: message, type: theme, layout: .centeredView)
    }
    
    func zoomToUserLocation(coordinate:CLLocationCoordinate2D){
        mapView.centerToLocation(coordinate)
    }
    
    func addMarkers(opDisplayList: [OPMapDisplay]){
        if HUD.isVisible { HUD.flash(.success) }
        opDisplayList.forEach({
            self.addPinToMap(display: $0)
        })
    }
    
    private func addPinToMap(display:OPMapDisplay){
        let annotation = MSPinAnnotation()
        annotation.id = display.id
        annotation.msImageNamed = display.msImage
        annotation.coordinate = display.coordinate
        annotation.title = display.branchName
        annotation.subtitle = display.providerName
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - mapView viewFor annotation -
    func configBranch(display:OPMapDisplay)  {
        func configBranch(){
            providerNameLabel.text = display.providerName
            branchNameLabel.text = display.branchName
            servicesLabel.text = display.servicesText
            priceLabel.text = display.price
            priceBeforeLabel.text = display.priceBeforeDiscount
            priceBeforeLabel.setStrikethroughStyle()
            discountLabel.text = display.discount
            branchAvatarImgView.kf.indicatorType = .activity
            branchAvatarImgView.kf.setImage(with: display.avatar, placeholder: UIImage(named: "ProfileImage"))
            servicesImgeView.image = UIImage(named: display.msImage)
            discountView.isHidden = display.isUploadedEP
            
            servicesView.isHidden = display.isUploadedEP
            priceView.isHidden = display.isUploadedEP
        }
        if branchView.isHidden{
            branchView.alpha = 0
            branchView.isHidden = false
        }
        UIView.transition(with: branchView, duration: 1.0, options: .transitionFlipFromTop, animations:{  [weak self] in
            guard let self = self else { return }
            self.branchView.alpha = 1
            configBranch()
        })
        
    }
    
}

// MARK: - MKMapViewDelegate -
extension MapsLocationVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.centerCoordinate
        //branchView.isHidden = true
        print("coordinate:\(coordinate)")
        
    }
    
    // MARK: - mapView didSelect view -
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let id = view.tag
        presenter.didSelectPin(for: id)
    }
    
    // MARK: - mapView didDeselect view -
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView){
        branchView.isHidden = true
    }
    
    // MARK: - mapView viewFor annotation -
    func mapView( _ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MSPinAnnotation else {
            return nil
        }

        let identifier = "OPMapDisplay"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
        }
        
        view.tag = annotation.id ?? 0
        view.canShowCallout = true
        view.annotation = annotation
        view.markerTintColor = .selectedPCColor
        if let imageNamed = annotation.msImageNamed {
            view.glyphImage = UIImage(named: imageNamed)
        }else{
            //"ms", "raycenter", "microscope", "doctor",
            view.glyphImage = UIImage(named: "ms")
        }
        return view
    }
    
    
}


private extension MKMapView {
    
  func centerToLocation(
    _ coordinate:CLLocationCoordinate2D,
    regionRadius: CLLocationDistance = 100
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}



class MSPinAnnotation:MKPointAnnotation{
    var id:Int?
    var msImageNamed:String?
}

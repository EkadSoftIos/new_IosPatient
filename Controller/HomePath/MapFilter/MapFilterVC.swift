//
//  MapFilterVC.swift
//  E4 Patient
//
//  Created by Nada on 3/8/22.
//


import UIKit
import MapKit

class MapFilterVC: UIViewController, BaseViewProtocol {
    
    var lattitude: Double = 0.0
    var longtitude: Double = 0.0
    var address: String = ""
    
    var manager: CLLocationManager?
    var regionRadius: CLLocationDistance = 1000
    
    var filteredDoctors: [DoctorSearchData]?
        
    var vw = UIView(frame: UIScreen.main.bounds)
    var indicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var bgCenterMap: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressBGView: UIView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var doctorsCollView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Your Location"
        
        mapView.delegate = self
        manager = CLLocationManager()
        manager?.delegate = self

        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()

        checkLocationAuthStatus()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        centerMapOnUserLocation()
        
        doctorsCollView.delegate = self
        doctorsCollView.dataSource = self
        doctorsCollView.isPagingEnabled = true
        doctorsCollView.register(UINib(nibName: "MapFilterDoctorsCell", bundle: nil), forCellWithReuseIdentifier: "MapFilterDoctorsCell")
    }
    func checkLocationAuthStatus(){
      if CLLocationManager.authorizationStatus() == .authorizedAlways{
        manager?.startUpdatingLocation()
      }else{
        manager?.requestAlwaysAuthorization()
      }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addressBGView.setupShadowView(cornerRadius: 9, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
//        bgCenterMap.setupShadowView(cornerRadius: 9, shadowRadius: 4, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), shadowOpacity: 0.4, shadowOffset: .init(width: 3, height: 4), borderwidth: 0.2, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16))
    }

    @IBAction func centerMapOnUserLocation(_ sender: Any) {
        checkLocationAuthStatus()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        centerMapOnUserLocation()
    }
    
    func centerMapOnUserLocation() {
      let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // Draw annotation on map kit
//    fileprivate func drawMarker() {
//        guard let doctorsData = self.filteredDoctors else {return}
//        for doctor in doctorsData {
//            guard let lat = Double(doctor.mainAddress?.branchLat ?? "0.0") else {return}
//            guard let lng = Double(doctor.mainAddress?.branchLang ?? "0.0") else {return}
//            print(lat)
//            print(lng)
//
//            loadAnnotations(imageUrl: doctor.profileImage ?? "",lat: lat, lng: lng)
//        }
//
//    }
    
    func loadAnnotations(imageUrl: String, lat: Double, lng: Double) {
            let request = NSMutableURLRequest(url: URL(string: imageUrl)!)
            request.httpMethod = "GET"

            let session = URLSession(configuration: URLSessionConfiguration.default)
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if error == nil {

                    let annotation = ImageAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(lat, lng)
                    annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
                    annotation.title = "Toronto"
                    annotation.subtitle = "Yonge & Bloor"


                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }

            dataTask.resume()
        }
    
    // remove all annotations()
    fileprivate func removeAllAnnotations() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    
    func filterDoctors(lat: String, lng: String) {
        let para: [String: Any] = [
            "Latitude": lat,
            "Longitude": lng,
            "distance": 10
        ]
        
        print(para)
        self.showActivityIndicator(view: self.vw, indicator: self.indicator)
        NetworkClient.performRequest(_type: DoctorSearchModel.self, router: .doctorSearch(parameters: para)) {[weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicator(view: self.vw, indicator: self.indicator)
            switch result {
            case.success(let data):
                print(data)
                self.filteredDoctors = data.message ?? []
                self.doctorsCollView.reloadData()
//                self.removeAllAnnotations()
//                self.drawMarker()
            case.failure(let err):
                self.showAlert(message: err.localizedDescription)
            }
        }
    }

    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension MapFilterVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.centerCoordinate
        
        self.lattitude = coordinate.latitude
        self.longtitude = coordinate.longitude
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            self.filterDoctors(lat: "\(self.lattitude)", lng: "\(self.longtitude)")
        }
       
        
        mapView.getAddressFromLatLon(pdblLatitude: String(coordinate.latitude), withLongitude: String(coordinate.longitude)) { (address) in
            if address != "" {
             self.address = address
                self.addressLbl.text = address
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
                return nil  //Default is to let the system handle it.
            }

            if !annotation.isKind(of: ImageAnnotation.self) {  //Handle non-ImageAnnotations..
                var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
                if pinAnnotationView == nil {
                    pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
                }
                return pinAnnotationView
            }

            //Handle ImageAnnotations..
            var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
            if view == nil {
                view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            }

            let annotation = annotation as! ImageAnnotation
            view?.image = annotation.image
            view?.annotation = annotation

            return view
        }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation title == \(String(describing: view.annotation?.title!))")
    }
    
}

extension MapFilterVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
     if status == .authorizedAlways {
       mapView.showsUserLocation = true
       mapView.userTrackingMode = .follow
     }
    }
}

//MARK:- Custom Pin class
class CustomPointAnnotation: MKPointAnnotation {

    var tag: String?
    var imageView: UIImageView?

}

extension MapFilterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDoctors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapFilterDoctorsCell", for: indexPath) as! MapFilterDoctorsCell
        
        let doctorModel = filteredDoctors?[indexPath.row]
        let imgURL = URL(string: "\(Constants.baseURLImage)\(doctorModel?.profileImage ?? "")")
        cell.doctorImage?.kf.indicatorType = .activity
        cell.doctorImage?.kf.setImage(with: imgURL)
        Animation.roundView(cell.doctorImage)
        cell.nameLbl.text = doctorModel?.doctorName
        cell.detailsOneLbl.text = doctorModel?.specialityLocalized
        cell.detailsTwoLbl.text = doctorModel?.fullProfisionalDetailsLocalized
        cell.detailsThreeLbl.text = doctorModel?.mainAddress?.branchNameLocalized ?? ""
        cell.rateLbl.text = String(doctorModel?.totalRate ?? 0)
        cell.doctorCanDo = doctorModel?.doctorCanDo ?? []
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        vc.doctorId = filteredDoctors?[indexPath.row].businessProviderEmployeeID ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

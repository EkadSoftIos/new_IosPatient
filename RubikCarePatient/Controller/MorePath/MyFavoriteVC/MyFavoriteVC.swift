//
//  MyFavoriteVC.swift
//  E4 Patient
//
//  Created by mohab on 09/05/2021.
//

import UIKit

class MyFavoriteVC: UIViewController {
    @IBOutlet var myFavouriteTableView: UITableView!
    var doctorID = 0
    var favModel : [FavouriteDoctorMessage]?{
        didSet{
            if favModel?.count == 0 {
                myFavouriteTableView.setEmptyView()
            }else{
                myFavouriteTableView.reloadData()
            }
            
        }
    }
    var addedSuccess = ""{
        didSet{
            callApi()
//            myFavouriteTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "My Favourite".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        callApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    func setupTableView(){
        myFavouriteTableView.register(MyFavoriteCell.nib, forCellReuseIdentifier: "MyFavoriteCell")
        myFavouriteTableView.delegate = self
        myFavouriteTableView.dataSource = self
        myFavouriteTableView.separatorStyle = .none
    }


}
extension MyFavoriteVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteCell") as! MyFavoriteCell
        cell.selectionStyle = .none
        let currentModel = favModel?[indexPath.row]
        let imgURL = URL(string: "\(Constants.baseURLImage)\(currentModel?.profileImage ?? "")")
        cell.doctorIMG?.kf.indicatorType = .activity
        cell.doctorIMG?.kf.setImage(with: imgURL)
        Animation.roundView(cell.doctorIMG)
        cell.doctorNameLBL.text = "\(currentModel?.prefixTitleLocalized ?? "")\(currentModel?.doctorName ?? "")"
        cell.consultantInLBL.text = "\("Consultant in")\(" ")\(currentModel?.fullProfisionalDetailsLocalized ?? "")"
        cell.specialLBL.text = currentModel?.specialityLocalized
        cell.locationLBL.text = currentModel?.mainAddress?.branchNameLocalized
        cell.locationLBL.numberOfLines = 3
        cell.locationLBL.sizeToFit()
        cell.rateLBL.text = "\(currentModel?.totalRate ?? 0)"
        if currentModel?.isOnline ?? false {
            cell.statusView.backgroundColor = UIColor.green
        }else{
            cell.statusView.backgroundColor = UIColor.clear
        }
        Animation.roundView(cell.statusView)
        cell.favBTN.tag = indexPath.row
        cell.favBTN.addTarget(self, action: #selector(removeFromFav(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func removeFromFav(sender: UIButton){
        doctorID = favModel?[sender.tag].businessProviderEmployeeID ?? 0
        callRemoveFromFavApi()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DoctorProfileVC()
//        vc.doctorId = favModel?[indexPath.row].businessProviderEmployeeID
//        self.show(vc, sender: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        vc.doctorId = favModel?[indexPath.row].businessProviderEmployeeID
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

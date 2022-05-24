//
//  AddMedication+Table+Collection.swift
//  E4 Patient
//
//  Created by mohab on 20/01/2021.
//


import UIKit

extension AddMedicationListVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.message?.count != nil {
            return (model?.message?.count ?? 0)
        }else{
           return 0
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMedicationTableCell", for: indexPath) as! addMedicationTableCell
        cell.selectionStyle = .none
        let medicineData = model?.message?[indexPath.row]
        cell.nameLbl.text = medicineData?.nameLocalized
        cell.doseLbl.text = "\(medicineData?.medicineTypeNameLocalized ?? "")\(" - ")\(medicineData?.medicineStrenght ?? "")"
        let image = "\(Constants.baseURLImage)\(medicineData?.medicineImagePath  ?? "")"
        
        cell.medicineImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "BarLogo"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountinueAddMedicationVC()
        vc.Medicationmodel = model?.message?[indexPath.row]
        vc.model = userModel
        vc.Delegete = self
        show(vc, sender: true)
    }
}

extension AddMedicationListVC: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model?.message?.count != nil {
            return (model?.message?.count ?? 0)
        }else{
           return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMedicationCollectionCell", for: indexPath) as! AddMedicationCollectionCell
        let medicineData = model?.message?[indexPath.row]
        cell.nameLbl.text = medicineData?.nameLocalized
        cell.doseLbl.text = "\(medicineData?.medicineTypeNameLocalized ?? "")\(" - ")\(medicineData?.medicineStrenght ?? "")"
        let image = "\(Constants.baseURLImage)\(medicineData?.medicineImagePath ?? "")"
        cell.medicineImage.kf.setImage(with: URL(string: image),placeholder: UIImage(named: "BarLogo"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5  ,height:  150 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CountinueAddMedicationVC()
        vc.Medicationmodel = model?.message?[indexPath.row]
        vc.model = userModel
        vc.Delegete = self
        show(vc, sender: true)
    }
}

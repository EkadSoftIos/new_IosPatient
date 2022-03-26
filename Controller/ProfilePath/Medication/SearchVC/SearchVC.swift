//
//  SearchVC.swift
//  Khadom
//
//  Created by mohab on 23/12/2020.
//  Copyright © 2020 panorama. All rights reserved.
//

import UIKit
protocol SearchDelegete {
    func Data(medModel: AllMedicineMessage)
}
class SearchVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchBarTxt: UISearchBar!
    var doctorsModel: getAllMedicineModel?
    var searchArr: [AllMedicineMessage]?
    var Delegete: SearchDelegete?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarTxt.delegate = self
        SetUpTableView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("")
        }else{
            searchArr = searchText.isEmpty ? doctorsModel?.message ?? []: doctorsModel?.message?.filter { (item: (AllMedicineMessage)) -> Bool in
                return item.nameLocalized?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        } ?? []
            self.searchTableView.reloadData()
        }
        
    }
    func SetUpTableView(){
        searchTableView.register(DoctorsSearchCell.nib, forCellReuseIdentifier: "doctorsCell")
        searchTableView.separatorStyle = .none
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorsCell") as! DoctorsSearchCell
        cell.selectionStyle = .none
        cell.nameLbl.text = searchArr?[indexPath.row].nameLocalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarTxt.text = searchArr?[indexPath.row].nameLocalized
        Delegete?.Data(medModel: (searchArr?[indexPath.row])!)
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

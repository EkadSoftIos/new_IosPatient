//
//  SearchOeVc.swift
//  E4 Patient
//
//  Created by mohab on 25/04/2021.
//

import UIKit

class SearchOeVc: UIViewController ,UISearchBarDelegate{
    @IBOutlet var searchTableView: UITableView!
    var model: HomeModel?
    var newModel: HomeModel?
    var currentArray: [Speciality]?
    
    var consultationServiceId: Int? 
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setTableView()
    }
    func setTableView(){
        searchTableView.register(SearchOneCell.nib, forCellReuseIdentifier: "SearchOneCell")
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Search".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.Blue]
        newModel = model
        currentArray = model?.message?.speciality
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                if searchText.isEmpty {
                    self.currentArray = newModel?.message?.speciality
                    self.searchTableView.reloadData()
                } else {
                    self.currentArray = self.currentArray?.filter({ (doctor) -> Bool in
                        guard let searchTxt = self.searchBar.text else {return false}
                        return (doctor.nameLocalized!.lowercased().contains(searchTxt.lowercased()))
                                })
                    self.searchTableView.reloadData()
                }

    }
}

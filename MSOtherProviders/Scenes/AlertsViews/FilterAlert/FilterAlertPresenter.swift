//
//  FilterAlertPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/31/22.
//
//

import Foundation

//MARK: Presenter -
protocol FilterAlertPresenterProtocol: AnyObject {
    var numberOfRows:Int { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func selectedSort(at indexPath:IndexPath) -> SortType
    func config(cell:FilterCellProtocol, indexPath:IndexPath)
}

class FilterAlertPresenter {
    
    // MARK: - Public properties -
    var numberOfRows:Int{
        SortType.allCases.count
    }
    
    // MARK: - Private properties -
    private weak var view: FilterAlertViewProtocol?
    
    // MARK: - Init -
    init(view: FilterAlertViewProtocol) {
        self.view = view
    }
}

// MARK: - Extensions -
extension FilterAlertPresenter: FilterAlertPresenterProtocol {
    
    func viewDidLoad() {
       
    }
    
    func selectedSort(at indexPath:IndexPath) -> SortType {
        SortType.allCases[indexPath.row]
    }
    
    func config(cell:FilterCellProtocol, indexPath:IndexPath){
        let sort = SortType.allCases[indexPath.row]
        var sortText = "Sort \(sort.rawValue)"
        switch sort{
        case .highestDiscount:
            sortText = "Highest Discount".localized
        case .lowestDiscount:
            sortText = "Lowest Discount".localized
        case .lowToHighPrice:
            sortText = "Low To High Price".localized
        case .highToLowPrice:
            sortText = "High To Low Price".localized
        }
        cell.config(display: FilterCellDisplay(name: sortText.localized))

    }
}

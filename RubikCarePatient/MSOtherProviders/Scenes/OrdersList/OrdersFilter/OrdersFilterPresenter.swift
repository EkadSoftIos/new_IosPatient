//
//  OrdersFilterPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/9/22.
//
//

import Foundation



//MARK: Presenter -
protocol OrdersFilterPresenterProtocol: AnyObject {
    var canSearch:Bool{ get }
    var type:MSType{ get set }
    var numberOfRows:Int{ get }
    var toDate:Date? { get set }
    var fromDate:Date? { get set }
    var filter:OrdersFilter { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:FilterCellProtocol, indexPath:IndexPath)
    func didSelectRow(at indexPath:IndexPath)
    func didSelectRow(at index:Int, with id:Int)
}

class OrdersFilterPresenter {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var numberOfRows:Int{
        DateFilterType.allCases.count
    }
    
    var toDate:Date? {
        get{ toDateFilter }
        set{
            toDateFilter = newValue
            if selectDateFilterType == .customDate{
                if let dt = toDateFilter {
                    view?.toDateText = getDateText(dt)
                }else{ view?.toDateText = "To".localized }
            }
        }
    }
    var fromDate:Date? {
        get{ fromDateFilter }
        set{
            fromDateFilter = newValue
            if selectDateFilterType == .customDate{
                if let dt = fromDateFilter {
                    view?.fromDateText = getDateText(dt)
                }else{ view?.fromDateText = "From".localized }
            }
        }
    }
    
    var canSearch:Bool{
        if selectDateFilterType != nil, fromDateFilter == nil, toDateFilter == nil {
            view?.showMessageAlert(title: .error, message: "Please, choose dates".localized)
            return false
        }
        return true
    }
    
    var filter:OrdersFilter{
        OrdersFilter(
            fromDate: fromDateFilter?.asString,
            toDate: toDateFilter?.asString,
            opId: selectOP?.otherProviderID
        )
    }
    
    
    // MARK: - Private properties -
    private var toDateFilter:Date?
    private var fromDateFilter:Date?
    private var pageType:MSType!
    private var selectOP:OtherProvider?
    private var opsList: [OtherProvider] = []
    private var selectDateFilterType:DateFilterType?
    private weak var view: OrdersFilterViewProtocol?
    private var msNetworkRepository:MSNetworkRepository?
    
    // MARK: - Init -
    init(view: OrdersFilterViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
}

// MARK: - Extensions -
extension OrdersFilterPresenter: OrdersFilterPresenterProtocol {
    
    func viewDidLoad() {
        fetchData()
    }
    
    func resetFilter(){
        toDate = nil
        fromDate = nil
        selectOP = nil
        selectDateFilterType = nil
        let optionArray = opsList.asStringList
        let optionIds = opsList.map({ $0.otherProviderID })
        view?.reloadDropDown(optionArray: optionArray, optionIds: optionIds)
    }
    // MARK: - fetchData -
    func fetchData() {
        let msOPRequest = MSOPServicesRequest(type: pageType)
        let url = NetworkURL(.otherProviderList(msOPRequest))
        msNetworkRepository?.fetch(OPListReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.opsList.append(contentsOf: response.opsList)
                let optionArray = response.opsList.asStringList
                let optionIds = response.opsList.map({ $0.otherProviderID })
                self.view?.reloadDropDown(optionArray: optionArray, optionIds: optionIds)
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }

    // MARK: - config -
    func config(cell:FilterCellProtocol, indexPath:IndexPath){
        let filter = DateFilterType.allCases[indexPath.row].asString
        cell.config(display: FilterCellDisplay(name: filter))
    }
    
    //MARK: - config -
    func didSelectRow(at indexPath:IndexPath){
        selectDateFilterType = DateFilterType.allCases[indexPath.row]
        switch selectDateFilterType {
        case .last7Days:
            fromDate = Date()
            toDate = fromDate?.dateByAdding(component: .day, value: 7)
        case .last30Days:
            fromDate = Date()
            toDate = fromDate?.dateByAdding(component: .day, value: 30)
        case .customDate:
            toDate = nil
            fromDate = nil
        default:
            break
        }
    }
    
    //MARK: - didSelectDate -
    func didSelectRow(at index:Int, with id:Int){
        guard index < opsList.count else { return }
        selectOP = opsList[index]
        print("didSelectRow \(index) with id \(id)")
        print("selectOP \(selectOP!),index opsList \(opsList[index])")
    }
        
    private func getDateText(_ dt: Date)-> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.current.languageCode!)
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: dt)
    }
    
}

struct OrdersFilter {
    let fromDate:String?
    let toDate:String?
    let opId:Int?
}

enum DateFilterType: Int, Codable, CaseIterable{
    case last7Days = 1
    case last30Days
    case customDate
}

extension DateFilterType {
    
    var asString:String{
        switch self {
        case .last7Days:
            return "Last 7 days".localized
        case .last30Days:
            return "Last 30 days".localized
        case .customDate:
            return "Custom date".localized
        }
    }
    
}

extension Array{
    
    fileprivate var asStringList: [String]{
        guard let opsList = self as? [OtherProvider] else { return [] }
        var itemsList:[String] = []
        for (index, item) in opsList.enumerated() {
            itemsList.append("\(index + 1) - \(item.otherProviderNameLocalized)")
        }
        return itemsList
    }
}

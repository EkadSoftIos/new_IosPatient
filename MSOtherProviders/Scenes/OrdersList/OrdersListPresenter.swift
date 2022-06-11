//
//  OrdersListPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//
//
import PKHUD
import Foundation

//MARK: Presenter -
protocol OrdersListPresenterProtocol: AnyObject {
    var type:MSType { get set}
    var numberOfRows:Int { get }
    var canFetchMore:Bool { get }
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
    func config(cell:OrderCellProtocol, indexPath:IndexPath)
    func loadMore()
    func filterOrders(_ filter:OrdersFilter)
    func searchOrders(_ search:String)
    func didSelectRow(at indexPath:IndexPath) -> Order
}

class OrdersListPresenter {
    
    // MARK: - Public properties -
    var type:MSType{
        get{ pageType }
        set{ pageType = newValue }
    }
    
    var numberOfRows: Int{
        ordersList.count
    }
    
    var canFetchMore:Bool{
        rowsNumberOfPage >= 10
    }
    
    // MARK: - Private properties -
    private var pageType:MSType!
    private var rowsNumberOfPage = 0
    private var oRequest:OrderListRequest!
    private var ordersList:[Order] = []
    private var msNetworkRepository:MSNetworkRepository?
    private weak var view: OrdersListViewProtocol?
    
    // MARK: - Init -
    init(view: OrdersListViewProtocol,
         networkManager:MSNetworkRepository = MSAPIsManager()) {
        self.view = view
        self.msNetworkRepository = networkManager
    }
    
}

// MARK: - Extensions -
extension OrdersListPresenter: OrdersListPresenterProtocol {
    
    func viewDidLoad() {
        oRequest = OrderListRequest(
            type: pageType,
            pageNum: 1
        )
        fetchData()
    }
    
    func fetchData() {
        let url = NetworkURL(.orderList(oRequest))
        msNetworkRepository?.fetch(OrderListReponse.self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let error = response.errormessage, response.successtate != 200 {
                    self.view?.showMessageAlert(title: .error, message: error)
                    return
                }
                self.rowsNumberOfPage = response.orders.count
                self.ordersList.append(contentsOf: response.orders)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showMessageAlert(title: .error, message: error.localizedDescription)
            }
        }//end closure
    }
    
    // MARK: - filterOrders -
    func filterOrders(_ filter:OrdersFilter){
        HUD.show(.progress)
        oRequest.pageNum = 1
        oRequest.fromDate = filter.fromDate
        oRequest.toDate = filter.toDate
        oRequest.otherProviderFk = filter.opId
        ordersList.removeAll()
        fetchData()
    }
    
    // MARK: - searchOrders -
    func searchOrders(_ search:String){
        HUD.show(.progress)
        oRequest.pageNum = 1
        oRequest.searchBookingNumber = search
        ordersList.removeAll()
        fetchData()
    }
    
    // MARK: - loadMore -
    func loadMore(){
        oRequest.pageNum! += 1
        fetchData()
    }
    
    // MARK: - config -
    func config(cell:OrderCellProtocol, indexPath:IndexPath){
        let order = ordersList[indexPath.row]
        let display = OrderCellDisplay(order: order, type: pageType)
        cell.config(display: display)
    }
    
    // MARK: - config -
    func didSelectRow(at indexPath:IndexPath) -> Order{
        ordersList[indexPath.row]
    }

}

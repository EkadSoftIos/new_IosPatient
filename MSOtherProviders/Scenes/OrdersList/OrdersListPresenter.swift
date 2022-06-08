//
//  OrdersListPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//
//

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
    private var ordersList:[String] = []
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
       
    }
}

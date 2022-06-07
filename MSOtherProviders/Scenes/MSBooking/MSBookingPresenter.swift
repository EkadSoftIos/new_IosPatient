//
//  MSBookingPresenter.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//
//

import Foundation

//MARK: Presenter -
protocol MSBookingPresenterProtocol: AnyObject {
    /**
     * Add here your methods for communication VIEW -> PROTOCOL
     */
    func viewDidLoad()
}

class MSBookingPresenter {
    
    // MARK: - Public properties -
    
    // MARK: - Private properties -
    private weak var view: MSBookingViewProtocol?
    
    // MARK: - Init -
    init(view: MSBookingViewProtocol) {
        self.view = view
    }
}

// MARK: - Extensions -
extension MSBookingPresenter: MSBookingPresenterProtocol {
    
    func viewDidLoad() {
       
    }
    
    
      
    
}

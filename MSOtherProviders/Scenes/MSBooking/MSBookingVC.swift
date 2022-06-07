//
//  MSBookingVC.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//
//

import UIKit

//MARK: View -
protocol MSBookingViewProtocol: AnyObject {
    var presenter: MSBookingPresenterProtocol!  { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
}

class MSBookingVC: UIViewController {

    // MARK: - Public properties -
    var presenter: MSBookingPresenterProtocol!
    
    // MARK: - Private properties -
    
    // MARK: - Initializers -
    init() {
        super.init(nibName: "MSBooking", bundle: nil)
        presenter = MSBookingPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        presenter.viewDidLoad()
    }
    
    func setupLayoutUI() {
        
    }

}

// MARK: - Extensions -
extension MSBookingVC: MSBookingViewProtocol {
    
    
}

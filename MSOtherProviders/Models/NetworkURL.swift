//
//  URLs.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Alamofire
import Foundation

typealias URLs = NetworkURL.URLs


class NetworkURL{
    
    // MARK: - Private properties -
    private let type:URLTypes
    private let testingPath:String?
    
    
    init(_ type:URLTypes, testingPath:String? = nil) {
        self.type = type
        self.testingPath = testingPath
    }
    
    
    // MARK: - url -
    var url:URL? {
        if let testingPath = testingPath { return URL(fileURLWithPath: testingPath) }
        switch self.type {
        case .otherProviderDashboard(_):
            return URL(string: "\(URLs.otherProviderDashboard)")
        case .searchServiceListForPatient(_):
            return URL(string: "\(URLs.searchServiceListForPatient)")
        case .ePrescriptions(_):
            return URL(string:  "\(URLs.ePrescriptions)")
        case .otherProviders(_):
            return URL(string:  "\(URLs.otherProviders)")
        case .availableCountries:
            return URL(string:  "\(URLs.availableCountries)")
        case .opBranchDetails(_):
            return URL(string:  "\(URLs.opBranchDetails)")
        case .serviceTypeList(_):
            return URL(string:  "\(URLs.serviceTypeList)")
        case .addNewOrder(_):
            return URL(string:  "\(URLs.addNewOrder)")
        case .uploadImages:
            return URL(string:  "\(URLs.uploadImages)")
        case .upFilesRequest(_):
            return URL(string:  "\(URLs.uploadPrescriptionFiles)")
        case .orderList(_):
            return URL(string:  "\(URLs.getOrderList)")
        case .otherProviderList(_):
            return URL(string:  "\(URLs.getOtherProviderList)")
        case .orderDetails(_):
            return URL(string:  "\(URLs.getOrderDetails)")
        }
    }
    // MARK: - method -
    var method:HTTPMethod{
        switch self.type {
        case
                .otherProviderDashboard(_),
                .serviceTypeList(_),
                .availableCountries,
                .otherProviderList(_),
                .orderDetails(_):
            return .get
        case
                .searchServiceListForPatient(_),
                .ePrescriptions(_),
                .otherProviders(_),
                .opBranchDetails(_),
                .addNewOrder(_),
                .uploadImages,
                .upFilesRequest(_),
                .orderList(_):
            return .post
        }
    }
    
    // MARK: - params -
    var params:[String:Any]?{
        switch self.type {
        case
                .serviceTypeList(let msOPSRequest),
                .otherProviderDashboard(let msOPSRequest),
                .searchServiceListForPatient(let msOPSRequest),
                .otherProviderList(let msOPSRequest):
            return msOPSRequest.dictionary
        case .ePrescriptions(let epRequest):
            return epRequest.dictionary
        case .otherProviders(let opRequest):
            return opRequest.dictionary
        case .opBranchDetails(let branchDetailsRequest):
            return branchDetailsRequest.dictionary
        case .addNewOrder(let addOrderRequest):
            return addOrderRequest.dictionary
        case .upFilesRequest(let upFilesRequest):
            return upFilesRequest.dictionary
        case .orderList( let oRequest):
            return oRequest.dictionary
        case .availableCountries, .uploadImages:
            return nil
        case .orderDetails(let bookingId):
            return [
                "ServiceBookingId": bookingId
            ]
        }
    }
    
    
    
    // MARK: - header -
    var  header:HTTPHeaders?{
        switch self.type {
        case
                .otherProviderDashboard(_),
                .searchServiceListForPatient(_),
                .ePrescriptions(_),
                .otherProviders(_),
                .availableCountries,
                .opBranchDetails(_),
                .serviceTypeList(_),
                .addNewOrder(_),
                .uploadImages,
                .upFilesRequest(_),
                .orderList(_),
                .otherProviderList(_),
                .orderDetails(_):
            return .authHeaderIfLogin
        }
    }
    
    // MARK: - header -
    var encoding:ParameterEncoding{
        switch self.type {
        case
                .otherProviderDashboard(_),
                .serviceTypeList(_),
                .otherProviderList(_),
                .orderDetails(_):
            return URLEncoding.default
        case
                .searchServiceListForPatient(_),
                .ePrescriptions(_),
                .otherProviders(_),
                .availableCountries,
                .opBranchDetails(_),
                .addNewOrder(_),
                .uploadImages,
                .upFilesRequest(_),
                .orderList(_):
            return JSONEncoding.default            
        }
    }
    
}


extension HTTPHeaders {
    
    private static var authHeader:HTTPHeaders {
        let token = UserDefaults.userToken
        if token.isBlank { return .unAuthHeader }
        let header:HTTPHeaders = [
            "Accept":"application/json",
            "Content-Type":"application/json",
            "Authorization":"Bearer \(token)",
            "lang": Languagee.language.code
        ]
        return header
    }
    
    public static var authHeaderIfLogin:HTTPHeaders {
        let token = UserDefaults.userToken
        if token.isBlank { return .unAuthHeader }
        return .authHeader
    }
    
    public static var unAuthHeader:HTTPHeaders {
        [
            "Accept":"application/json",
            "Content-Type":"application/json",
            "lang": Languagee.language.code
        ]
    }
    
}

extension NetworkURL{
        
    enum URLTypes {
        case otherProviderDashboard(MSOPServicesRequest)
        case searchServiceListForPatient(MSOPServicesRequest)
        case ePrescriptions(EPrescriptionRequest)
        case otherProviders(OPRequest)
        case availableCountries
        case opBranchDetails(OPBranchDetailsRequest)
        case serviceTypeList(MSOPServicesRequest)
        case addNewOrder(AddOrderRequest)
        case uploadImages
        case upFilesRequest(UPFilesRequest)
        case orderList(OrderListRequest)
        case otherProviderList(MSOPServicesRequest)
        case orderDetails(Int)
    }
    
    enum URLs{
        // MARK: - Private properties -
        //rootURL = "https://e4clinicdevapi.ekadsoft.org/api/"
        private static let rootURL = Constants.baseURL
        private static let otherProvider = "\(rootURL)OtherProvider/"
        private static let lookup = "\(rootURL)Lookup/"
        private static let common = "\(rootURL)Common/"
        
        // MARK: - public properties -
        public static let baseURLImage = "https://e4clinicdevapi.ekadsoft.org/"
        public static let otherProviderDashboard:String =
            "\(otherProvider)GetDashBoard"
        public static let searchServiceListForPatient:String =
            "\(otherProvider)SearchServiceListForPatient"
        public static let ePrescriptions:String =
            "\(otherProvider)GetPrescriptions"
        public static let otherProviders:String =
            "\(otherProvider)OtherProvidersSearch"
        public static let availableCountries:String =
            "\(lookup)Country_get_all_full"
        public static let opBranchDetails:String =
            "\(otherProvider)GetOtherProviderBranchData"
        public static let serviceTypeList:String =
            "\(otherProvider)GetServiceTypeList"
        public static let addNewOrder:String =
            "\(otherProvider)AddNewOrder"
        public static let uploadImages:String =
            "\(common)FormDataUploadMultiple"
        public static let uploadPrescriptionFiles:String =
            "\(otherProvider)UploadPrescriptionFiles"
        public static let getOrderList:String =
            "\(otherProvider)GetOrderList"
        public static let getOtherProviderList:String =
            "\(otherProvider)GetOtherProviderList"
        public static let getOrderDetails:String =
            "\(otherProvider)GetOrderDetails"
    }
    
}
extension UserDefaults{
    
    public static var userToken:String{
        (UserDefaults.standard.object(forKey: "token") as? String) ?? ""
    }
    
}

extension Languagee{
    
    var code:String{
        switch self {
        case .arabic: return "1"
        case .english: return "2"
        case .ukrainian: return "3"
        }
    }
    
    
}



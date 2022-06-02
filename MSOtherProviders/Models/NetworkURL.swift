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
        
    enum URLs{
        // MARK: - Private properties -
        //rootURL = "https://e4clinicdevapi.ekadsoft.org/api/"
        private static let rootURL = Constants.baseURL
        private static let otherProvider = "\(rootURL)OtherProvider/"
        private static let lookup = "\(rootURL)Lookup/"
        
        
        // Lookup/
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
    }
    
    enum URLTypes {
        case otherProviderDashboard(MSOPServicesRequest)
        case searchServiceListForPatient(MSOPServicesRequest)
        case ePrescriptions(EPrescriptionRequest)
        case otherProviders(OPRequest)
        case availableCountries
    }
    
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
        }
    }
    
    // MARK: - method -
    var method:HTTPMethod{
        switch self.type {
        case .otherProviderDashboard(_), .availableCountries :
            return .get
        case
                .searchServiceListForPatient(_),
                .ePrescriptions(_),
                .otherProviders(_):
            return .post
        }
    }
    
    // MARK: - params -
    var params:[String:Any]?{
        switch self.type {
        case
                .otherProviderDashboard(let msOPSRequest),
                .searchServiceListForPatient(let msOPSRequest):
            return msOPSRequest.dictionary
        case .ePrescriptions(let epRequest):
            return epRequest.dictionary
        case .otherProviders(let opRequest):
            return opRequest.dictionary
        case .availableCountries:
            return nil
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
                .availableCountries:
            return .authHeaderIfLogin
        }
    }
    
    // MARK: - header -
    var encoding:ParameterEncoding{
        switch self.type {
        case .otherProviderDashboard(_):
            return URLEncoding.default
        case
                .searchServiceListForPatient(_),
                .ePrescriptions(_),
                .otherProviders(_),
                .availableCountries:
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


extension String {
    func ifBlank(use string: String) -> String {
        isBlank ? string : self
    }
    
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var trimming: String? {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
        
}

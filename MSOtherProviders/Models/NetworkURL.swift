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
        
    enum URLTypes {
        case otherProviderDashboard(MSOPServicesRequest)
        case searchServiceListForPatient(MSOPServicesRequest)
    }
    
    enum URLs{
        // MARK: - Private properties -
        private static let rootURL = Constants.baseURL
        private static let otherProvider = "\(rootURL)OtherProvider/"
        

        // MARK: - public properties -
        public static let baseURLImage = "https://e4clinicdevapi.ekadsoft.org/"
        public static let otherProviderDashboard:String =
            "\(otherProvider)GetDashBoard"
        
        public static let searchServiceListForPatient:String =
            "\(otherProvider)SearchServiceListForPatient"
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
        switch self.type {
        case .otherProviderDashboard(_):
            if let testingPath = testingPath { return URL(fileURLWithPath: testingPath) }
            let urlString = "\(URLs.otherProviderDashboard)"
            return URL(string: urlString)
        case .searchServiceListForPatient(_):
            if let testingPath = testingPath { return URL(fileURLWithPath: testingPath) }
            let urlString = "\(URLs.searchServiceListForPatient)"
            return URL(string: urlString)
        }
    }
    
    // MARK: - method -
    var method:HTTPMethod{
        switch self.type {
        case .otherProviderDashboard(_):
            return .get
        case .searchServiceListForPatient(_):
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
        }
    }
    
    
    
    // MARK: - header -
    var  header:HTTPHeaders?{
        switch self.type {
        case .otherProviderDashboard(_), .searchServiceListForPatient(_):
            return .authHeaderIfLogin
        }
    }
    
    // MARK: - header -
    var encoding:ParameterEncoding{
        switch self.type {
        case .otherProviderDashboard(_):
            return URLEncoding.default
        case .searchServiceListForPatient(_):
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

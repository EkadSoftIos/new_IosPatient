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
        case otherProviderDashboard(MSType)
    }
    
    enum URLs{
        private static let rootURL = Constants.baseURL
        public static let baseURLImage = "https://e4clinicdevapi.ekadsoft.org/"

        public static let otherProviderDashboard:String =
            "\(rootURL)OtherProvider/GetDashBoard"
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
        }
    }
    
    // MARK: - method -
    var method:HTTPMethod{
        switch self.type {
        case .otherProviderDashboard(_):
            return .get
        }
    }
    
    // MARK: - params -
    var params:[String:Any]?{
        switch self.type {
        case .otherProviderDashboard(let msType):
            return [ "OtherProviderType":msType.rawValue ]
        }
    }
    
    
    
    // MARK: - header -
    var  header:HTTPHeaders?{
        let token = UserDefaults.standard.object(forKey: "token") as! String
        switch self.type {
        case .otherProviderDashboard(_):
            return [
                "Accept":"application/json",
                "Content-Type":"application/json",
                "Authorization":"Bearer \(token)",
                "lang": Languagee.language.code
            ]
        }
    }
    
    // MARK: - header -
    var encoding:ParameterEncoding{
        switch self.type {
        case .otherProviderDashboard(_):
            return URLEncoding.default
        }
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

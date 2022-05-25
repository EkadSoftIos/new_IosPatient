//
//  URLs.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Alamofire
import Foundation

class NetworkURL{
        
    enum URLTypes {
        case providerDashboard(MSType)
    }
    
    enum URLs{
        private static let rootURL = Constants.baseURL
        public static let baseURLImage = "https://e4clinicdevapi.ekadsoft.org/"

        public static let providerDashboard:String =
            "\(rootURL)OtherProvider/GetDashBoard"
    }
    
    // MARK: - Private properties -
    private let type:URLTypes
    private let testingPath:String
    
    
    init(_ type:URLTypes, testingPath:String = "") {
        self.type = type
        self.testingPath = testingPath
    }
    
    
    // MARK: - url -
    var url:URL? {
        switch self.type {
        case .providerDashboard(let msType):
            let urlString = "\(URLs.providerDashboard)?OtherProviderType=\(msType.rawValue)"
            return testingPath.isEmpty ? URL(string: urlString):URL(fileURLWithPath: testingPath)
        }
    }
    
    // MARK: - method -
    var method:HTTPMethod{
        switch self.type {
        case .providerDashboard(_):
            return .get
        }
    }
    
    // MARK: - params -
    var params:[String:Any]?{
        switch self.type {
        case .providerDashboard(_):
            return nil
        }
    }
    
    // MARK: - header -
    var  header:HTTPHeaders?{
        let token = UserDefaults.standard.object(forKey: "token") as! String
        switch self.type {
        case .providerDashboard(_):
            return [ "Authorization":"Bearer \(token)" ]
        }
    }
    
    // MARK: - header -
    var encoding:ParameterEncoding{
        switch self.type {
        case .providerDashboard(_):
            return JSONEncoding.default
        }
    }
    
}

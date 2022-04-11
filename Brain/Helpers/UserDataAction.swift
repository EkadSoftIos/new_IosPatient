//
//  UserDataAction.swift
//  Naqilat Delivery
//
//  Created by mohab on 8/30/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    func asArray() throws -> [[String: Any]] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else {
            throw NSError()
        }
        return dictionary
    }
    
}

let userKey = "userDataCash"


struct UserDataActions {
    
    func getCurrentLanguage(){
        
    }
    
    static func cashUserModel(user: UserModel) ->Void {
        let userDictionary = try! user.asDictionary()
        
        UserDefaults.standard.set(userDictionary, forKey: userKey)
        
    }
    
    static func removeUserModel(){
        UserDefaults.standard.removeObject(forKey: userKey)
    }
    
    static func getDeviceUDID() -> String{
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static func HeaderForRequestWithToken() -> [String : String]?{
        if UserDefaults.standard.object(forKey: userKey) == nil {
            return nil
        }else{
            var Header = ["X-localization": Language.currentLanguage()]
            if let token = UserDataActions.getToken(){
                Header["Authorization"] = "Bearer \(token)"
            }
            
            return Header
        }
    }
    
    static func getToken() -> String? {
        
        guard let userModel = UserDataActions.getUserModel() else {
            return nil
        }
        
       return userModel.jwt
    }
    
    
    static func getUserModel() -> UserModel?
    {
        if  let cashedData = UserDefaults.standard.object(forKey: userKey) as? [String : Any]
        {
            let data = try! JSONSerialization.data(withJSONObject: cashedData, options: .prettyPrinted)
            
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(UserModel.self, from: data)
                return user
            } catch {
                return nil
            }
            
        }
        
        return nil
    }
    
    static func sendQuery() -> URLEncoding {
        return URLEncoding(destination: .queryString)
    }
    
    
}

class Language {
    class func currentLanguage() -> String {
        let def = UserDefaults.standard
        let langs = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        
        return firstLang
    }
    
    class func setAppLanguage(lang: String) {
        let def = UserDefaults.standard
        def.removeObject(forKey: "AppleLanguages")
        def.set([lang], forKey: "AppleLanguages")
        def.synchronize()
    }
    
    class func isEnglish()->Bool {
        if currentLanguage().contains("en") || currentLanguage().contains("EN"){
            return true
        }else{
            return false
        }
    }
    
}


import Foundation

struct UserModel: Codable /*,CodableInit*/{
    let id: Int
    let name, mobile, email ,address: String
    let image: String
    let jwt: String
    
}

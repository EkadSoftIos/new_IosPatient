//
//  MSOPServicesRequest.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/29/22.
//

import Foundation


enum MSType: Int, Codable {
    case labs = 1
    case rays
}

struct MSOPServicesRequest:Codable {
    
    var type:MSType
    var searchText:String? = nil
    var branchId:String? = nil
    var opTypeFk:String? = nil
    var serviceTypeFk:String? = nil
    var pageNum:Int? = nil
    var rowNum:Int = 10
    
    enum CodingKeys: String, CodingKey {
        case rowNum = "RowNum"
        case pageNum = "PageNum"
        case searchText = "NameLike"
        case type = "OtherProviderType"
        case serviceTypeFk = "ServiceTypeFk"
        case opTypeFk = "OtherProviderTypeFk"
        case branchId = "OtherProviderBranchId"
    }
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Encodable {
    var asJSON: String? {
        guard let dic = self.dictionary
              , let jsonData = try? JSONSerialization.data(withJSONObject: dic,
                                                           options: .prettyPrinted)
        else { return nil }
        return String(data: jsonData, encoding: String.Encoding.utf8)
    }
}

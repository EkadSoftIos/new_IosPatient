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
    
    var type:MSType? = nil
    var opTypeFk:MSType? = nil
    var searchText:String? = nil
    
    var branchId:Int? = nil
    var serviceTypeFk:Int? = nil
    
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

extension MSType{

    var btnName:String{
        switch self {
        case .labs: return "Labs".localized
        case .rays: return "Rays".localized
        }
    }
    
    var searchResultText:String{
        switch self {
        case .labs: return "Tests".localized
        case .rays: return "Rays".localized
        }
    }
    
    var msImageNamed:String{
        switch self {
        case .labs: return "microscope"
        case .rays: return "XRayskeleton"
        }
    }
    
    var msPreRequest:String{
        switch self {
        case .labs: return "Tests Pre-Request".localized
        case .rays: return "Rays Pre-Request".localized
        }
    }
    
    var msSummary:String{
        switch self {
        case .labs: return "Tests Summary".localized
        case .rays: return "Rays Summary".localized
        }
    }
    
    var opProfileTitle:String{
        switch self {
        case .labs: return "Lab Profile".localized
        case .rays: return "Center Profile".localized
        }
    }
    
    var opListTitle:String{
        switch self {
        case .labs: return "Labs".localized
        case .rays: return "Centers".localized
        }
    }
    
    var opsDashboardTitle:String{
        switch self {
        case .labs: return "Labs".localized
        case .rays: return "X-Rays".localized
        }
    }
    
    var msOPsDashboardBtnTitle:String{
        switch self {
        case .labs: return "Find Tests".localized
        case .rays: return "Find Rays".localized
        }
    }
    
    var msSearchPlaceholder:String{
        switch self {
        case .labs: return "Search by test name".localized
        case .rays: return "Search by rays name".localized
        }
    }
    
    var searchOPMSTitle:String{
        switch self {
        case .labs: return "Labs Search".localized
        case .rays: return "Rays Search".localized
        }
    }
    
    var findServicesBtnTitle:String{
        switch self {
        case .labs: return "Find Labs".localized
        case .rays: return "Find Centers".localized
        }
    }
}

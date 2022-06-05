//
//  OPBranchDetailsReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/4/22.
//

import Foundation


struct OPBranchDetailsRequest:Codable {
    
    var branchId:Int? = nil
    var serviceIdList:[Int]? = nil
    
    enum CodingKeys: String, CodingKey {
        case serviceIdList = "ServiceList"
        case branchId = "OtherProviderBranchId"
    }
    
}

// MARK: - OPBranchDetailsReponse
struct OPBranchDetailsReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: OPBranchDetails
}

// MARK: - Message
struct OPBranchDetails: Codable {
    let otherProviderBranchID: Int
    let branchNameLocalized, otherProviderNameLocalized, otherProviderImage: String
    let otherProviderID: Int
    let branchFullAddress: String
    let servicePriceList: [ServicePriceList]?

    enum CodingKeys: String, CodingKey {
        case otherProviderBranchID = "otherProviderBranchId"
        case branchNameLocalized = "branchName_Localized"
        case otherProviderNameLocalized = "otherProviderName_Localized"
        case otherProviderImage
        case otherProviderID = "otherProviderId"
        case branchFullAddress, servicePriceList
    }
}

// MARK: - ServicePriceList
struct ServicePriceList: Codable {
    let serviceFk, otherProviderTypeFk, otherProviderBranchServiceID, commessionNetValue: Int
    let price, priceAfterDiscount: Int
    let conditionsList: [String]
    let serviceNameLocalized: String

    enum CodingKeys: String, CodingKey {
        case serviceFk, otherProviderTypeFk
        case otherProviderBranchServiceID = "otherProviderBranchServiceId"
        case commessionNetValue, price, priceAfterDiscount
        case conditionsList = "conditions_list"
        case serviceNameLocalized = "serviceName_Localized"
    }
}

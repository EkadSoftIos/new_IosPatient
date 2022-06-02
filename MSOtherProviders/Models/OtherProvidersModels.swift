//
//  OtherProvidersModels.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import Foundation

enum SortType: Int, Codable, CaseIterable{
    case highestDiscount = 1
    case lowestDiscount
    case lowToHighPrice
    case highToLowPrice
}

struct OPRequest:Codable {
    
    var latitude:Double? = nil
    var longitude:Double? = nil
    var distance:Double? = nil
    
    
    var countryfk:Int? = nil
    var cityFk:Int? = nil
    var areaFk:Int? = nil
    
    var sortType:SortType? = nil
    
    var nameLike:String? = nil
    var providerType:MSType? = nil
    var serviceIdList:[Int]? = nil
    var pageNum:Int? = nil
    var rowNum:Int = 10
    
    enum CodingKeys: String, CodingKey {
        case distance, sortType
        case nameLike = "NameLike"
        case areaFk = "AreaFk"
        case cityFk = "CityFk"
        case countryfk = "Countryfk"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case rowNum = "RowNum"
        case pageNum = "PageNum"
        case providerType = "ProviderType"
        case serviceIdList = "serviceIdList"
    }
    
}

// MARK: - OPSReponse
struct OPsReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: [OtherProviderBranch]
}

// MARK: - Message
struct OtherProviderBranch: Codable {
    let otherProviderBranchID: Int
    let branchNameLocalized, otherProviderNameLocalized, otherProviderImage: String
    let otherProviderID, avaliableCount:Int
    let priceBefore, priceAfter: Double
    let discountPercentage: Double
    let distance: Int
    let brancheLat, brancheLong: String

    enum CodingKeys: String, CodingKey {
        case otherProviderBranchID = "otherProviderBranchId"
        case branchNameLocalized = "branchName_Localized"
        case otherProviderNameLocalized = "otherProviderName_Localized"
        case otherProviderImage
        case otherProviderID = "otherProviderId"
        case avaliableCount, priceBefore, priceAfter, discountPercentage, distance
        case brancheLat = "branche_lat"
        case brancheLong = "branche_long"
    }
}

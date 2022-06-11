//
//  STListReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/6/22.
//

import Foundation


// MARK: - STListReponse
struct STListReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let serviceTypeList: [ServiceType]    
    
    enum CodingKeys: String, CodingKey {
        case serviceTypeList = "message"
        case successtate, errormessage
    }
    
}

// MARK: - Message
struct ServiceType: Codable {
    let serviceTypeID: Int
    let serviceTypeNameLocalized: String

    enum CodingKeys: String, CodingKey {
        case serviceTypeID = "serviceTypeId"
        case serviceTypeNameLocalized = "serviceTypeName_Localized"
    }
}

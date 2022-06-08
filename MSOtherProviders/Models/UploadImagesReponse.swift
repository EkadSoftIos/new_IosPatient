//
//  UploadImagesReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import Foundation

//{
//    "successtate": 200,
//    "errormessage": "",
//    "message": [
//        "Upload/reduced_20220607125617230961Screen Shot 2022-06-06 at 10.23.28 AM.png",
//        "Upload/reduced_20220607125617503962Screen Shot 2022-06-06 at 10.23.35 AM.png"
//    ]
//}

// MARK: - UploadImagesReponse
struct UPImagesReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let filePathList: [String]
    
    enum CodingKeys: String, CodingKey {
        case successtate, errormessage
        case filePathList = "message"
    }
}

// MARK: - UploadPrescriptionFilesReponse
struct UPFilesReponse: Codable {
    let successtate: Int
    let errormessage, message: String?
}

//{
//    "FilePathList":[
//        "Upload/reduced_20220523142248180961jefmutwoumfile.png"
//    ],
//    "ProviderType":1
//}

struct UPFilesRequest:Codable {
    
    var type:MSType? = nil
    var filePathList:[String]? = nil
    
    enum CodingKeys: String, CodingKey {
        case type = "ProviderType"
        case filePathList = "FilePathList"
    }
    
}

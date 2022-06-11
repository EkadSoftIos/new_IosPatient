//
//  AddNewOrder.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/7/22.
//

import Foundation


//{
//    "successtate": 200,
//    "errormessage": "",
//    "message": {
//        "successMessage": "تم الحفظ بنجاح",
//        "bookingNumber": "2206070000055",
//        "serviceBookingId": 10056,
//        "urlToCreateQRCode": "https://e4clinicdev.ekadsoft.org/Home/serviceOrderDetails?PID=HlgxtExcnujQfdqw81/bnSkmzAnj6gwt/NO1JaqleNc="
//    }
//}

// MARK: - AddOrderReponse
struct AddOrderReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let orderInfo: OrderInfo
    
    enum CodingKeys: String, CodingKey {
        case orderInfo = "message"
        case successtate, errormessage
    }
}

// MARK: - Message
struct OrderInfo: Codable {
    let successMessage, bookingNumber: String
    let serviceBookingID: Int
    let urlToCreateQRCode: String

    enum CodingKeys: String, CodingKey {
        case successMessage, bookingNumber
        case serviceBookingID = "serviceBookingId"
        case urlToCreateQRCode
    }
}
//
//{
//    "DoctorName":"Arabic Name  حليمه رضا",
//    "OtherProviderBranchFk":1,
//    "PrescriptionId":57,
//    "ProviderType":1,
//    "FilePathList":[
//       "Upload/reduced_20220607125617230961Screen Shot 2022-06-06 at 10.23.28 AM.png",
//       "Upload/reduced_20220607125617503962Screen Shot 2022-06-06 at 10.23.35 AM.png"
//    ],
//    "ServiceBookingDetails":[
//       {
//            "CommessionValue":7.0,
//            "OtherProviderBranchServiceFk":2,
//            "Price":200.0,
//            "PriceAfterDiscount":180.0
//       },
//       {
//           "CommessionValue":20.0,
//           "OtherProviderBranchServiceFk":5,
//           "Price":500.0,
//           "PriceAfterDiscount":400.0
//       }
//   ]
//}

struct AddOrderRequest:Codable {
    
    var type:MSType? = nil
    var opBranchId:Int? = nil
    var doctorName:String? = nil
    var prescriptionId:Int? = nil
    var filePathList:[String]? = nil
    var serviceBookingDetails:[MSOrderRequest]? = nil
    
    enum CodingKeys: String, CodingKey {
        case type = "ProviderType"
        case filePathList = "FilePathList"
        case doctorName = "DoctorName"
        case opBranchId = "OtherProviderBranchFk"
        case prescriptionId = "PrescriptionId"
        case serviceBookingDetails = "ServiceBookingDetails"
    }
    
}

//{
//           "CommessionValue":20.0,
//           "OtherProviderBranchServiceFk":5,
//           "Price":500.0,
//           "PriceAfterDiscount":400.0
//       }

struct MSOrderRequest:Codable {

    var serviceId:Int? = nil
    var price:Double? = nil
    var priceAfterDiscount:Double? = nil
    var commessionValue:Double? = nil

    
    enum CodingKeys: String, CodingKey {
        case price = "Price"
        case commessionValue = "CommessionValue"
        case priceAfterDiscount = "PriceAfterDiscount"
        case serviceId = "OtherProviderBranchServiceFk"
    }
}

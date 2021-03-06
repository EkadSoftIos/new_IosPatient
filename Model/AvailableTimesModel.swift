//
//  AvailableTimesModel.swift
//  E4 Patient
//
//  Created by Nada on 8/27/21.
//

import Foundation

struct AvailableTimesModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [AvailableTimesData]?
}
struct AvailableTimesData: Codable {
    let employeeWorkingHourID, businessProviderEmployeeFk, weekDayFk: Int?
    let nameofday: String?
    let acceptBookingTypeFk, overBookingType: Int?
    let startTime, endTime: String?
    let reservationType, consultationServiceFk, numberOrSlot, overBooking: Int?
    let fees, secondFees: Int
    let createDate: String?
    let isActive: Bool?
    let deleted: Bool?
    let businessProviderBranchFk: Int?
    let availableTime: [AvailableTime]?
    let leftBooking, overBookingNumber: Int?
    let allowSecondConsultaion: Bool?

    enum CodingKeys: String, CodingKey {
        case employeeWorkingHourID = "employeeWorkingHourId"
        case businessProviderEmployeeFk, weekDayFk, nameofday, acceptBookingTypeFk, overBookingType, startTime, endTime, reservationType, consultationServiceFk, numberOrSlot, overBooking, fees, secondFees, createDate, isActive, deleted, businessProviderBranchFk, availableTime, leftBooking, overBookingNumber, allowSecondConsultaion
    }
}
struct AvailableTime: Codable {
    let startTime, endTime: String?
    let isAvilable: Bool?
    let fees: Int?
}

//
//  NotificationListModel.swift
//  E4Doctor
//
//  Created by Nada on 11/27/21.
//

import Foundation

struct NotificationListModel: Codable {
    let successtate: Int?
    let errormessage: String?
    let message: [NotificationListData]?
}

// MARK: - Message
struct NotificationListData: Codable {
    let userNotificationID: Int?
    let loginUserID: String?
    let fromUserImageURL: String?
    let fromUserName: String?
    let notificationTitle: String?
    let notificationDetails, notificationDetailsMessage, notificationDate: String?
    let notificationType, userTypeID: Int?
    let isRead: Bool?
    let forDoctorID: Int?

    enum CodingKeys: String, CodingKey {
        case userNotificationID = "userNotificationId"
        case loginUserID = "loginUserId"
        case fromUserImageURL, fromUserName, notificationTitle, notificationDetails, notificationDetailsMessage, notificationDate, notificationType
        case userTypeID = "userTypeId"
        case isRead, forDoctorID
    }
}

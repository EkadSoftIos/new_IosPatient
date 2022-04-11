//
//  User.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import Foundation

struct User: Codable {
        let token: String
        let expiration: String
        let apiresponseresult: Apiresponseresult
    }

    // MARK: - Apiresponseresult
    struct Apiresponseresult: Codable {
        let successtate: Int
        let errormessage: String
        let message: Message
    }

    // MARK: - Message
    struct Message: Codable {
        let roleLst: [String]
        //let token: String?
        let doctorID, patientID, medicalRepID, businessProviderFk: Int

        enum CodingKeys: String, CodingKey {
            case roleLst/*, token*/
            case doctorID = "doctor_id"
            case patientID = "patient_id"
            case medicalRepID = "medicalRep_id"
            case businessProviderFk
        }
    }


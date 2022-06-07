//
//  SearchMSReponse.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/30/22.
//

import Foundation


// MARK: - MSReponse
struct MSReponse: Codable {
    let successtate: Int
    let errormessage: String?
    let message: [Service]
}

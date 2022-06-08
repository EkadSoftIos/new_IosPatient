//
//  NetworkError.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 5/24/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case errorConnection
    case invalidData
    case custom(String)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid url request".localized
        case .unableToComplete:
            return "Unable to complete the task".localized
        case .invalidResponse:
            return "Error in response".localized
        case .errorConnection:
            return "Invalid data".localized
        case .invalidData:
            return "Please connect to the internet and try again.".localized
        case .custom(let error):
            return error
        }
    }
}

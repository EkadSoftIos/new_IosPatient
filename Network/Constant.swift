//
//  Constants.swift
//  ytsInCode
//
//  Created by zyad galal on 9/19/19.
//  Copyright © 2019 zyad galal. All rights reserved.
//

import Foundation

struct Constants {
    //test
//    static let baseURL = "https://e4clinictestapi.ekadsoft.org/api/" //->
//    static let baseURLImage = "https://e4clinictestapi.ekadsoft.org/"
    //dev
    static let baseURL = "https://e4clinicdevapi.ekadsoft.org/api/"
    static let baseURLImage = "https://e4clinicdevapi.ekadsoft.org/"
    
    static let languageSelected = "languageSelected"
    static let appleLanguagesKey = "AppleLanguages"
    static let launchedBefore = "launchedBefore"

    
//////////
    
//    static let baseURL = "http://23.250.115.98:2072/api/"
//    static let baseURLImage = "http://23.250.115.98:2072/"
//    static let baseURLImage = "https://e4clinictestapi.ekadsoft.org/"  //->
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case apiRapidKey = "X-RapidAPI-Key"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded; charset=utf-8"
    case accept = "application/json"
    case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    case apiRapidKey = "324ca5747dmsha5c600be9060e86p15312fjsnfd3116fb3ff1"
}

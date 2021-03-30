//
//  Url.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/12.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import Foundation

class Url {
    
    static let API_URL = "https://bizq.kr" // API URL
    static let API_PORT = ":8443/" // API PORT
    
    static let WEBVEW_URL = "https://vring.org" // WebView URL
    static let WEBVEW_PORT = ":8900/" // WebVoew PORT
    
    /**
     * API URL
     *
     * @return URL
     */
    static func getApiUrl(_ subUrl: String) -> String {
        return "\(API_URL)\(API_PORT)\(subUrl)"
    }
    
    /**
     * WebView URL
     *
     * @return URL
     */
    static func getWebViewUrl(_ subUrl: String) -> String {
        return "\(WEBVEW_URL)\(WEBVEW_PORT)\(subUrl)"
    }
}

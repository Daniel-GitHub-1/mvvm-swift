//
//  Url.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/12.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import Foundation

class Url {
    
    static let BASE_URL = "https://bizq.kr" // 기본 URL
    static let BASE_PORT = ":8443/" // 기본 PORT
    
    /**
     * 메인 URL
     *
     * @return URL
     */
    static func getUrl(_ subUrl: String) -> String {
        return "\(BASE_URL)\(BASE_PORT)\(subUrl)"
    }
}

//
//  Enum.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

/**
 * Enum.swift
 *
 * @description Enum
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class Enum {
    // 실패 이유
    enum GetFailureReason: Int, Error {
        case NOT_CONNECTED = 0
        case NONE = 200
        case UN_AUTHORIZED = 401
        case NOT_FOUND = 404
    }
    
    // 디바이스
    enum Devices: String {
        case iPhone = "iPhone"
        case iPad = "iPad"
        case iMac = "iMac"
        case MacBook = "MacBook"
    }
}

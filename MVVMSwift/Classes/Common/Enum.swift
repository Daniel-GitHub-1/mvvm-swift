//
//  Enum.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
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

    /**
     * 디바이스
     *
     * @return String
     */
    enum Devices: String {
        case IPHONE = "iPhone"
        case IPAD = "iPad"
        case IMAC = "iMac"
        case MACBOOK = "MacBook"
    }
    
    /**
     * Loading 타입
     *
     * @return Int
     */
    enum LoadingType: Int {
        case NONE = 0
        case LOAD = 1
        case SAVE = 2
        case DELETE = 3
    }
}

//
//  LogUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/09.
//

/**
 * LogUtil.swift
 *
 * @description 로그 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class LogUtil {
    static let DEBUG = true
    
    static func d(msg: String) {
        if DEBUG {
            print(msg)
        }
    }
}


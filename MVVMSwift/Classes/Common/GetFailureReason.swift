//
//  GetFailureReason.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

/**
 * 실패 이유
 *
 * @return Int, Error
 */
enum GetFailureReason: Int, Swift.Error {
    case NOT_CONNECTED = 0
    case NONE = 200
    case UN_AUTHORIZED = 401
    case NOT_FOUND = 404
}

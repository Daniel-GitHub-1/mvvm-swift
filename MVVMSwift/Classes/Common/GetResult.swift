//
//  GetResult.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

/**
 * 결과
 *
 * @return Int, Error
 */
enum GetResult: Int, Swift.Error {
    case NONE = 0
    case EMPTY_ID = 1
    case INVALID_ID = 2
    case LENGTH_ID = 3
    case EMPTY_PW = 4
    case INVALID_PW = 5
    case LENGTH_PW = 6
}

//
//  Enum.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

class Enum {
    enum GetFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
}

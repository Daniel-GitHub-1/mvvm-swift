//
//  BaseService.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/12.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

@_exported import Foundation

// RxSwift
@_exported import RxCocoa
@_exported import RxSwift
@_exported import RxViewController

// Communication
@_exported import Alamofire

class BaseService {
    var tag = "" // 디버그 태그
    let headers: HTTPHeaders = [Define.AUTH_TOKEN:Define.AUTH]

    /**
     * 서비스 초기화
     *
     * @param tag 디버그 태그
     */
    func initService(_ tag: String) {
        self.tag = tag
    }

    /**
     * 디버그
     *
     * @param msg 메시지
     */
    func d(_ msg: String) {
        LogUtil.sharedInstance.d("\(self.tag) \(msg)")
    }
    
    /**
     * 디버그 (유니코드 > 한글)
     *
     * @param msg 메시지
     */
    func koLog(_ msg: String) {
        d(LogUtil.sharedInstance.koLog("\(self.tag) \(msg)"))
    }
}

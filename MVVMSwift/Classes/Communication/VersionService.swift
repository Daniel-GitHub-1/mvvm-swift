//
//  VersionService.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import Foundation

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// Communication
import Alamofire

class VersionService: BaseService {
    private let versionUrl = "" // Version API URL
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initService("[VersionService]")
    }
    
    /**
     * 버전
     *
     * @param parameters 파라미터
     * @returns Observable<Version>
     */
    func getVersion(_ parameters: Parameters) -> Observable<Version> {
        d("getVersion() >> Start !!!")
        d("getVersion() >> versionUrl: \(versionUrl)")
        d("getVersion() >> parameters: \(parameters)")

        
        return Observable.create {
            observer -> Disposable in
            AF.request(self.versionUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: self.headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    self.d("getVersion() >> response: \(response)")
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? GetFailureReason.NOT_FOUND)
                            return
                        }
                        do {
                            let results = try JSONDecoder().decode(Version.self,
                                                                   from: data)
                        self.d("getVersion() >> results: \(results)")
                            observer.onNext(results)
                        } catch {
                            self.d("getVersion() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                            
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = GetFailureReason(rawValue: statusCode) {
                            self.d("getVersion() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        self.d("getVersion() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

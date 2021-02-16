//
//  VersionRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//


import Foundation
import RxSwift
import Alamofire

let versionUrl = "\(Define.BASE_URL)apis/v1/vring/version" // API URL

/**
 * VersionRemoteDataSource.swift
 *
 * @description 버전 데이터 소스
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class VersionRemoteDataSource {
    var TAG = "[VersionRemoteDataSource]" // 디버그 태그
    /**
     * 버전
     *
     * @param parameters 파라미터
     * @returns Observable<VersionEntity>
     */
    func getVersion(parameters: Parameters) -> Observable<VersionEntity> {
        print("\(self.TAG) getVersion() >> Start !!!")
        print("\(self.TAG) getVersion() >> versionUrl: \(versionUrl)")
        print("\(self.TAG) getVersion() >> parameters: \(parameters)")
        
        return Observable.create {
            observer -> Disposable in
            AF.request(versionUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    print("\(self.TAG) getVersion() >> response: \(response)")
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? Enum.GetFailureReason.NOT_FOUND)
                            return
                        }
                        do {
                            let version = try JSONDecoder().decode(VersionEntity.self,
                                                                   from: data)
                            print("\(self.TAG) getVersion() >> version: \(version)")
                            observer.onNext(version)
                        } catch {
                            print("\(self.TAG) getVersion() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                           
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = Enum.GetFailureReason(rawValue: statusCode) {
                            print("\(self.TAG) getVersion() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        print("\(self.TAG) getVersion() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

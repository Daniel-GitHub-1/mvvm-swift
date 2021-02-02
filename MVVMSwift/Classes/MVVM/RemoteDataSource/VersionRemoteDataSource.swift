//
//  VersionRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//


import Foundation
import RxSwift
import Alamofire

let versionUrl = "\(Define.BASE_URL)apis/v1/vring/version"

class VersionRemoteDataSource {
    var TAG = "[VersionRemoteDataSource]" // 디버그 태그
    
    func getVersion(params: Dictionary<String, Any>) -> Observable<VersionEntity> {
        print("getVersion() >> versionUrl: \(versionUrl)")
        return Observable.create {
            observer -> Disposable in
            AF.request(versionUrl,
                       method: .post,
                       parameters: params,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? Enum.GetFailureReason.notFound)
                            return
                        }
                        do {
                            let version = try JSONDecoder().decode(VersionEntity.self,
                                                                   from: data)
                            observer.onNext(version)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = Enum.GetFailureReason(rawValue: statusCode) {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

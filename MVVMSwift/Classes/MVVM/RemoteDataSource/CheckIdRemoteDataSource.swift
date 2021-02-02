//
//  CheckIdRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import Foundation
import RxSwift
import Alamofire

let checkIdUrl = "\(Define.BASE_URL)common/chk?app_type=1&tn=id&mem_id=zzz@gmail.com"

class CheckIdRemoteDataSource {
    var TAG = "[CheckIdRemoteDataSource]" // 디버그 태그

    func getDuplicateCheckId(parameters: Parameters) -> Observable<DefaultEntity> {
        print("getDuplicateCheckId() >> checkIdUrl: \(checkIdUrl)")
        print("getDuplicateCheckId() >> parameters: \(parameters)")
        return Observable.create {
            observer -> Disposable in
            AF.request(checkIdUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    print("getDuplicateCheckId() >> response: \(response)")
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? Enum.GetFailureReason.notFound)
                            return
                        }
                        print("getDuplicateCheckId() >> data: \(data)")
                        
                        do {
                            let results = try JSONDecoder().decode(DefaultEntity.self,
                                                                   from: data)
                            observer.onNext(results)
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

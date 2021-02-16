//
//  CheckIdRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import Foundation
import RxSwift
import Alamofire

let checkIdUrl = "\(Define.BASE_URL)common/chk?app_type=1&tn=id&mem_id=zzz@gmail.com" // API URL

/**
 * CheckIdRemoteDataSource.swift
 *
 * @description 아이디 중복 데이터 소스
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class CheckIdRemoteDataSource {
    var TAG = "[CheckIdRemoteDataSource]" // 디버그 태그
    /**
     * 아이디 중복 체크
     *
     * @param parameters 파라미터
     * @returns Observable<VersionEntity>
     */
    func getDuplicateCheckId(parameters: Parameters) -> Observable<DefaultEntity> {
        print("\(self.TAG) getDuplicateCheckId() >> Start !!!")
        print("\(self.TAG) getDuplicateCheckId() >> checkIdUrl: \(checkIdUrl)")
        print("\(self.TAG) getDuplicateCheckId() >> parameters: \(parameters)")
        
        return Observable.create {
            observer -> Disposable in
            AF.request(checkIdUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    print("\(self.TAG) getDuplicateCheckId() >> response: \(response)")
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? Enum.GetFailureReason.NOT_FOUND)
                            return
                        }
                        print("\(self.TAG) getDuplicateCheckId() >> data: \(data)")
                        
                        do {
                            let results = try JSONDecoder().decode(DefaultEntity.self,
                                                                   from: data)
                            print("\(self.TAG) getDuplicateCheckId() >> results: \(results)")
                            observer.onNext(results)
                        } catch {
                            print("\(self.TAG) getDuplicateCheckId() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = Enum.GetFailureReason(rawValue: statusCode) {
                            print("\(self.TAG) getDuplicateCheckId() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        print("\(self.TAG) getDuplicateCheckId() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

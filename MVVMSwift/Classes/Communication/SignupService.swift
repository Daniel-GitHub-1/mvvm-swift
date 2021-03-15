//
//  SignupService.swift
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

class SignupService: BaseService {
    private let checkIdUrl = "" // API URL
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initService("[SignupService]")
    }
    
    /**
     * 아이디 중복 체크
     *
     * @param parameters 파라미터
     * @returns Observable<Version>
     */
    func getDuplicateCheckId(_ parameters: Parameters) -> Observable<Default> {
       d("getDuplicateCheckId() >> Start !!!")
       d("getDuplicateCheckId() >> checkIdUrl: \(checkIdUrl)")
       d("getDuplicateCheckId() >> parameters: \(parameters)")
        
        
        return Observable.create {
            observer -> Disposable in
            AF.request(self.checkIdUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: self.headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    self.d("getDuplicateCheckId() >> response: \(response)")
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? GetFailureReason.NOT_FOUND)
                            return
                        }
                        self.d("getDuplicateCheckId() >> data: \(data)")
                        
                        do {
                            let results = try JSONDecoder().decode(Default.self,
                                                                   from: data)
                            self.d("getDuplicateCheckId() >> results: \(results)")
                            observer.onNext(results)
                        } catch {
                            self.d("getDuplicateCheckId() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = GetFailureReason(rawValue: statusCode) {
                            self.d("getDuplicateCheckId() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        self.d("getDuplicateCheckId() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}


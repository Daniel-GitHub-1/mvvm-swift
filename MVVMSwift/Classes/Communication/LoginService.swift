//
//  File.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

class LoginService: BaseService {
    private let loginUrl = Url.getApiUrl("/biz_login") // Login API URL
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initService("[LoginService]")
    }

    /**
     * 로그인 요청
     *
     * @param parameters 파라미터
     * @returns Observable<Login>
     */
    func getLogin(_ parameters: Parameters) -> Observable<Login> {
        d("getLogin() >> Start !!!")
        d("getLogin() >> loginUrl: \(loginUrl)")
        d("getLogin() >> parameters: \(parameters)")
        
        return Observable.create {
            observer -> Disposable in
            AF.request(self.loginUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: self.headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    self.d("getLogin() >> response: \(response)")
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? GetFailureReason.NOT_FOUND)
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(Login.self,
                                                                  from: data)
                            self.d("getLogin() >> result: \(result)")
                            observer.onNext(result)
                        } catch {
                            self.d("getLogin() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = GetFailureReason(rawValue: statusCode) {
                            self.d("getLogin() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        self.d("getLogin() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

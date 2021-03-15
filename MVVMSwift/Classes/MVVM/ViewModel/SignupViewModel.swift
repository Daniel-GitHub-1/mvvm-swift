//
//  SignupViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

class SignupViewModel: BaseViewModel {

    private let signupService = SignupService() // 회원가입 API 서비스

    let id = BehaviorSubject<String>(value: "") // 아이디
    let pw = BehaviorSubject<String>(value: "") // 비밀번호
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[SignupViewModel]")
    }

    /**
     * 회원가입 유효성 검사
     *
     * @param id 아이디
     * @param pw 비밀번호
     * @return Observable<Bool>
     */
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(id, pw).map {
            userid, userpw in
            var results = ValidUtil.isValidId(userid)
            if !results.0 {
                return false
            }
            results = ValidUtil.isValidPw(userpw)
            if !results.0 {
                return false
            }
            return true
        }
    }
    
    /**
     * 회원가입 유효성 검사
     *
     * @param id 아이디
     * @param pw 비밀번호
     * @return Observable<(Bool, GetResult)>
     */
    func isValid() -> Observable<(Bool, GetResult)> {
        return Observable.combineLatest(id, pw).map {
            userid, userpw in
            var results = ValidUtil.isValidId(userid)
            if !results.0 {
                return (false, results.1)
            }
            results = ValidUtil.isValidPw(userpw)
            if !results.0 {
                return (false, results.1)
            }
            return (true, GetResult.NONE)
        }
    }
    
    /**
     * 회원가입 요청
     *
     * @param viewController UIViewController
     * @param parameters 파라미터
     * @returns onResult(Bool, Default, GetFailureReason)
     */
    func getDuplicateCheckId(_ viewController: UIViewController,
                             parameters: Parameters,
                             onResult: @escaping (Bool, Default, GetFailureReason) -> ()) {
        self.d("getDuplicateCheckId() >> parameters: \(parameters)")
        
        signupService
            .getDuplicateCheckId(parameters)
            .subscribe(
                onNext: { result in
                    onResult(true, result, GetFailureReason.NONE)
                    self.d("getDuplicateCheckId() >> result: \(result)")
                },
                onError: { error in
                    onResult(false, Default.init(),
                             error as? GetFailureReason ?? GetFailureReason.NONE)
                    self.d("getDuplicateCheckId() >> error: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}


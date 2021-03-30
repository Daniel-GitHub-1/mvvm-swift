//
//  LoginViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

class LoginViewModel: BaseViewModel {

    private let loginService = LoginService() // 로그인 API 서비스
    
    let id = BehaviorSubject<String>(value: "") // 아이디
    let pw = BehaviorSubject<String>(value: "") // 비밀번호
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[LoginViewModel]")
    }
    
    /**
     * 로그인 유효성 검사
     *
     * @param id 아이디
     * @param pw 비밀번호
     * @return Observable<Bool>
     */
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(id, pw).map {
            userid, userpw in
            if !ValidUtil.isValidId(userid).0 {
                return false
            }
            if !ValidUtil.isValidPw(userpw).0 {
                return false
            }
            return true
        }
    }
    
    /**
     * 로그인 유효성 검사
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
     * 로그인 정보
     *
     * @param viewController UIViewController
     * @param parameters 파라미터
     * @returns completion(Bool, Login, GetFailureReason)
     */
    func getLogin(_ viewController: UIViewController,
                  parameters: Parameters,
                  completion: @escaping (Bool, Login, GetFailureReason) -> ()) {
        self.d("getLogin() >> parameters: \(parameters)")
        
        loginService
            .getLogin(parameters)
            .subscribe(
                onNext: { result in
                    completion(true, result, GetFailureReason.NONE)
                    self.d("getLogin() >> result: \(result)")
                },
                onError: { error in
                    completion(false, Login.init(),
                             error as? GetFailureReason ?? GetFailureReason.NONE)
                    self.d("getLogin() >> error: \(error)")
                }
            )
            .disposed(by: self.disposeBag)
    }
}

//
//  IntroViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

class IntroViewModel: BaseViewModel {
    private let loginService = LoginService() // 로그인 API 서비스
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[IntroViewModel]")
    }
 
    /**
     * 로그인 정보
     *
     * @param viewController UIViewController
     * @param parameters 파라미터
     * @returns completion(Bool, Version, GetFailureReason)
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

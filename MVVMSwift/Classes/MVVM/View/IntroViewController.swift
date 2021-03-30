//
//  IntroViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

//import UIKit
//
//// RxSwift
//import RxCocoa
//import RxSwift
//import RxViewController

class IntroViewController: BaseViewController {

    var viewModel = IntroViewModel() // 인트로 뷰 모델
    var loginViewModel = LoginViewModel() // 로그인 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 초기화
        initView()
        
        // 메인 뷰 컨드롤러 이동
        self.gotoViewController(name: Define.SB_NAME_MAIN,
                                withIdentifier: Define.VC_NAME_MAINVIEW,
                                of: MainViewController(),
                                animated: true) { (controller) in
            self.d("viewDidLoad() >> controller: \(controller)")
            controller.delegate = self
        }
        
        
//        // 로그인 확인
//        DispatchQueue
//            .main
//            .asyncAfter(deadline: .now() + 1.0) {
//                self.checkLogin()
//            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpHiddenNavigationBar()
    }
    
    // MARK: - Function
    
    /**
     * 뷰 초기화
     */
    private func initView() {
        // 뷰 컨트롤러 초기ㅏ화
        self.initViewController(self,
                                navTitle: "",
                                tag: "[\(getString("Intro"))]")
    }
    
    /**
     * 로그인 확인
     *
     * @param
     * @return
     */
    private func checkLogin() {
        
        // 아이디, 비밀번호 존재 확인
        guard !getId().isEmpty
                && !getPw().isEmpty else {
            // 로그인 뷰 컨트롤러 이동
            gotoLoginViewController()
            return
        }
        
        // 로딩 프로그레스바 시작
        startLoading()
        
        var parameters: Parameters = Parameters.init()
        parameters[Key.AUTH_TOKEN] = Define.AUTH_TOKEN
        parameters[Key.EMAIL] = getId()
        parameters[Key.PASSWD] = getPw()
        parameters[Key.LOGIN_TYPE] = 0
        parameters[Key.MODE] = Define.AUTH
        self.d("checkLogin() >> parameters: \(parameters)")

        // 로그인 요청
        viewModel.getLogin(self, parameters: parameters) { (success, results, msg) in
            self.d("checkLogin() >> success: \(success)")
            self.d("checkLogin() >> result: \(results.result)")
            self.d("checkLogin() >> results: \(results)")
            self.d("checkLogin() >> msg: \(msg)")
            
            // 로딩 프로그레스바 종료
            self.stopLoading()
            
            guard results.result else {
                // 로그인 뷰 컨트롤러 이동
                self.gotoLoginViewController()
                return
            }
            
            self.d("checkLogin() >> msg: \(results.msg)")
            self.d("checkLogin() >> muid: \(results.muid)")
            self.d("checkLogin() >> buid: \(results.buid)")
            self.d("checkLogin() >> bname: \(results.bname)")
            
            self.gotoViewController(name: Define.SB_NAME_MAIN,
                                    withIdentifier: Define.VC_NAME_MAINVIEW,
                                    of: MainViewController(),
                                    animated: true) { (controller) in
                self.d("checkLogin() >> controller: \(controller)")
                controller.delegate = self
            }
        }
    }
    
    /**
     * 로그인 뷰 컨트롤러 이동
     *
     * @param
     * @return
     */
    private func gotoLoginViewController() {
        gotoViewController(name: Define.SB_NAME_LOGIN,
                           withIdentifier: Define.VC_NAME_LOGINVIEW,
                           of: LoginViewController(),
                           animated: false) { (controller) in
            self.d("viewDidLoad() >> controller: \(controller)")
        }
    }
}

// MARK: - MainView Delegate

extension IntroViewController: MainViewDelegate {
    func MainViewDelegate(controller: MainViewController) {
        d("MainViewDelegate() >> controller: \(controller)")
    }
}

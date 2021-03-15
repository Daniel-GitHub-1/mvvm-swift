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

/**
 * IntroViewController.swift
 *
 * @description 인트로 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class IntroViewController: BaseViewController {

    var viewModel = IntroViewModel() // 인트로 뷰 모델
    var loginViewModel = LoginViewModel() // 로그인 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 컨트롤러 초기ㅏ화
        self.initViewController(IntroViewController.self,
                                navTitle: "",
                                tag: "[IntroViewController]")
        
        // 로그인 확인
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 1.0) {
                
                // 아이디, 비밀번호 존재 확인
                guard !self.getId().isEmpty
                        && !self.getPw().isEmpty else {
                    // 로그인 뷰 컨트롤러 이동
                    self.gotoLoginViewController()
                    return
                }
                
                // 로딩 프로그레스바 시작
                self.startLoading()
                
                var parameters: Parameters = Parameters.init()
                parameters[Key.AUTH_TOKEN] = Define.AUTH_TOKEN
                parameters[Key.EMAIL] = self.getId()
                parameters[Key.PASSWD] = self.getPw()
                parameters[Key.LOGIN_TYPE] = 0
                parameters[Key.MODE] = Define.AUTH
                self.d("viewDidLoad() >> parameters: \(parameters)")

                // 로그인 요청
                self.viewModel.getLogin(self, parameters: parameters) { (success, results, msg) in
                    self.d("viewDidLoad() >> success: \(success)")
                    self.d("viewDidLoad() >> result: \(results.result)")
                    self.d("viewDidLoad() >> results: \(results)")
                    self.d("viewDidLoad() >> msg: \(msg)")
                    
                    // 로딩 프로그레스바 종료
                    self.stopLoading()
                    
                    guard results.result else {
                        // 로그인 뷰 컨트롤러 이동
                        self.gotoLoginViewController()
                        return
                    }
                    
                    self.d("viewDidLoad() >> msg: \(results.msg)")
                    self.d("viewDidLoad() >> muid: \(results.muid)")
                    self.d("viewDidLoad() >> buid: \(results.buid)")
                    self.d("viewDidLoad() >> bname: \(results.bname)")
                    
                    self.gotoViewController(name: Define.SB_NAME_MAIN,
                                            withIdentifier: Define.VC_NAME_MAINVIEW,
                                            of: MainViewController(),
                                            animated: true) { (controller) in
                        self.d("viewDidLoad() >> controller: \(controller)")
                        controller.delegate = self
                    }
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpHiddenNavigationBar()
    }
    
    /**
     * 로그인 뷰 컨트롤러 이동
     *
     * @param
     * @return
     */
    func gotoLoginViewController() {
        self.gotoViewController(name: Define.SB_NAME_LOGIN,
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

//
//  LoginViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

import UIKit

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// Communication
import Alamofire

/**
 * LoginViewController.swift
 *
 * @description 로그인 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/22/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var tfId: UITextField? // 아이디 텍스트 필드
    @IBOutlet weak var tfPw: UITextField? // 비밀번호 텍스트 필드
    @IBOutlet weak var btnLogIn: UIButton? // 로그인 버튼

    private let viewModel = LoginViewModel() // 뷰 모델
    private let disposeBag = DisposeBag() // Observable 해제
    
    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 초기화
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpHiddenNavigationBar()
    }
    
    /**
     * 뷰 초기화
     */
    private func initView() {
        // 뷰 컨트롤러 초기ㅏ화
        initViewController(self,
                           navTitle: getString("Login"),
                           tag: "[\(getString("Login"))]")
        // 아이디
        tfId?.placeholder = getString("InputId")
        
        // 비밀번호
        tfPw?.placeholder = getString("InputPw")
        tfPw?.isSecureTextEntry = true
        
        // ViewModel 바인딩
        binding()
        
        // 폰트 설정
        tfId?.font = self.getRobotoRegular(15)
        tfPw?.font = self.getRobotoRegular(15)
    }
    
    // MARK: - Action
    
    /**
     * 로그인 액션 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionLogin(sender: UIButton) {
        d("actionLogin() >> Start !!!")

        // 로딩 프로그레스바 시작
        startLoading()
        
        let id = tfId?.text ?? ""
        d("actionLogin() >> id: \(String(describing: id))")
        
        let pw = tfPw?.text ?? ""
        d("actionLogin() >> pw: \(String(describing: pw))")
        
        // 로그인 요청 파라미터
        var parameters: Parameters = Parameters.init()
        parameters[Key.AUTH_TOKEN] = Define.AUTH_TOKEN
        parameters[Key.EMAIL] = id
        parameters[Key.PASSWD] = pw
        parameters[Key.LOGIN_TYPE] = 0
        parameters[Key.MODE] = Define.AUTH
        d("actionLogin() >> parameters: \(parameters)")
        
        // 로그인 요청
        viewModel.getLogin(self, parameters: parameters) { (success, data, error) in
            self.d("actionLogin() >> success: \(success)")
            self.d("actionLogin() >> data: \(data)")
            self.d("actionLogin() >> result: \(data.result)")
            self.d("actionLogin() >> error: \(error)")
            
            // 로딩 프로그레스바 종료
            self.stopLoading()
            
            guard data.result else { return }
            
            self.d("actionLogin() >> msg: \(data.msg)")
            self.d("actionLogin() >> muid: \(data.muid)")
            self.d("actionLogin() >> buid: \(data.buid)")
            self.d("actionLogin() >> bname: \(data.bname)")
            
            let savedId = self.setId(id)
            self.d("actionLogin() >> savedId: \(savedId)")
            let savedPw = self.setPw(pw)
            self.d("actionLogin() >> savedPw: \(savedPw)")
            
            self.gotoViewController(name: Define.SB_NAME_MAIN,
                                    withIdentifier: Define.VC_NAME_MAINVIEW,
                                    of: MainViewController(),
                                    animated: true) { (controller) in
                self.d("viewDidLoad() >> controller: \(controller)")
                controller.delegate = self
            }
        }
    }
    
    // MARK: - Function
    
    /**
     * ViewModel 바인딩
     */
    private func binding() {
        // 사용자 아이디 입력을 LoginViewModel id로 바인딩
        tfId?.rx.text
            .orEmpty
            .bind(to: viewModel.id)
            .disposed(by: disposeBag)
        
        // 사용자 비밀번호 입력을 LoginViewModel pw로 바인딩
        tfPw?.rx.text
            .orEmpty
            .bind(to: viewModel.pw)
            .disposed(by: disposeBag)
        
        // 사용자 아이디 입력 이벤트를 구독하여 콘솔 로그에 출력
        tfId?.rx.text
            .orEmpty
            .subscribe(onNext: { id in
                self.d("binding() >> id: \(id)")
            })
            .disposed(by: disposeBag)
        
        // 사용자 비밀번호 입력 이벤트를 구독하여 콘솔 로그에 출력
        tfPw?.rx.text
            .orEmpty
            .subscribe(onNext: { pw in
                self.d("binding() >> pw: \(pw)")
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼 유효성
        isValidLoginButton()
    }
    
    /**
     * 로그인 버튼 유효성
     */
    private func isValidLoginButton() {
        // LoginViewModel의 isValid() 유효성 검사 결과값을 (Observable<Bool>)을 로그인 버튼의 isEnabled 속성에 바인딩
        viewModel.isValid()
            .bind(to: (btnLogIn?.rx.isEnabled)!)
            .disposed(by: disposeBag)
        
        // LoginViewModel의 isValid() 유효성 검사 결과값을 (Observable<Bool>)을 로그인 버튼의 alpha 속성에 바인딩
        viewModel.isValid()
            .map { $0 ? 1 : 0.3}
            .bind(to: (btnLogIn?.rx.alpha)!)
            .disposed(by: disposeBag)
    }
}

// MARK: - MainView Delegate

extension LoginViewController: MainViewDelegate {
    func MainViewDelegate(controller: MainViewController) {
        d("MainViewDelegate() >> controller: \(controller)")
    }
}




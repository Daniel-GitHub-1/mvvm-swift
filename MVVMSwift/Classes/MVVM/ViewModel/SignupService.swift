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

class SignupService {
    private var TAG = "[SignupService]" // 디버그 태그
    
    private let signupService = SignupService() // 로그인 API 서비스
    
    private var disposeBag = DisposeBag() // Observable 해제
    
    let id = BehaviorSubject<String>(value: "")
    let pw = BehaviorSubject<String>(value: "")
    
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
     * 로그인 유효성 검사
     *
     * @param id 아이디
     * @param pw 비밀번호
     * @return Observable<(Bool, Enum.GetResult)>
     */
    func isValid() -> Observable<(Bool, Enum.GetResult)> {
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
            return (true, Enum.GetResult.NONE)
        }
    }
    
    /**
     * 아이디 중복 체크 정보
     *
     * @param viewController UIViewController
     * @param parameters 파라미터
     * @return onResult(true|false, DefaultEntity, GetFailureReason)
     */
    func getDuplicateCheckId(_ viewController: UIViewController,
                             parameters: Parameters,
                             onResult: @escaping (Bool, DefaultEntity, Enum.GetFailureReason)->()) {
        
        let isConnected = Reachability.isConnected()
        print("\(self.TAG) getDuplicateCheckId() >> isConnected: \(isConnected)")
        
        // 네트워크 오프라인
        if !isConnected {
            onResult(false, DefaultEntity.init(), Enum.GetFailureReason.NOT_CONNECTED)
            DialogUtil
                .sharedInstance
                .showOffline(controller: viewController) { selected in
                    print("\(self.TAG) getDuplicateCheckId() >> selected: \(selected)")
                }
            return
        }
        
        print("\(TAG) getDuplicateCheckId() >> parameters: \(parameters)")
        
        // 아이디 중복 체크
        checkIdRepository.getDuplicateCheckId(parameters: parameters) { (success, results, error) in
            print("\(self.TAG) getDuplicateCheckId() >> success: \(success)")
            print("\(self.TAG) getDuplicateCheckId() >> error: \(error)")
            print("\(self.TAG) getDuplicateCheckId() >> result: \( results.result)")
            print("\(self.TAG) getDuplicateCheckId() >> msg: \( results.msg)")
            
            completion(success, results, error)
        }
    }
}


//
//  ValidUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

import Foundation

class ValidUtil {
    
    let TAG: String = "[ValidUtil]" // 디버그 태그
    
    static let sharedInstance = ValidUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 아이디 유효성 검사
     *
     * 최소 2글짜 이상 이메일 형식
     * @param id 아이디
     * @returns (Bool, GetResult)
     */
    static func isValidId(_ id :String) -> (Bool, GetResult) {
        if id.isEmpty { // 아이디 공백
            return (false, GetResult.EMPTY_ID)
        }
        if id.count <= 2 { // 아이디 길이 (최소 2글자)
            return (false, GetResult.LENGTH_ID)
        }
        if !id.isValidEmail { // 아이디 형식 (이메일)
            return (false, GetResult.INVALID_ID)
        }
        return (true, GetResult.NONE)
    }
    
    /**
     * 비밀번호 유효성 검사
     *
     * 대문자+소문자+숫자+특수문자+20자까지
     * @param pw 비밀번호
     * @returns (Bool, GetResult)
     */
    static func isValidPw(_ pw :String) -> (Bool, GetResult) {
        if pw.isEmpty {
            return (false, GetResult.EMPTY_PW)
        }
        if pw.count <= 2 {
            return (false, GetResult.LENGTH_PW)
        }

        if !pw.isValidPassword {
            return (false, GetResult.INVALID_PW)
        }
        return (true, GetResult.NONE)
    }
}

extension String {
    
    var isValidEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let email = NSPredicate(format:"SELF MATCHES %@", regEx)
        return email.evaluate(with: self)
    }
    
    var isValidHp: Bool {
        let regEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let hp = NSPredicate(format:"SELF MATCHES %@", regEx)
        return hp.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regEx = "^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$"
        let hp = NSPredicate(format:"SELF MATCHES %@", regEx)
        return hp.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        // 영문+숫자+20자까지
//        let regEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        
        // 영문+숫자+특수문자+20자까지
//        let regEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
        
        // 대문자+소문자+숫자+특수문자+20자까지
//        let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])(?=.*[0-9])[A-Za-z\\d$@$!%*?&]{8,20}"
        
        // 숫자 (4<20)
        let regEx = "[0-9]{4,20}"
        let pw = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pw.evaluate(with: self)
    }
}

//
//  LogUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/09.
//

import Foundation

/**
 * LogUtil.swift
 *
 * @description 로그 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/

class LogUtil {
    let TAG: String = "[LogUtil]" // 디버그 태그
    
    static let sharedInstance = LogUtil() // 인스턴스
    var debug = true
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }

    /**
     * 디버그 로그
     *
     * @param msg 메시지
     */
    func setDebug(_ debug: Bool) {
        self.debug = debug
    }
    
    /**
     * 디버그 로그
     *
     * @param msg 메시지
     */
    func d(_ msg: String) {
        if debug { print(msg) }
    }
    
    /**
     * 유니코드 to 한글
     *
     * @param msg 메시지
     * @return String 변환된 한글
     */
    func koLog(_ msg: String) -> String {
        let pattern = "\\\\U([a-z0-9]{4})"
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            debugPrint("\(error)")
            return ""
        }
        return replacingCharacters(msg, regex: regex)
    }
    
    /**
     * 정규식 표현에 맞는 문자를 찾아 치환
     *
     * @param string 입력 문자
     * @return regex 정규식
     */
    func replacingCharacters(_ string: String, regex: NSRegularExpression) -> String {
        let range = NSRange(location: 0, length: string.count)
        guard let firstMatch = regex.firstMatch(in: string, options: [], range: range) else {
            return string
        }
        let nsString = NSString(string: string)
        let substring = nsString.substring(with: firstMatch.range(at: 1))
        let unicodeValue = UInt32(substring, radix: 16)!
        guard let unicodeScalar = UnicodeScalar(unicodeValue) else {
            return string
        }
        let newString = nsString.replacingCharacters(in: firstMatch.range(at: 0), with: String(unicodeScalar))
        return replacingCharacters(newString, regex: regex)
    }
}


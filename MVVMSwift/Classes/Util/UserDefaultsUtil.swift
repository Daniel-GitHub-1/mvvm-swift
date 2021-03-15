//
//  UserDefaultsUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/12.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import UIKit

class UserDefaultsUtil {
    let TAG: String = "[UserDefaultsUtil]"
    
    static let sharedInstance = UserDefaultsUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * BOOL 설정 값
     *
     * @param key 키 값
     * @returns Bool 설정된 값
     */
    func getBoolValue(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    /**
     * BOOL 설정 값 저장
     *
     * @param key 키 값
     * @param value 설정 값
     * @returns Bool 설정된 값
     */
    func setBoolValue(_ key: String,
                      value: Bool) -> Bool {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        return getBoolValue(key)
    }
    
    /**
     * Int 설정 값
     *
     * @param key 키 값
     * @returns Int 설정된 값
     */
    func getIntValue(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    /**
     * Int 설정 값 저장
     *
     * @param key 키 값
     * @param value 설정 값
     * @returns Int 설정된 값
     */
    func setIntValue(_ key: String,
                     value: Int) -> Int {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        return getIntValue(key)
    }
    
    /**
     * String 설정 값
     *
     * @param key 키 값
     * @returns String 설정된 값
     */
    func getStringValue(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    /**
     * String 설정 값 저장
     *
     * @param key 키 값
     * @param value 설정 값
     * @returns String 설정된 값
     */
    func setStringValue(_ key: String,
                        value: String) -> String {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        return getStringValue(key)
    }
    
    /**
     * Array 설정 값
     *
     * @param key 키 값
     * @returns Int 설정된 값
     */
    func getArrayValue(_ key: String) -> [Any] {
        return UserDefaults.standard.array(forKey: key) ?? [Any]()
    }
    
    /**
     * Array 설정 값 저장
     *
     * @param key  키 값
     * @param value  설정 값 [Bool]
     * @returns Bool 설정된 값
     */
    func setArrayValue(_ key: String,
                       value: [Any]) -> [Any] {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        return getArrayValue(key)
    }
    
    /**
     * 초기화
     *
     */
    func clear() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}


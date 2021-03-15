//
//  DeviceUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/02.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import Foundation

class DeviceUtil {
    
    let TAG: String = "[DeviceUtil]" // 디버그 태그
    
    static let sharedInstance = DeviceUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
}

//
//  MainViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxSwift
import Alamofire

class MainViewModel {
    var TAG = "MainViewModel" // 디버그 태그
    let versionRepository = VersionRepository()
    let checkIdRepository = CheckIdRepository()
    
    func getVersion() {
        var params = [String: Any]()
        params[Key.MOBILE_TYPE] = "A"
        params[Key.PUSH_TOKEN] = "dEWiunazakvqqNsmQgadHI:APA91bE2YNFTTM8Yh_qmK3RQ5l8zzzzk_fP6FCM5LIQC_TY7a1sVfNwuDDZnqizVvZn5ieagARvt3LBraf_-F2UY3kcqgjum0vsbbQM28pfy_ny_kwNOaEi4yCfnYIQ0MF27KHkwIsBD"
        print("\(TAG) getVersion() >> params: \(params)")
        
        versionRepository.getVersion(params: params) { (result, version, msg) in
            print("getVersion() >> result: \(result)")
            print("getVersion() >> version: \(version)")
            print("getVersion() >> msg: \(msg)")
        }
    }
    
    func getDuplicateCheckId(id: String) {
        let parameters: Parameters = [
            Key.APP_TYPE: Define.APP_TYPE,
            Key.TN: Define.TN_ID,
            Key.MEM_ID: id
        ]
        print("\(TAG) getDuplicateCheckId() >> parameters: \(parameters)")

        checkIdRepository.getDuplicateCheckId(parameters: parameters) { (success, results, error) in
            print("getDuplicateCheckId() >> success: \(success)")
            print("getDuplicateCheckId() >> error: \(error)")
            if success {
                print("getDuplicateCheckId() >> result: \( results.result)")
                print("getDuplicateCheckId() >> msg: \( results.msg)")
               
            }
        }
    }
}



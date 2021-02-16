//
//  MainViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

/**
 * MainViewModel.swift
 *
 * @description 메인 뷰 모델
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class MainViewModel {
    var TAG = "[MainViewModel]" // 디버그 태그
    
    let listDataRepository = ListDataRepository() // 리스트 데이터 저장소
    let versionRepository = VersionRepository() // 버전 데이터 저장소
    let checkIdRepository = CheckIdRepository() // 아이디 체크 데이터 저장소
    
    /**
     * 버전 정보
     *
     * @param view UIViewController
     * @param parameters Parameters
     * @return onResult(true|false, VersionEntity, GetFailureReason)
     *
     */
    func getVersion(view: UIViewController,
                    parameters: Parameters,
                    onResult: @escaping (Bool, VersionEntity, Enum.GetFailureReason)->()) {
        
        // 네트워크 오프라인
        let isConnected = Reachability.isConnected()
        print("\(self.TAG) getVersion() >> isConnected: \(isConnected)")
        if !isConnected {
            onResult(true, VersionEntity.init(), Enum.GetFailureReason.NOT_CONNECTED)

            DialogUtil
                .sharedInstance
                .showOffline(controller: view) { selected in
                    print("\(self.TAG) getVersion() >> selected: \(selected)")
                }
            return
        }

        // 버전 요청
        versionRepository.getVersion(parameters: parameters) { (result, version, msg) in
            print("\(self.TAG) getVersion() >> result: \(result)")
            print("\(self.TAG) getVersion() >> version: \(version)")
            print("\(self.TAG) getVersion() >> msg: \(msg)")
        }
    }
    
    /**
     * 아이디 중복 체크 정보
     *
     * @param view UIViewController
     * @param parameters 파라미터
     * @return onResult(true|false, DefaultEntity, GetFailureReason
     */
    func getDuplicateCheckId(view: UIViewController,
                             parameters: Parameters,
                             onResult: @escaping (Bool, DefaultEntity, Enum.GetFailureReason)->()) {
        
        let isConnected = Reachability.isConnected()
        print("\(self.TAG) getDuplicateCheckId() >> isConnected: \(isConnected)")
        
        // 네트워크 오프라인
        if !isConnected {
            onResult(false, DefaultEntity.init(), Enum.GetFailureReason.NOT_CONNECTED)
            DialogUtil
                .sharedInstance
                .showOffline(controller: view) { selected in
                    print("\(self.TAG) getDuplicateCheckId() >> selected: \(selected)")
                }
            return
        }
       
        print("\(TAG) getDuplicateCheckId() >> parameters: \(parameters)")

        // 아이디 중복 체크
        checkIdRepository.getDuplicateCheckId(parameters: parameters) { (success, results, error) in
            print("\(self.TAG) getDuplicateCheckId() >> success: \(success)")
            print("\(self.TAG) getDuplicateCheckId() >> error: \(error)")
            
//            completion(success, results, error)
            
            if success {
                print("\(self.TAG) getDuplicateCheckId() >> result: \( results.result)")
                print("\(self.TAG) getDuplicateCheckId() >> msg: \( results.msg)")
               
            }
        }
    }

    /**
     * 리스트 데이터 중복 체크 정보
     *
     * @param view UIViewController
     * @param parameters 파라미터
     * @return onResult(true|false, ListDataEntity, GetFailureReason)
     *
     */
    func getListData(view: UIViewController,
                     parameters: Parameters,
                     onResult: @escaping (Bool, [ListDataInfoEntity], Enum.GetFailureReason)->()) {
        print("\(TAG) getListData() >> parameters: \(parameters)")

        listDataRepository.getListData(parameters: parameters) { (success, results, error) in
            print("\(self.TAG) getListData() >> success: \(success)")
            print("\(self.TAG) getListData() >> results: \(results)")
            print("\(self.TAG) getListData() >> error: \(error)")
            
            onResult(success, results.info, error)
        }
    }
}

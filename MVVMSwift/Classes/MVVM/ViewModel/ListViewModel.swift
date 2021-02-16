//
//  ListViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/05.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

/**
 * ListViewModel.swift
 *
 * @description 리스트 뷰 모델
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ListViewModel {
    var TAG = "[ListVi‰ewModel]" // 디버그 태그
    
    let listDataRepository = ListDataRepository() // 리스트 데이터 저장소
    
    /**
     * 리스트 데이터 중복 체크 정보
     *
     * @param view UIViewController
     * @param parameters 파라미터
     * @return completion(true|false, ListDataEntity, GetFailureReason)
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

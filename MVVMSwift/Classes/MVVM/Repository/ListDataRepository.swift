//
//  ListDataRepository.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxCocoa
import RxSwift
import RxViewController
import Alamofire

/**
 * ListDataRepository.swift
 *
 * @description 리스트 데이터 저장소
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ListDataRepository {
    var TAG = "[ListDataRepository]" // 디버그 태그
    
    let listDataRemoteDataSource = ListDataRemoteDataSource() // 리스트 데이터 소스
    var disposeBag = DisposeBag() // Observable 해제

    /**
     * 리스트 데이터
     *
     * @param parameters 파라미터
     * @returns onResult(Bool, ListDataEntity, Enum.GetFailureReason)
     */
    func getListData(parameters: Parameters,
                     onResult: @escaping (Bool, ListDataEntity, Enum.GetFailureReason)->()) {
        listDataRemoteDataSource
            .getListData(parameters: parameters)
            .subscribe(
                onNext: { listData in
                    onResult(true, ListDataEntity.init(), Enum.GetFailureReason.NONE)
                    print("\(self.TAG) getListData() >> listData: \(listData)")
                },
                onError: { error in
                    onResult(false, ListDataEntity.init(), error as? Enum.GetFailureReason ?? Enum.GetFailureReason.NONE)
                    print("\(self.TAG) getListData() >> error: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}




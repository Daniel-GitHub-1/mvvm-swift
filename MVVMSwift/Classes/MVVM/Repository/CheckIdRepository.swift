//
//  CheckIdRepository.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import Foundation
import RxCocoa
import RxSwift
import RxViewController
import Alamofire

/**
 * CheckIdRepository.swift
 *
 * @description 아이디 중복 체크 저장소
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class CheckIdRepository {
    var TAG = "[CheckIdRepository]" // 디버그 태그
   
    let checkIdRemoteDataSource = CheckIdRemoteDataSource() // 아이디 중복 체크 데이터 소스
    var disposeBag = DisposeBag() // Observable 해제

    /**
     * 아이디 중복 체크
     *
     * @param parameters 파라미터
     * @returns onResult(Bool, DefaultEntity, Enum.GetFailureReason)
     */
    func getDuplicateCheckId(parameters: Parameters,
                             onResult: @escaping (Bool, DefaultEntity, String)->()) {
        checkIdRemoteDataSource
            .getDuplicateCheckId(parameters: parameters)
            .subscribe(
                onNext: { results in 
                    onResult(true, results, "")
                    print("getDuplicateCheckId() >> results: \(results)")
                },
                onError: { error in
                    onResult(false, DefaultEntity.init(), error.localizedDescription)
                    print("\(self.TAG) getListData() >> error: \(error.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)
    }
}


//
//  VersionRepository.swift
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
 * VersionRepository.swift
 *
 * @description 버전 저장소
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class VersionRepository {
    var TAG = "[ListDataRepository]" // 디버그 태그
    
    let versionRemoteDataSource = VersionRemoteDataSource() // 버전 데이터 소스
    var disposeBag = DisposeBag() // Observable 해제

    /**
     * 버전 정보
     *
     * @param parameters 파라미터
     * @returns onResult(Bool, VersionEntity, Enum.GetFailureReason)
     */
    func getVersion(parameters: Parameters,
                    onResult: @escaping (Bool, VersionEntity, Enum.GetFailureReason)->()) {
        versionRemoteDataSource
            .getVersion(parameters: parameters)
            .subscribe(
                onNext: { version in
                    onResult(true, version, Enum.GetFailureReason.NONE)
                    print("\(self.TAG) getVersion() >> version: \(version)")
                },
                onError: { error in
                    onResult(false, VersionEntity.init(), error as? Enum.GetFailureReason ?? Enum.GetFailureReason.NONE)
                    print("\(self.TAG) getVersion() >> error: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}

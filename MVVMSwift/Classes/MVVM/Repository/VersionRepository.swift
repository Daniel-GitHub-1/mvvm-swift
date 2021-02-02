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

class VersionRepository {
    
    let versionRemoteDataSource = VersionRemoteDataSource()
    var disposeBag = DisposeBag()

    func getVersion(params: Dictionary<String, Any>,
                    completion: @escaping (Bool, VersionEntity, String)->()) {
        versionRemoteDataSource
            .getVersion(params: params)
            .subscribe(
                onNext: { version in
                    completion(true, version, "")
                },
                onError: { error in
                    completion(false, VersionEntity.init(), error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}

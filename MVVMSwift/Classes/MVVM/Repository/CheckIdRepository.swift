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

class CheckIdRepository {
    
    let checkIdRemoteDataSource = CheckIdRemoteDataSource()
    var disposeBag = DisposeBag()

    func getDuplicateCheckId(parameters: Parameters,
                             completion: @escaping (Bool, DefaultEntity, String)->()) {
        checkIdRemoteDataSource
            .getDuplicateCheckId(parameters: parameters)
            .subscribe(
                onNext: { results in
                    print("getDuplicateCheckId() >> results: \(results)")
                    completion(true, results, "")
                },
                onError: { error in
                    completion(false, DefaultEntity.init(), error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}


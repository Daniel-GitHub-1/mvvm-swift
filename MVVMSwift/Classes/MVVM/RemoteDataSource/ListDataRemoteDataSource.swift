//
//  ListDataRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxSwift

let listDataUrl = "\(Define.BASE_URL)/api/app/versionCheck?mobileType=A"

class ListDataRemoteDataSource {
    static func getListData(params: NSDictionary) -> Observable<Data> {
        return Observable.create { emitter in
            getListData(params: params) { result in
                switch result {
                case let .success(data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    static func getListData(params: NSDictionary,
                               onComplete: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: listDataUrl)!) { data, res, err in
            if let err = err {
                onComplete(.failure(err))
                return
            }
            guard let data = data else {
                let httpResponse = res as! HTTPURLResponse
                onComplete(.failure(NSError(domain: "no data",
                                            code: httpResponse.statusCode,
                                            userInfo: nil)))
                return
            }
            onComplete(.success(data))
        }.resume()
    }
}

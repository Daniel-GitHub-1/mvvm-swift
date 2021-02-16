//
//  ListDataRemoteDataSource.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxSwift
import Alamofire

let listDataUrl = "\(Define.BASE_URL)common/search" // API URL

/**
 * ListDataRemoteDataSource.swift
 *
 * @description 리스트 데이터 소스
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ListDataRemoteDataSource {
    var TAG = "[ListDataRemoteDataSource]" // 디버그 태그
    
    /**
     * 리스트 데이트
     *
     * @param parameters 파라미터
     * @returns Observable<ListDataEntity>
     */
    func getListData(parameters: Parameters) -> Observable<ListDataEntity> {
        print("\(self.TAG) getListData() >> Start !!!")
        print("\(self.TAG) getListData() >> listDataUrl: \(listDataUrl)")
        print("\(self.TAG) getListData() >> parameters: \(parameters)")

        return Observable.create {
            observer -> Disposable in
            AF.request(listDataUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    print("\(self.TAG) getListData() >> response: \(response)")
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? Enum.GetFailureReason.NOT_FOUND)
                            return
                        }
                        do {
                            let listData = try JSONDecoder().decode(ListDataEntity.self,
                                                                    from: data)
                            print("\(self.TAG) getListData() >> listData: \(listData)")
                            observer.onNext(listData)
                        } catch {
                            print("\(self.TAG) getListData() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = Enum.GetFailureReason(rawValue: statusCode) {
                            print("\(self.TAG) getListData() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        print("\(self.TAG) getListData() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

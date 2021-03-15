//
//  ListDataService.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import Foundation

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// Communication
import Alamofire

class ListDataService: BaseService {
    private let listDataUrl = "http://app.ppojji.com/common/search" // API URL
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initService("[ListDataService]")
    }
    
    /**
     * 리스트 데이트
     *
     * @param parameters 파라미터
     * @returns Observable<ListData>
     */
    func getListData(_ parameters: Parameters) -> Observable<ListData> {
        d("getListData() >> Start !!!")
        d("getListData() >> listDataUrl: \(listDataUrl)")
        d("getListData() >> parameters: \(parameters)")
        
        return Observable.create {
            observer -> Disposable in
            AF.request(self.listDataUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: self.headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    self.d("getListData() >> response: \(response)")
                    
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? GetFailureReason.NOT_FOUND)
                            return
                        }
                        do {
                            let results = try JSONDecoder().decode(ListData.self,
                                                                   from: data)
                            self.d("getListData() >> results: \(results)")
                            observer.onNext(results)
                        } catch {
                            self.d("getListData() >> error: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = GetFailureReason(rawValue: statusCode) {
                            self.d("getListData() >> reason: \(reason)")
                            observer.onError(reason)
                        }
                        self.d("getListData() >> error: \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}


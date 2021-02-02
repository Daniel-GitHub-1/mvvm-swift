//
//  ListDataRepository.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import RxSwift

protocol ListDataFetchable {
    func getListData(params: NSDictionary) -> Observable<[ListDataEntity]>
}

class ListDataRepository: ListDataFetchable {
    
    func getListData(params: NSDictionary) -> Observable<[ListDataEntity]> {
        struct Response: Decodable {
            let listData: [ListDataEntity]
        }
        
        return ListDataRemoteDataSource.getListData(params: params)
            .map { data in
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                }
                return response.listData
            }
    }
}



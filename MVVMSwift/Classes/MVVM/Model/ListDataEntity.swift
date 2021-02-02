//
//  ListDataEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation

struct ListDataEntity: Decodable {
    var id: Int = 0
    var title: String = ""
    var subTitle: String = ""
    
    init(id: Int, title: String, subTitle: String) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
    }
}

extension ListDataEntity: Equatable {
    static func == (lhs: ListDataEntity, rhs: ListDataEntity) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.subTitle == rhs.subTitle
    }
}

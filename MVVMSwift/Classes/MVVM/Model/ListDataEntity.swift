//
//  ListDataEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

/**
 * ListDataEntity.swift
 *
 * @description 리스트 데이터 엔티티
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ListDataEntity: Decodable {
    var result: String = "false" // 결과
    var msg: String = "" // 메시지
    var page: Int = 0 // 페이지
    var info: [ListDataInfoEntity] // 정보
    
    // 코딩 키
    private enum CodingKeys: String, CodingKey {
        case result
        case msg
        case page
        case info
    }

    init() {
        result = ""
        msg = ""
        page = 0
        info = [ListDataInfoEntity.init()]
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.result = (try? container.decode(String.self, forKey: .result)) ?? ""
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
        self.page = (try? container.decode(Int.self, forKey: .page)) ?? 0
        self.info = (try? container.decode([ListDataInfoEntity].self, forKey: .info)) ?? [ListDataInfoEntity.init()]
    }
}

extension ListDataEntity: Equatable {
    static func == (lhs: ListDataEntity, rhs: ListDataEntity) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
            && lhs.page == rhs.page
            && lhs.info == rhs.info
    }
}

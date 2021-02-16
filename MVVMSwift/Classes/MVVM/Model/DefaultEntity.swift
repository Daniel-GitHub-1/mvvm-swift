//
//  DefaultEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

/**
 * DefaultEntity.swift
 *
 * @description 기본 엔티티
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class DefaultEntity: Decodable {
    var TAG = "[DefaultEntity]" // 디버그 태그
    
    var result: String = "fail" // 결과
    var msg: String = "" // 메시지
    
    // 코딩 키
    private enum CodingKeys: String, CodingKey {
        case result
        case msg
    }
    
    init() {
        result = ""
        msg = ""
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.result = (try? container.decode(String.self, forKey: .result)) ?? ""
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
    }
}

extension DefaultEntity: Equatable {
    static func == (lhs: DefaultEntity, rhs: DefaultEntity) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
    }
}

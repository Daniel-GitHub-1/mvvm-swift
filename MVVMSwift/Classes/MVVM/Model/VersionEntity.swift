//
//  VersionEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//


/**
 * VersionEntity.swift
 *
 * @description 버전 엔티티
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class VersionEntity: Decodable {
    var TAG = "[VersionEntity]" // 디버그 태그
    
    var result: String = "fail" // 결과
    var version: String = "" // 버전
    var msg: String = "" // 메시지
    
    // 코딩 키
    private enum CodingKeys: String, CodingKey {
        case result
        case version
        case msg
    }
    
    init() {
        result = ""
        msg = ""
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.result = (try? container.decode(String.self, forKey: .result)) ?? ""
        self.version = (try? container.decode(String.self, forKey: .version)) ?? ""
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
    }
}

extension VersionEntity: Equatable {
    static func == (lhs: VersionEntity, rhs: VersionEntity) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
            && lhs.version == rhs.version
    }
}

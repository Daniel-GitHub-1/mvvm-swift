//
//  VersionEntity.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

class Version: Decodable {
    private var TAG = "[Version]" // 디버그 태그
    
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

extension Version: Equatable {
    static func == (lhs: Version, rhs: Version) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
            && lhs.version == rhs.version
    }
}

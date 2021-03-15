//
//  DefaultEntity.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

class Default: Decodable {
    private var TAG = "[Default]" // 디버그 태그
    
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

extension Default: Equatable {
    static func == (lhs: Default, rhs: Default) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
    }
}

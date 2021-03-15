//
//  LoginEntity.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/23.
//

class Login: Decodable {
    private var TAG = "[Login]" // 디버그 태그
    
    var result: Bool = false // 결과
    var msg: String = "" // 메시지

    var muid: Int = 0 // 사용자 id
    var buid: Int = 0 // 회사 id
    var bname: String = "" // 회사명

    // 코딩 키
    private enum CodingKeys: String, CodingKey {
        case result
        case msg
        case muid
        case buid
        case bname
    }
    
    init() {
        result = false
        msg = ""
        muid = 0
        buid = 0
        bname = ""
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.result = Bool((try? container.decode(String.self, forKey: .result)) ?? "false") ?? false
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
        self.muid = Int((try? container.decode(String.self, forKey: .muid)) ?? "0") ?? 0
        self.buid = Int((try? container.decode(String.self, forKey: .buid)) ?? "0") ?? 0
        self.bname = (try? container.decode(String.self, forKey: .bname)) ?? ""
    }
}

extension Login: Equatable {
    static func == (lhs: Login, rhs: Login) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
            && lhs.muid == rhs.muid
            && lhs.buid == rhs.buid
            && lhs.bname == rhs.bname
    }
}
    

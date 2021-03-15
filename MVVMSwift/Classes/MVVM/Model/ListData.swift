//
//  ListDataEntity.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

class ListData: Decodable {
    private var result: String = "false" // 결과
    var msg: String = "" // 메시지
    var page: Int = 0 // 페이지
    var info: [ListDataInfo] // 정보
    
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
        info = [ListDataInfo.init()]
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.result = (try? container.decode(String.self, forKey: .result)) ?? ""
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
        self.page = (try? container.decode(Int.self, forKey: .page)) ?? 0
        self.info = (try? container.decode([ListDataInfo].self, forKey: .info)) ?? [ListDataInfo.init()]
    }
}

extension ListData: Equatable {
    static func == (lhs: ListData, rhs: ListData) -> Bool {
        return lhs.result == rhs.result
            && lhs.msg == rhs.msg
            && lhs.page == rhs.page
            && lhs.info == rhs.info
    }
}

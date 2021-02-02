//
//  DefaultEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import Foundation

class DefaultEntity: Decodable {
    var TAG = "[DefaultEntity]" // 디버그 태그
    var result: String = "fail" // 결과
    var msg: String = "" // 메시지
    
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
    
//    init() {
//        result = "fail"
//        msg = ""
//    }

//    init(json: Data) {
//        print("\(self.TAG) init() >> json: \(String(describing: json))")
//        
//        do {
//            let data
//                = try JSONSerialization.jsonObject(with: json, options:[]) as! [String: Any]
//            print("\(self.TAG) init() >> data: \(String(describing: data))")
//            
//            let result = data[Key.RESULT] as? String ?? "fail"
//            let msg = data[Key.MSG] as? String ?? ""
//            print("\(self.TAG) init() >> result: \(String(describing: result))")
//            print("\(self.TAG) init() >> msg: \(String(describing: msg))")
//        } catch {
//            print("\(self.TAG) init() >> error: \(error)")
//        }
//    }
}

extension DefaultEntity: Equatable {
    static func == (lhs: DefaultEntity, rhs: DefaultEntity) -> Bool {
        return lhs.result == rhs.result && lhs.msg == rhs.msg
    }
}

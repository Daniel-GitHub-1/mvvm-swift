//
//  VersionEntity.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import Foundation
import UIKit

struct VersionEntity: Decodable {
    var TAG = "[VersionEntity]" // 디버그 태그
    var version: String = "" // 버전
    
    init() {
        version = ""
    }
    
    init(json: Data) {
        do {
            let data
                = try JSONSerialization.jsonObject(with: json, options:[]) as! [String: Any]
            let version = data[Key.VERSION] as? Bool ?? false
            print("\(self.TAG) init() >> version: \(String(describing: version))")
        } catch {
            print("\(self.TAG) init() >> error: \(error)")
        }
    }
}

extension VersionEntity: Equatable {
    static func == (lhs: VersionEntity, rhs: VersionEntity) -> Bool {
        return lhs.version == rhs.version
    }
}

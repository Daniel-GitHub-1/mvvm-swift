//
//  ListDataInfoEntity.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/05.
//

/**
 * ListDataInfo.swift
 *
 * @description 리스트 데이터 정보 엔티티
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ListDataInfo: Decodable {
    var idx: CLong = 0 // 인덱스
    var intro_img: String = "" // 이미지
    var store_name: String = "" // 매장명
    var store_addr: String = "" // 매장주소
    var map_x: Double = 0 // X좌표
    var map_y: Double = 0 // Y좌표
    
    // 코딩 키
    private enum CodingKeys: String, CodingKey {
        case idx
        case intro_img
        case store_name
        case store_addr
        case map_x
        case map_y
    }
    
    init() {
        self.idx = 0
        self.intro_img = ""
        self.store_name = ""
        self.store_addr = ""
        self.map_x = 0
        self.map_y = 0
    }
    
    init(idx: CLong,
         intro_img: String,
         store_name: String,
         store_addr: String,
         map_x: Double,
         map_y: Double) {
        self.idx = idx
        self.intro_img = intro_img
        self.store_name = store_name
        self.store_addr = store_addr
        self.map_x = map_x
        self.map_y = map_y
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idx = (try? container.decode(CLong.self, forKey: .idx)) ?? 0
        self.intro_img = (try? container.decode(String.self, forKey: .intro_img)) ?? ""
        self.store_name = (try? container.decode(String.self, forKey: .store_name)) ?? ""
        self.store_addr = (try? container.decode(String.self, forKey: .store_addr)) ?? ""
        self.map_x = (try? container.decode(Double.self, forKey: .map_x)) ?? 0
        self.map_y = (try? container.decode(Double.self, forKey: .map_y)) ?? 0
    }
}

extension ListDataInfo: Equatable {
    static func == (lhs: ListDataInfo, rhs: ListDataInfo) -> Bool {
        return lhs.idx == rhs.idx
            && lhs.intro_img == rhs.intro_img
            && lhs.store_name == rhs.store_name
            && lhs.store_addr == rhs.store_addr
            && lhs.map_x == rhs.map_x
            && lhs.map_y == rhs.map_y
    }
}

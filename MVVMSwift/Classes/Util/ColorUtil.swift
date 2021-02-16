//
//  ColorUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import UIKit

/**
 * ColorUtil.swift
 *
 * @description 색상 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ColorUtil {
    let TAG: String = "[ColorUtil]"         // 디버그 태그
    
    static let sharedInstance = ColorUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * Hex String 문자열 분해
     *
     * @param hexString 헥스 코드
     * @returns [String]
     */
    func splitHexColorCode(hexString: String) -> [String]? {
        let array = Array<Character>(hexString)
        var result = [String]()
        
        if array.count == 7 {
            result.append(String(array[0]))
            result.append(String(describing: array[1]) + String(describing: array[2]))
            result.append(String(describing: array[3]) + String(describing: array[4]))
            result.append(String(describing: array[5]) + String(describing: array[6]))
            return result
        } else if array.count == 4 {
            result.append(String(array[0]))
            result.append(String(describing: array[1]) + String(describing: array[1]))
            result.append(String(describing: array[2]) + String(describing: array[2]))
            result.append(String(describing: array[3]) + String(describing: array[3]))
            return result
        } else {
            return nil
        }
    }

    
    /**
     * Hex String to UIColor
     *
     * @param hexString 헥스 코드
     * @returns UIColor
     */
    func hexString2UIColor(hexString: String) -> UIColor? {
        return hexString.color
    }
}

extension String {
    var color: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        if #available(iOS 13, *) {
            guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else { return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
            
            let a, r, g, b: Int32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
            
        } else {
            var int = UInt32()
            
            Scanner(string: hex).scanHexInt32(&int)
            let a, r, g, b: UInt32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
    }
}

//
//  StringUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/18.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

class StringUtil {
    let TAG: String = "[StringUtil]"
    
    static let sharedInstance = StringUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")

    }
}

extension String {
    func htmlEscaped(font: UIFont, colorHex: String, lineSpacing: CGFloat) -> NSAttributedString {
        let style = """
                    <style>
                    p.normal {
                      line-height: \(lineSpacing);
                      font-size: \(font.pointSize)px;
                      font-family: \(font.familyName);
                      color: \(colorHex);
                    }
                    </style>
        """
        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
}

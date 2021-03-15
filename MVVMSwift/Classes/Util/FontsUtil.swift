//
//  FontsUtil.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/03/12.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

import UIKit

class FontsUtil {
    let TAG: String = "[FontsUtil]"
    
    static let sharedInstance = FontsUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")

    }
    
    /**
     * Roboto-Black
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoBlack(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Black", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-BlackItalic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoBlackItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-BlackItalic", size: CGFloat(size)) ?? UIFont()
    }
    
    
    /**
     * Roboto-Bold
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoBold(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: CGFloat(size)) ?? UIFont()
    }
    
    
    /**
     * Roboto-BoldItalic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoBoldItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-BoldItalic", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-Italic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Italic", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-Light
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoLight(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Light", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-LightItalic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoLightItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-LightItalic", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-Medium
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoMedium(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-MediumItalic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoMediumItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-MediumItalic", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-Regular
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoRegular(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-RegularItalic
     *
     * @param size Font Size
     * @return UIFont
     */
//    func robotoRegularItalic(_ size: Int) -> UIFont {
//        return UIFont(name: "Roboto-RegularItalic", size: CGFloat(size)) ?? UIFont()
//    }

    /**
     * Roboto-Thin
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoThin(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-Thin", size: CGFloat(size)) ?? UIFont()
    }
    
    /**
     * Roboto-ThinItalic
     *
     * @param size Font Size
     * @return UIFont
     */
    func robotoThinItalic(_ size: Int) -> UIFont {
        return UIFont(name: "Roboto-ThinItalic", size: CGFloat(size)) ?? UIFont()
    }
}



//
//  DialogUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

import UIKit

/**
 * DialogUtil.swift
 *
 * @description 다이얼 로그 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class DialogUtil {
    let TAG: String = "[DialogUtil]" // 디버그 태그
    
    static let sharedInstance = DialogUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 다이얼 로그 (팝업)
     *
     * @param controller 뷰 컨트롤러
     * @param title     타이틀
     * @param message     메시지
     * @param contents  컨텐츠
     * @returns onResult content
     */
    func show(controller: UIViewController,
              title: String!,
              message: String!,
              contents: [String]!,
              onResult: @escaping (String) -> Void) {
        print("\(TAG) show() >> Start !!!")
        print("\(TAG) show() >> controller: \(String(describing: controller))")
        print("\(TAG) show() >> title: \(String(describing: title))")
        print("\(TAG) show() >> contents: \(String(describing: contents))")
        
        if (contents!.count == 0) { return }
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        var action: UIAlertAction!
        for content in contents! {
            if (content == "삭제"
                    || content == "로그아웃") {
                action = UIAlertAction(title: content,
                                       style: .destructive) { (action:UIAlertAction) in
                    onResult(content)
                    print("\(self.TAG) show() >> action.title: \(String(describing: action.title))")
                }
                
                alertController.addAction(action)
            } else {
                action = UIAlertAction(title: content,
                                       style: .default) { (action:UIAlertAction) in
                    onResult(content)
                    print("\(self.TAG) show() >> action.title: \(String(describing: action.title))")
                }
                alertController.addAction(action)
            }
        }
        
        DispatchQueue
            .main
            .async {
                if controller.presentedViewController == nil {
                    controller.present(alertController, animated: true, completion: nil)
                } else {
                    controller.dismiss(animated: false, completion: nil)
                    controller.present(alertController, animated: true, completion: nil)
                }
            }
    }
    
    /**
     * 다이얼 로그 (시트)
     *
     * @param controller 뷰 컨트롤러
     * @param title     타이틀
     * @param message     메시지
     * @param contents  컨텐츠
     * @returns onResult content
     */
    func showSheet(controller: UIViewController,
                   title: String!,
                   message: String!,
                   contents: [String]!,
                   onResult: @escaping (String) -> Void) {
        print("\(TAG) showSheet() >> Start !!!")
        print("\(TAG) showSheet() >> controller: \(String(describing: controller))")
        print("\(TAG) showSheet() >> title: \(String(describing: title))")
        print("\(TAG) showSheet() >> contents: \(String(describing: contents))")
        
        if (contents!.count == 0) { return }
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.actionSheet)
        var action: UIAlertAction!
        for content in contents! {
            if (content == "삭제"
                    || content == "로그아웃") {
                action = UIAlertAction(title: content,
                                       style: .destructive) { (action:UIAlertAction) in
                    onResult(content)
                    print("\(self.TAG) showSheet() >> action.title: \(String(describing: action.title))")
                }
                
                alertController.addAction(action)
            } else if (content == "취소"
                        || content == "닫기") {
                action = UIAlertAction(title: content,
                                       style: .cancel) { (action:UIAlertAction) in
                    onResult(content)
                    print("\(self.TAG) showSheet() >> action.title: \(String(describing: action.title))")
                }
                alertController.addAction(action)
            } else {
                action = UIAlertAction(title: content,
                                       style: .default) { (action:UIAlertAction) in
                    onResult(content)
                    print("\(self.TAG) showSheet() >> action.title: \(String(describing: action.title))")
                }
                alertController.addAction(action)
            }
        }
        
        if controller.presentedViewController == nil {
            controller.present(alertController, animated: true, completion: nil)
        } else {
            controller.dismiss(animated: false, completion: nil)
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    /**
     * 오프라인 다이얼로그
     *
     * @param controller UIViewController
     * @returns onResult content
     */
    func showOffline(controller: UIViewController,
                     onResult: @escaping (String) -> Void) {
        // 오프라인
        let title = "알림"
        let message = Ment.MENT_ERROR_NETWORK
        var contents = [String]()
        contents.append("확인")

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        if (contents.count == 0) { return }
        
        print("\(self.TAG) showOffline() >> alertController: \(String(describing: alertController))")
        
        var action: UIAlertAction!
        print("\(self.TAG) showOffline() >> alertController: \(String(describing: alertController.view.frame.width))")
        print("\(self.TAG) showOffline() >> alertController: \(String(describing: alertController.view.frame.width / 2))")
        
        for content in contents {
            action = UIAlertAction(title: content, style: .default) { (action:UIAlertAction) in
                print("\(self.TAG) showOffline() -> content: \(String(describing: content))")
                onResult(content)
            }
            alertController.addAction(action)
        }
        
        DispatchQueue
            .main
            .async {
                
                if controller.presentedViewController == nil {
                    controller.present(alertController, animated: true, completion: nil)
                } else {
                    controller.dismiss(animated: false, completion: nil)
                    controller.present(alertController, animated: true, completion: nil)
                }
            }
    }
}

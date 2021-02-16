//
//  BaseViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import UIKit

// 컨트롤러 타입
protocol ControllerType {
    var navigationTitle: String { get }
}

/**
 * 컨트롤러 타입
 *
 * @return navigationTitle 타이틀
 */
extension ControllerType {
    var navigationTitle: String {
        return ""
    }
}

/**
 * BaseViewController.swift
 *
 * @description 기본 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class BaseViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    var TAG = "" // 디버그 태그
    
    static let ALPHA_SEMI_MAX: CGFloat = 0.5 // 세미 맥스 알파값
    static let ALPHA_ZERO: CGFloat = 0.0 // 제로 알파값
    static let ALPHA_MAX: CGFloat = 1.0 // 맥스 알파값
    
    var dismissible: Bool = false // DISMISS 여부
    
    var parentController = UIViewController() // 부모 뷰 컨트롤러
    var loadingController = UIViewController() // 로딩 뷰 컨트롤러
    var loadingTimer: Timer! // 로딩 타이머
    
    // MARK: - UIViewController Life Cycle
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        if let controller = self as? ControllerType {
            self.title = controller.navigationTitle
            d("viewDidLoad() >> title: \(String(describing: self.title))")
            TAG = controller.navigationTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        setUpNavigationBar(self.title ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        d("viewDidLayoutSubviews() >> Start !!!")
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        d("viewDidAppear() >> Start !!!")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        d("viewWillDisappear() >> Start !!!")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        d("viewDidDisappear() >> Start !!!")
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        d("didReceiveMemoryWarning() >> Start !!!")
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        d("prepareForPopoverPresentation() >> Start !!!")
        self.setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_SEMI_MAX)
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        d("popoverPresentationControllerDidDismissPopover() >> Start !!!")
        self.setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_MAX)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        d("popoverPresentationControllerShouldDismissPopover() >> Start !!!")
        return self.dismissible
    }

    /**
     * 네비게이션바 설정
     *
     * @param title 타이틀
     */
    func setUpNavigationBar(_ title: String) {
        d("setUpNavigationBar() >> Start !!!")
        self.navigationController?.setNavigationBarHidden(false,
                                                          animated: true)
        if let color = ColorUtil.sharedInstance.hexString2UIColor(hexString: "#3766F2") {
            self.navigationController?.navigationBar.barTintColor = color
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
    }
    
    /**
     * 네비게이션바 숨김
     *
     */
    func setUpHiddenNavigationBar() {
        d("setUpHiddenNavigationBar() >> Start !!!")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /**
     * 메인 백그라운드 뷰 알파값 적용
     *
     * @param alpha 알파값
     */
    func setAlphaOfBackgroundViews(alpha: CGFloat) {
        d("setAlphaOfBackgroundViews() >> Start !!!")
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = alpha
            self.parentController.view.alpha = alpha
            self.navigationController?.navigationBar.alpha = alpha
        }
    }
    
    /**
     * 디버그
     *
     * @param msg 메시지
     */
    func d(_ msg: String) {
        LogUtil.d(msg: "\(self.TAG) \(msg)")
    }
}

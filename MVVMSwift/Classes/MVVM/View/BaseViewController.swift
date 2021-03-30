//
//  BaseViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

@_exported import Foundation
@_exported import SwiftUI
@_exported import UIKit
@_exported import WebKit

// RxSwift
@_exported import RxCocoa
@_exported import RxSwift
@_exported import RxViewController

@_exported import MaterialComponents.MaterialBottomSheet
@_exported import MessageUI

// KakaoTalk
@_exported import KakaoSDKUser
@_exported import RxKakaoSDKUser
@_exported import KakaoSDKTalk
@_exported import KakaoSDKLink
@_exported import RxKakaoSDKLink
@_exported import KakaoSDKAuth
@_exported import RxKakaoSDKAuth

class BaseViewController: UIViewController {
    var navTitle = "" // 네비게이션 타이틀
    var tag = "" // 디버그 태그
    
    static let ALPHA_SEMI_MAX: CGFloat = 0.5 // 세미 맥스 알파값
    static let ALPHA_ZERO: CGFloat = 0.0 // 제로 알파값
    static let ALPHA_MAX: CGFloat = 1.0 // 맥스 알파값
    
    var dismissible: Bool = false // DISMISS 여부
    
    var parentController = UIViewController() // 부모 뷰 컨트롤러
    var loadingController = UIViewController() // 로딩 뷰 컨트롤러
    var loadingTimer: Timer! // 로딩 타이머
    
    /**
     * 뷰 컨트롤러 초기화
     *
     * @param viewController 뷰 컨틀러
     * @param navTitle 네비게이션 타이틀
     * @param tag 디버그 태그
     */
    func initViewController(_ viewController: UIViewController,
                            navTitle: String,
                            tag: String) {
        
        d("initViewController() >> controller: \(viewController)")
        d("initViewController() >> navTitle: \(navTitle)")
        d("initViewController() >> tag: \(tag)")
        
        setTag(tag)
        setTitle(navTitle)
        parentController = viewController
    }
    
    // MARK: - UIViewController Life Cycle
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
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
    
    // MARK: - Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        // 키보드 내리기
        self.view.endEditing(true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
    }
    
    // MARK: - Function
    
    /**
     * 네비게이션바 설정
     *
     * @param barTintColor 네비게이션바 색상 (String)
     */
    func setUpNavigationBar(_ barTintColor: String) {
        d("setUpNavigationBar() >> Start !!!")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        d("setUpNavigationBar() >> navTitle: \(navTitle)")
        d("setUpNavigationBar() >> barTintColor: \(barTintColor)")
        
        if let color = barTintColor.hexString2UIColor() {
            self.navigationController?.navigationBar.barTintColor = color
            d("setUpNavigationBar() >> color: \(color)")
        }

        if navTitle.isEmpty {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationItem.title = navTitle
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationItem.title = navTitle
        }
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
     * 백버튼 추가 (이미지)
     *
     * @param title 타이틀
     */
    func addBackButton() {
        d("addBackButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        let image: UIImage = UIImage(named: "BackWhite") ?? UIImage()
        button.setImage(image, for: .normal)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self,action: #selector(self.actionBack(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 백버튼 추가 (이미지)
     *
     * @param title 타이틀
     */
    func addBackButton(_ image: UIImage) {
        d("addBackButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self,action: #selector(self.actionBack(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 백버튼 추가 (텍스트)
     *
     * @param title 타이틀
     */
    func addBackButton(_ title: String) {
        d("addBackButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        if !title.isEmpty {
            button.addTarget(self,action: #selector(self.actionBack(_:)), for: .touchUpInside)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 닫기 버튼 추가 (이미지)
     *
     * @param title 타이틀
     */
    func addCloseButton() {
        d("addCloseButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        let image: UIImage = UIImage(named: "CloseBlack") ?? UIImage()
        button.setImage(image, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.actionClose(_:)), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 닫기 버튼 추가
     *
     * @param title 타이틀
     */
    func addCloseButton(_ title: String) {
        d("addCloseButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.actionClose(_:)), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 닫기 버튼 추가
     *
     * @param title 타이틀
     */
    func addCloseButton(_ image: UIImage) {
        d("addCloseButton() >> Start !!!")
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(self.actionClose(_:)), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 오른쪽 버튼 추가 (텍스트)
     *
     * @param title 타이틀
     */
    func addRightButton(_ title: String) {
        d("addRightButton() >> Start !!!")
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        if let color = "#FFFFFF".hexString2UIColor() {
            button.setTitleColor(color, for: .normal)
        }
        button.titleLabel?.font = button.titleLabel?.font.withSize(14.0)
        button.addTarget(self,
                         action: #selector(self.actionRightButton(_:)),
                         for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 오른쪽 버튼 추가 (이미지)
     *
     * @param title 타이틀
     */
    func addRightButton(_ image: UIImage) {
        d("addRightButton() >> Start !!!")
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(self.actionRightButton(_:)), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /**
     * 타이틀 설정
     *
     * @param title 타이틀
     */
    func setTitle(_ title: String) {
        self.navTitle = title
    }
    
    /**
     * 태그 설정
     *
     * @param title 타이틀
     */
    func setTag(_ tag: String) {
        self.tag = tag
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
        LogUtil.sharedInstance.d("\(self.tag) \(msg)")
    }
    
    /**
     * 디버그 (유니코드 > 한글)
     *
     * @param msg 메시지
     */
    func koLog(_ msg: String) {
        d(LogUtil.sharedInstance.koLog("\(self.tag) \(msg)"))
    }
    
    /**
     * 아이디
     *
     * @returns id 아이디
     */
    func getId() -> String {
        return UserDefaultsUtil.sharedInstance.getStringValue(Key.ID)
    }
    
    /**
     * 비밀번호
     *
     * @returns pw 비밀번호
     */
    func getPw()-> String {
        return UserDefaultsUtil.sharedInstance.getStringValue(Key.PASSWD)
    }
    
    /**
     * 아이디
     *
     * @param id 아이디
     * @returns id 저장된 아이디
     */
    func setId(_ id: String) -> String {
        return UserDefaultsUtil.sharedInstance.setStringValue(Key.ID, value: id)
    }
    
    /**
     * 비밀번호
     *
     * @param pw 비밀번호
     * @returns pw 저장된 비밀번호
     */
    func setPw(_ pw: String)-> String {
        return UserDefaultsUtil.sharedInstance.setStringValue(Key.PASSWD, value: pw)
    }
    
    /**
     * 문자 반환
     */
    func getString(_ string: String) -> String {
        return "\(NSLocalizedString(string, comment: ""))"
    }
    
    /**
     * Roboto-Black
     *
     * @returns UIFont
     */
    func getRobotoBlack(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoBlack(size)
    }
    
    /**
     * Roboto-BlackItalic
     *
     * @returns UIFont
     */
    func getRobotoBlackItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoBlackItalic(size)
    }
    
    /**
     * Roboto-Bold
     *
     * @returns UIFont
     */
    func getRobotoBold(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoBold(size)
    }
    
    /**
     * Roboto-BoldItalic
     *
     * @returns UIFont
     */
    func getRobotoBoldItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoBoldItalic(size)
    }
    
    /**
     * Roboto-Italic
     *
     * @returns UIFont
     */
    func getRobotoItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoItalic(size)
    }
    
    /**
     * Roboto-Light
     *
     * @returns UIFont
     */
    func getRobotoLight(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoLight(size)
    }
    
    /**
     * Roboto-LightItalic
     *
     * @returns UIFont
     */
    func getRobotoLightItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoLightItalic(size)
    }
    
    /**
     * Roboto-Medium
     *
     * @returns UIFont
     */
    func getRobotoMedium(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoMedium(size)
    }
    
    /**
     * Roboto-MediumItalic
     *
     * @returns UIFont
     */
    func getRobotoMediumItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoMediumItalic(size)
    }

    /**
     * Roboto-Regular
     *
     * @returns UIFont
     */
    func getRobotoRegular(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoRegular(size)
    }
    
    /**
     * Roboto-Thin
     *
     * @returns UIFont
     */
    func getRobotoThin(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoThin(size)
    }
    
    /**
     * Roboto-ThinItalic
     *
     * @returns UIFont
     */
    func getRobotoThinItalic(_ size: Int) -> UIFont {
        return FontsUtil.sharedInstance.robotoThinItalic(size)
    }
    
    /**
     * 팝업
     *
     * @param title 타이틀
     * @param msg 메시지
     * @param contents 버튼 컨텐트
     * @returns completion (String)
     */
    func popupDialog(title: String,
                     msg: String,
                     contents: [String],
                     completion: @escaping (String) -> Void) {
        DialogUtil
            .sharedInstance
            .show(controller: parentController,
                  title: title,
                  message: msg,
                  contents: contents) { (content) in
                completion(content)
            }
    }
    
    /**
     * 로딩 프로그레스바 시작
     *
     */
    func startLoading() {
        self.d("startLoading() >> Start !!!")
        self.gotoPopOverLoadingViewController()
    }
    
    /**
     * 로딩 프로그레스바 종료
     *
     */
    func stopLoading() {
        self.d("stopLoading() >> Start !!!")
        self.loadingTimer?.invalidate()
        self.d("loadingController() >> \(loadingController)")
        
        // 프로그레스 다이얼로그 종료
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.5) { // 0.1초
                self.loadingController.dismiss(animated: false,
                                               completion: nil)
                self.setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_MAX)
            }
    }
    
    /**
     * 로딩 프로그레스바 시작 (GIF)
     *
     */
    func startAniLoading() {
        self.d("startAniLoading() >> Start !!!")
        self.gotoPopOverAniLoadingViewController()
    }
    
    /**
     * 로딩 프로그레스바 종료 (GIF)
     *
     */
    func stopAniLoading() {
        self.d("stopAniLoading() >> Start !!!")
        self.loadingTimer?.invalidate()
        self.d("loadingController() >> \(loadingController)")
        
        // 프로그레스 다이얼로그 종료
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.5) { // 0.1초
                self.loadingController.dismiss(animated: false,
                                               completion: nil)
                self.setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_MAX)
            }
    }
    
    /**
     * 뷰 컨트롤러 종료
     *
     *  @param animated 애니메이션 효과
     */
    func finish(_ animated: Bool) {
        // Controller 종료
        let _ = self.navigationController?.popViewController(animated: animated)
    }
    
    /**
     * 뷰 컨트롤러 종료
     *
     * @param isInit 데이터 초기화
     */
    func finishApp(_ isInit: Bool) {
        
        if isInit {
            UserDefaultsUtil.sharedInstance.clear()
        }
        
        // 앱 종료
        let appDelegate = AppDelegate()
        appDelegate.finishApp()
    }
    
    // MARK: - Action
    
    /**
     * 뒤로가기 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionBack(_ sender: UIButton) {
        d("actionBack() >> Start !!!")
        
        // Controller 종료
        self.finish(true)
    }
    
    /**
     * 닫기 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionClose(_ sender: UIButton) {
        d("actionClose() >> Start !!!")
        
        self.finish(false)
    }
    
    
    /**
     * 오른쪽 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionRightButton(_ sender: UIButton) {
        d("actionRightButton() >> Start !!!")
    }
    
    
    // MARK: - Move ViewController
    
    /**
     * 로딩 뷰 컨트롤러
     *
     */
    func gotoPopOverLoadingViewController() {
        self.d("gotoPopOverLoadingViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "PopOver", bundle: nil)
                let popOverLoadingViewController
                    = storyBoard.instantiateViewController(withIdentifier: "PopOverLoadingView") as! PopOverLoadingViewController
                popOverLoadingViewController.delegate = self
                popOverLoadingViewController.modalPresentationStyle
                    = UIModalPresentationStyle.popover
                popOverLoadingViewController.preferredContentSize
                    = CGSize(width: Define.LOADING_VIEW_WIDTH_SIZE,
                             height: Define.LOADING_VIEW_HEIGHT_SIZE)
                let popoverPresentationController
                    = popOverLoadingViewController.popoverPresentationController
                
                if let presentationController = popoverPresentationController {
                    self.d("gotoPopOverLoadingViewController() >> presentationController: \(presentationController)")
                    self.d("gotoPopOverLoadingViewController() >> navigationController: \(String(describing: self.navigationController))")
                    presentationController.delegate = self
                    presentationController.sourceView = self.navigationController?.view
                    presentationController.passthroughViews = nil
                    presentationController.sourceRect
                        = CGRect(x: self.view.bounds.midX,
                                 y: self.view.bounds.midY,
                                 width: 0,
                                 height: 0)
                    presentationController.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
                }
                self.present(popOverLoadingViewController, animated: false, completion: nil)
            }
    }
    
    /**
     * 로딩 뷰 컨트롤러 (GIF)
     *
     */
    func gotoPopOverAniLoadingViewController() {
        self.d("gotoPopOverAniLoadingViewController() >> Start !!!")
        OperationQueue.main.addOperation {
            let storyBoard: UIStoryboard = UIStoryboard(name: "PopOver", bundle: nil)
            let popOverAniLoadingViewController = storyBoard.instantiateViewController(withIdentifier: "PopOverAniLoadingView") as! PopOverAniLoadingViewController
            popOverAniLoadingViewController.delegate = self
            popOverAniLoadingViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popOverAniLoadingViewController.preferredContentSize
                = CGSize(width: Define.LOADING_VIEW_WIDTH_SIZE,
                         height: Define.LOADING_VIEW_HEIGHT_SIZE)
            let popoverPresentationController = popOverAniLoadingViewController.popoverPresentationController
            
            if let presentationController = popoverPresentationController {
                presentationController.delegate = self
                presentationController.sourceView = self.view
                presentationController.passthroughViews = nil
                presentationController.sourceRect
                    = CGRect(x: self.view.bounds.midX,
                             y: self.view.bounds.midY,
                             width: 0,
                             height: 0)
                presentationController.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
            }
            self.present(popOverAniLoadingViewController, animated: true, completion: nil)
        }
    }
    
    /**
     * Botom Sheet 컨틀롤러 이동
     *
     */
    func gotoBottomSheetViewController<T>(name: String!,
                                          withIdentifier: String!,
                                          of theClass: T,
                                          height: CGFloat,
                                          animated: Bool,
                                          completion: @escaping (T) -> Void) {
        d("gotoBottomSheetViewController() >> Start !!!")
        
        DispatchQueue
            .main
            .async {
                if let controller
                    = UIStoryboard(name: name,
                                   bundle: nil).instantiateViewController(withIdentifier: withIdentifier) as? T {
                    self.d("gotoViewController() >> controller: \(controller)")
                    let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: controller as! UIViewController)
                    bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: height)
                    bottomSheet.dismissOnDraggingDownSheet = false
                    self.present(bottomSheet, animated: true, completion: nil)
                }
            }
    }
    
    /**
     * Botom Sheet 컨틀롤러 이동
     *
     */
    func gotoBottomSheetViewController<T>(identifier: String!,
                                          of theClass: T,
                                          height: CGFloat,
                                          animated: Bool,
                                          completion: @escaping (T) -> Void) {
        d("gotoBottomSheetViewController() >> Start !!!")
        
        DispatchQueue
            .main
            .async {
                if let contrroller
                    = UIStoryboard(name: "BottomSheet",
                                   bundle: nil).instantiateViewController(withIdentifier: identifier) as? T {
                    
                    let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: contrroller as! UIViewController)
                    bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: height)
                    bottomSheet.dismissOnDraggingDownSheet = false
                    self.present(bottomSheet, animated: true, completion: nil)
                    
                }
            }
    }

    /**
     * 뷰 컨틀로러 이동
     *
     * @param name 스토리보드 이름
     * @param withIdentifier 뷰 컨틀롤러 식별자
     * @param of theClass 타겟 클래스
     * @param animated 애니메이션 적용 여부
     * @return completion 뷰컨트롤러
     */
    func gotoViewController<T>(name: String!,
                               withIdentifier: String!,
                               of theClass: T,
                               animated: Bool,
                               completion: @escaping (T) -> Void) {
        DispatchQueue
            .main
            .async {
                if let controller
                    = UIStoryboard(name: name,
                                   bundle: nil).instantiateViewController(withIdentifier: withIdentifier) as? T {
                    self.d("gotoViewController() >> controller: \(controller)")
                    if let navigationController = self.navigationController {
                        self.d("gotoViewController() >> navigationController: \(navigationController)")
                        navigationController.pushViewController(controller as! UIViewController, animated: animated)
                        completion(controller)
                    }
                }
            }
    }
    
    /**
     * 뷰 컨틀로러 이동
     *
     * @param withIdentifier 뷰 컨틀롤러 식별자
     * @param of theClass 타겟 클래스
     * @param animated 애니메이션 적용 여부
     * @return completion 뷰컨트롤러
     */
    func gotoViewController(identifier: String!,
                            animated: Bool,
                            completion: @escaping (UIViewController) -> Void) {
        d("gotoViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier) else {
                    return
                }
                if let navigationController = self.navigationController {
                    self.d("gotoViewController() >> navigationController: \(navigationController)")
                    navigationController.pushViewController(controller, animated: animated)
                    completion(controller)
                }
            }
    }
    
    /**
     * View Controller
     *
     * @return UIViewController
     */
    func getViewController() -> UIViewController? {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            print("CFBundleName - \(appName)")
            if let viewControllerType = NSClassFromString("\(appName).\(self)") as? UIViewController.Type {
                return viewControllerType.init()
            }
        }
        return nil
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension BaseViewController: UIPopoverPresentationControllerDelegate {

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        d("prepareForPopoverPresentation() >> Start !!!")
        setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_SEMI_MAX)
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        d("popoverPresentationControllerDidDismissPopover() >> Start !!!")
        setAlphaOfBackgroundViews(alpha: BaseViewController.ALPHA_MAX)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        d("popoverPresentationControllerShouldDismissPopover() >> Start !!!")
        return dismissible
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

// MARK: - LoadingView Delegate

extension BaseViewController: PopOverLoadingViewDelegate {
    func PopOverLoadingViewDelegate(controller: PopOverLoadingViewController,
                                    loadingType: Enum.LoadingType) {
        d("PopOverLoadingViewDelegate() >> controller: \(controller)")
        d("PopOverLoadingViewDelegate() >> loadingType: \(loadingType)")
        
        self.loadingController = controller
        self.loadingTimer = Timer.scheduledTimer(withTimeInterval: Define.LOADING_INTERVAL,
                                                 repeats: false,
                                                 block: { timer in
                                                    self.stopLoading()
                                                 })
    }
}

// MARK: - AniLoadingView Delegate

extension BaseViewController: PopOverAniLoadingViewDelegate {
    func PopOverAniLoadingViewDelegate(controller: PopOverAniLoadingViewController,
                                       loadingType: Enum.LoadingType) {
        d("PopOverAniLoadingViewDelegate() >> controller: \(controller)")
        d("PopOverAniLoadingViewDelegate() >> loadingType: \(loadingType)")
        
        self.loadingController = controller
        self.loadingTimer = Timer.scheduledTimer(withTimeInterval: Define.LOADING_INTERVAL,
                                                 repeats: false,
                                                 block: { timer in
                                                    self.stopLoading()
                                                 })
    }
}

// MARK: - UITextField Delegate

extension BaseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        d("textFieldShouldReturn() >> textField: \(textField)")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        d("textFieldDidEndEditing() >> textField: \(textField)")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        d("textFieldDidBeginEditing() >> textField: \(textField)")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        d("textFieldDidChangeSelection() >> textField: \(textField)")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        d("textFieldShouldClear() >> textField: \(textField)")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        d("textFieldShouldEndEditing() >> textField: \(textField)")
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        d("textFieldShouldBeginEditing() >> textField: \(textField)")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        d("textFieldDidEndEditing() >> textField: \(textField)")
        d("textFieldDidEndEditing() >> reason: \(reason)")
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        d("textField() >> textField: \(textField)")
        d("textField() >> range: \(range)")
        d("textField() >> string: \(string)")
        return true
    }
}





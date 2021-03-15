//
//  ViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

import UIKit

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// Communication
import Alamofire

// BottomSheet
import MaterialComponents.MaterialBottomSheet

protocol MainViewDelegate: NSObjectProtocol {
    
    /**
     * 메인 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func MainViewDelegate(controller: MainViewController)
}

/**
 * MainViewController.swift
 *
 * @description 메인 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class MainViewController: BaseViewController {
    
    var delegate: MainViewDelegate? // 델리게이트
    var viewModel = MainViewModel() // 뷰 모델

    @IBOutlet weak var btnWebView: UIButton?
    @IBOutlet weak var btnTableView: UIButton?
    @IBOutlet weak var btnDataCore: UIButton?
    @IBOutlet weak var btnRealm: UIButton?
    @IBOutlet weak var btnSendMessage: UIButton?
    @IBOutlet weak var btnCameraGallery: UIButton?
    @IBOutlet weak var btnSettings: UIButton?

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: getString("Main"),
                                tag: getString("[Main]"))
        
        // 뒤로가기 버튼
        self.addBackButton()
        
        // 닫기 버튼
        let image = UIImage(named: "SettingsBlack") ?? UIImage()
        self.addRightButton(image)
        
        // 버튼 라운드 설정
        if let color = "#3766F2".hexString2UIColor() {
            btnWebView?.addRound(8, color: color, width: 0.1)
            btnTableView?.addRound(8, color: color, width: 0.1)
            btnDataCore?.addRound(8, color: color, width: 0.1)
            btnRealm?.addRound(8, color: color, width: 0.1)
            btnSendMessage?.addRound(8, color: color, width: 0.1)
            btnCameraGallery?.addRound(8, color: color, width: 0.1)
            btnSettings?.addRound(8, color: color, width: 0.1)
        }

        // Version
//        var parameters: Parameters = Parameters.init()
//        parameters[Key.MOBILE_TYPE] = "A"
//        parameters[Key.PUSH_TOKEN] = "dEWiunazakvqqNsmQgadHI:APA91bE2YNFTTM8Yh_qmK3RQ5l8zzzzk_fP6FCM5LIQC_TY7a1sVfNwuDDZnqizVvZn5ieagARvt3LBraf_-F2UY3kcqgjum0vsbbQM28pfy_ny_kwNOaEi4yCfnYIQ0MF27KHkwIsBD"
//        d("getListData() >> parameters: \(parameters)")
//
//        viewModel.getVersion(view: self, parameters: parameters) { (result, version, msg) in
//            self.d("getVersion() >> result: \(result)")
//            self.d("getVersion() >> version: \(version)")
//            self.d("getVersion() >> msg: \(msg)")
//        }
        
        // Check Duplicate id
//        parameters = Parameters.init()
//        parameters[Key.APP_TYPE] = Define.APP_TYPE
//        parameters[Key.TN] = Define.TN_ID
//        parameters[Key.MEM_ID] = "test01"
//        d("getDuplicateCheckId() >> parameters: \(parameters)")
//        viewModel.getDuplicateCheckId(view: self,
//                                      parameters: parameters) { (result, version, msg) in
//            self.d("getDuplicateCheckId() >> result: \(result)")
//            self.d("getDuplicateCheckId() >> version: \(version)")
//            self.d("getDuplicateCheckId() >> msg: \(msg)")
//        }
        
        // Request List
//        parameters = Parameters.init()
//        parameters[Key.TN] = Define.TN_LIST
//        parameters[Key.MEM_IDX] = 65
//        parameters[Key.CATE_MAIN] = "001"
//        parameters[Key.CATE_SUB] = "001002"
//        parameters[Key.PAGE] = 1
//        parameters[Key.LIMIT] = 20
//        d("getListData() >> parameters: \(parameters)")
//
//        viewModel.getListData(view: self, parameters: parameters) { (result, datas, msg) in
//            self.d("getListData() >> result: \(result)")
//            self.d("getListData() >> datass: \(datas)")
//            self.d("getListData() >> msg: \(msg)")
//
//            for data in datas {
//                self.d("getListData() >> idx: \(data.idx)")
//                self.d("getListData() >> intro_img: \(data.intro_img)")
//                self.d("getListData() >> store_name: \(data.store_name)")
//                self.d("getListData() >> store_name: \(data.store_name)")
//                self.d("getListData() >> store_addr: \(data.store_addr)")
//                self.d("getListData() >> map_x: \(data.map_x)")
//                self.d("getListData() >> map_y: \(data.map_y)")
//            }
//        }
        
        delegate?.MainViewDelegate(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바
        setUpNavigationBar("", barTintColor: .white)
    }
    
    // MARK: - Action
    
    override func actionRightButton(_ sender: UIButton) {
        d("actionRightButton() >> Start !!!")
        
        self.gotoViewController(name: Define.SB_NAME_MAIN,
                                withIdentifier: Define.VC_NAME_SETTINGSVIEW,
                                of: SettingsViewController(),
                                animated: true) { (controller) in
            self.d("actionRightButton() >> controller: \(controller)")
            controller.delegate = self
        }
    }
    
    /**
     * 웹 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionWebView(sender: UIButton) {
        d("actionWebView() >> Start !!!")
        
        gotoWebViewController()
    }
    
    /**
     * 테이블 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionTableView(sender: UIButton) {
        d("actionTableView() >> Start !!!")
        
        gotoTableViewController()
    }
    
    /**
     * 설정 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionSettingsView(sender: UIButton) {
        d("actionSettingsView() >> Start !!!")
        
        gotoSettingsViewController()
    }
    
    /**
     * 코어 데이터 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionCoreDataView(sender: UIButton) {
        d("actionCoreDataView() >> Start !!!")
        
        gotoCoreDataViewController()
    }
    
    /**
     * 렐름 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionRealmView(sender: UIButton) {
        d("actionRealmView() >> Start !!!")
        
        gotoRealmViewController()
    }
    
    /**
     * 메시지 보내기 팝업 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionPopupSendMessage(sender: UIButton) {
        d("actionPopupSendMessage() >> Start !!!")
        
        // Short URL
//        URLShortener.sharedInstance.getUrl(url: "http://crecolto.com/") { (result, shortUrl) in
//            self.d("actionPopupSendMessage() >> shortUrl: \(shortUrl)")
//        }
        
        // 메시지 보내기 뷰 컨틀롤러 이동
        gotoMessageViewController()
    }
    
    /**
     * 선택 팝업 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionPopupSelect(sender: UIButton) {
        d("actionPopupSelect() >> Start !!!")
        
        gotoCameraViewController()
    }
    
    // MARK: - Move ViewController
    
    /**
     * 웹 뷰 컨틀롤러 이동
     *
     */
    func gotoWebViewController() {
        d("gotoWebViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let webView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_WEBVIEW) else {
                    return
                }
                self.navigationController?.pushViewController(webView,
                                                              animated: true)
            }
    }
    
    /**
     * 테이블 뷰 컨틀롤러 이동
     *
     */
    func gotoTableViewController() {
        d("gotoTableViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let tableView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_TABLEVIEW) else {
                    return
                }
                self.navigationController?.pushViewController(tableView,
                                                              animated: true)
            }
    }
    
    /**
     * 설정 뷰 컨틀롤러 이동
     *
     */
    func gotoSettingsViewController() {
        d("gotoSettingsViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let settingView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_SETTINGSVIEW) else {
                    return
                }
                self.navigationController?.pushViewController(settingView,
                                                              animated: true)
            }
    }
    
    /**
     * 코어 데이터 뷰 컨틀롤러 이동
     *
     */
    func gotoCoreDataViewController() {
        d("gotoCoreDataViewController() >> Start !!!")
        
        DispatchQueue.main.async {
            if let coreDataViewController = UIStoryboard(name: Define.SB_NAME_MAIN,
                                                     bundle: nil).instantiateViewController(withIdentifier: Define.VC_NAME_COREDATAVIEW) as? CoreDataViewController {
                self.d("gotoCoreDataViewController() >> coreDataViewController: \(coreDataViewController)")
                
                if let navigationController = self.navigationController {
                    self.d("gotoCoreDataViewController() >> navigationController: \(navigationController)")
                    navigationController.pushViewController(coreDataViewController,
                                                            animated: true)
                }
            }
        }
    }
    
    /**
     * 렐름 뷰 컨틀롤러 이동
     *
     */
    func gotoRealmViewController() {
        d("gotoRealmViewController() >> Start !!!")
        
        DispatchQueue.main.async {
            if let realmViewController = UIStoryboard(name: Define.SB_NAME_MAIN,
                                                     bundle: nil).instantiateViewController(withIdentifier: Define.VC_NAME_REALMVIEW) as? RealmViewController {
                self.d("gotoRealmViewController() >> realmViewController: \(realmViewController)")
                
                if let navigationController = self.navigationController {
                    self.d("gotoRealmViewController() >> navigationController: \(navigationController)")
                    navigationController.pushViewController(realmViewController,
                                                            animated: true)
                }
            }
        }
    }
    
    /**
     * 메시지 보내기 뷰 컨틀롤러 이동
     *
     */
    func gotoMessageViewController() {
        d("gotoMessageViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let messageView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_MESSAGEVIEW) else {
                    return
                }
                self.navigationController?.pushViewController(messageView,
                                                              animated: true)
            }
    }
    
    /**
     * 카메라 뷰 컨틀롤러 이동
     *
     */
    func gotoCameraViewController() {
        d("gotoCameraViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let cameraView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_CAMERAVIEW) else {
                    return
                }
                self.navigationController?.pushViewController(cameraView,
                                                              animated: true)
            }
    }
}

// MARK: - SettingsView Delegate

extension MainViewController: SettingsViewDelegate {
    func SettingsViewDelegate(controller: SettingsViewController) {
        d("SettingsViewDelegate() >> Start !!!")
    }
}

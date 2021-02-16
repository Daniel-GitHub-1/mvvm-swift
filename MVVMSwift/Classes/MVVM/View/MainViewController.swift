//
//  ViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import RxCocoa
import RxSwift
import RxViewController
import UIKit
import Alamofire

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

    @IBOutlet weak var tableView: UITableView! // 테이블 뷰

    var delegate: MainViewDelegate? // 델리게이트
    var viewModel = MainViewModel() // 뷰 모델
    let disposeBag = DisposeBag() // Observable 해제

    var navigationTitle: String { // 네비게이션 타이틀
        return "[Main]"
    }

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
//        var parameters: Parameters = Parameters.init()
        
        // Version
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
        
        // 웹 뷰 컨틀롤러 이동
        gotoWebViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpHiddenNavigationBar()
    }
    
    
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
}

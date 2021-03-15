//
//  RealmViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/15.
//

import UIKit

/**
 * RealmViewController.swift
 *
 * @description 렐름 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class RealmViewController: BaseViewController {

    var viewModel = RealmViewModel() // 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 디버그 태그
        setTag("[\(NSLocalizedString("Realm", comment: ""))]")
        
        // 네비게이션 타이틀
        setTitle(NSLocalizedString("Realm", comment: ""))
        
        // 뒤로가기 버튼
        self.addBackButton()
        
//        for i in 0 ..< 10 {
//            let dateRealm = DateRealm()
//            dateRealm.year = "2021"
//            dateRealm.month = "02"
//            dateRealm.day = "\(i+1)"
//            d("viewDidLoad() >> dateRealm: \(dateRealm)")
//            
//            viewModel.setDate(dateRealm: dateRealm) { (success, msg) in
//                self.d("viewDidLoad() >> success: \(success)")
//                self.d("viewDidLoad() >> msg: \(msg)")
//            }
//        }
        
        // 데이터 리스트
        let dates = viewModel.getAllDate()
        for date in dates {
            self.d("viewDidLoad() >> day: \(date.day)")
        }
    }
}


//
//  IntroViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import RxCocoa
import RxSwift
import RxViewController
import UIKit

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
class IntroViewController: BaseViewController, ControllerType, MainViewDelegate {
    
    /**
     * 메인 델리게이트
     *
     * @param controller 컨트롤러
     */
    func MainViewDelegate(controller: MainViewController) {
        d("MainViewDelegate() >> Start !!!")
    }
    
    var viewModel = IntroViewModel() // 뷰 모델

    var navigationTitle: String { // 네비게이션 타이틀
        return "[Intro]"
    }

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 1.0) {
                
                // 메인 뷰 컨틀롤러 이동
                self.gotoMainViewController()
                
                // TODO 테스트
//                self.gotoCoreDataViewController()
                
                // TODO 테스트
//                self.gotoRealmViewController()
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpHiddenNavigationBar()
    }
    
    /**
     * 메인 뷰 컨틀롤러 이동
     *
     */
    func gotoMainViewController() {
        d("gotoMainViewController() >> Start !!!")
        
        DispatchQueue.main.async {
            if let mainViewController = UIStoryboard(name: Define.SB_NAME_MAIN,
                                                     bundle: nil).instantiateViewController(withIdentifier: Define.VC_NAME_MAINVIEW) as? MainViewController {
                print("\(self.TAG) gotoMainViewController() >> mainViewController: \(mainViewController)")
                
                if let navigationController = self.navigationController {
                    print("\(self.TAG) gotoMainViewController() >> navigationController: \(navigationController)")
                    mainViewController.delegate = self
                    navigationController.pushViewController(mainViewController,
                                                            animated: false)
                }
            }
        }
    }
    
    /**
     * 메인 뷰 컨틀롤러 이동
     *
     */
//    func gotoMainViewController() {
//        d("gotoMainViewController() >> Start !!!")
//        DispatchQueue
//            .main
//            .async {
//                guard let mainView = self.storyboard?.instantiateViewController(withIdentifier: Define.VC_NAME_MAIN) else {
//                    return
//                }
//                self.navigationController?.pushViewController(mainView,
//                                                              animated: true)
//            }
//    }
    
    /**
     * 코어 데이터 뷰 컨틀롤러 이동
     *
     */
    func gotoCoreDataViewController() {
        d("gotoCoreDataViewController() >> Start !!!")
        
        DispatchQueue.main.async {
            if let coreDataViewController = UIStoryboard(name: Define.SB_NAME_MAIN,
                                                     bundle: nil).instantiateViewController(withIdentifier: Define.VC_NAME_COREDATAVIEW) as? CoreDataViewController {
                print("\(self.TAG) gotoCoreDataViewController() >> coreDataViewController: \(coreDataViewController)")
                
                if let navigationController = self.navigationController {
                    print("\(self.TAG) gotoCoreDataViewController() >> navigationController: \(navigationController)")
                    navigationController.pushViewController(coreDataViewController,
                                                            animated: false)
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
                print("\(self.TAG) gotoRealmViewController() >> realmViewController: \(realmViewController)")
                
                if let navigationController = self.navigationController {
                    print("\(self.TAG) gotoRealmViewController() >> navigationController: \(navigationController)")
                    navigationController.pushViewController(realmViewController,
                                                            animated: false)
                }
            }
        }
    }
}


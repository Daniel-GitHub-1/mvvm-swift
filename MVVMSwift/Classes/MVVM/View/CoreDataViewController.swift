//
//  CoreDataViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/15.
//

import Foundation

/**
 * CoreDataViewController.swift
 *
 * @description 코어 데이터 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class CoreDataViewController: BaseViewController {
  
    var viewModel = CoreDataViewModel() // 뷰 모델
    
    var navigationTitle: String { // 네비게이션 타이틀
        return "[CoreData]"
    }
    
    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")

//        for _ in 0 ..< 10 {
//            let name = viewModel.getRandomName()
//            var dictionary: [String : Any] = [:]
//            dictionary[Define.NAME] = name
//            dictionary[Define.EMAIL] = "\(name)@test.com"
//            dictionary[Define.HP] = viewModel.getRandomHpNumber()
//            dictionary[Define.DEVICES] = [Devices.iPhone, Devices.MacBook]
//            d("viewDidLoad() >> dictionary: \(dictionary)")
//
//            viewModel.setUser(dictionary) { (success, msg) in
//                self.d("viewDidLoad() >> success: \(success)")
//                self.d("viewDidLoad() >> msg: \(msg)")
//            }
//        }

        viewModel.getAllUsers { (success, users) in
            self.d("getAllUsers() >> success: \(success)")
            self.d("getAllUsers() >> users: \(users)")
            for user in users {
                self.d("getAllUsers() >> id: \(user.id)")
                self.d("getAllUsers() >> name: \(String(describing: user.name))")
                self.d("getAllUsers() >> email: \(String(describing: user.email))")
                self.d("getAllUsers() >> devices: \(String(describing: user.devices))")
                
                for (_, device) in user.devices!.enumerated() {
                    self.d("getAllUsers() >> device: \(String(describing: device))")
                }
            }
        }
    }
}

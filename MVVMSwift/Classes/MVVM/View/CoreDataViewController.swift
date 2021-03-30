//
//  CoreDataViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/15.
//

class CoreDataViewController: BaseViewController {
  
    var viewModel = CoreDataViewModel() // 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: getString("CoreData"),
                                tag:"[\(getString("CoreData"))]")
        
        // 뒤로가기 버튼
        self.addBackButton()

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

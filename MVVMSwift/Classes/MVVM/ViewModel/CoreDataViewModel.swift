//
//  CoreDataViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/15.
//

class CoreDataViewModel: BaseViewModel {
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[CoreDataViewModel]")
    }

    /**
     * 사용자 리스트
     *
     * @return completion (Bool, [Users])
     */
    func getAllUsers(completion: @escaping (Bool, [Users]) -> ()) {
        let users: [Users] = CoreDataManager.sharedInstance.getUsers()
        completion(true, users)
    }
    
    /**
     * 사용자 추가
     *
     * @param dictionary NSDictionary
     * @return completion (Bool, String)
     */
    func setUser(_ dictionary: [String : Any],
                 completion: @escaping (Bool, String) -> ()) {
        
        CoreDataManager.sharedInstance.setUser(id: Int64(getAutoIncremenet()),
                                               name: dictionary[Key.NAME] as? String ?? "",
                                               email: dictionary[Key.EMAIL] as? String ?? "",
                                               hp: dictionary[Key.HP] as? String ?? "",
                                               devices: dictionary[Key.DEVICES] as? [String] ?? []) { (success) in
            self.d("setUser() >> success: \((success))")
            completion(success, "")
        }
    }
    
    /**
     * 사용자 삭제
     *
     * @param id 아이디
     * @return completion (Bool, String)
     */
    func deleteUser(_ id: Int64,
                    completion: @escaping (Bool, String) -> ()) {
        CoreDataManager.sharedInstance.deleteUser(id: id) { success in
            self.d("deleteUser() >> success: \((success))")
            
            completion(success, "")
        }
    }
    
    /**
     * 자동 증가값
     *
     * @return index Int
     */
    func getAutoIncremenet() -> Int {
        return CoreDataManager.sharedInstance.getAutoIncremenet()
    }
    
    /**
     * 랜덤 휴대 전화번호
     * (010XXXXXXXX)
     *
     * @return hp Int
     */
    func getRandomHpNumber() -> String {
        var hp = "010"
        for _ in 0 ..< 8 {
            let randomNo: UInt32 = arc4random_uniform(10)
            hp = ("\(hp)\(randomNo)")
        }
        return hp
    }
    
    /**
     * 랜덤 이름
     * (xxxx)
     *
     * @return name String
     */
    func getRandomName() -> String {
//      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<4).map{ _ in letters.randomElement()! })
    }
}

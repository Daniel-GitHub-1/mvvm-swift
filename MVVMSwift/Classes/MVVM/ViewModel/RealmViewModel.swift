//
//  RealmViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/15.
//

// Realm
import RealmSwift

class RealmViewModel: BaseViewModel {
    private let realm = try! Realm() // 렐름
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[RealmViewModel]")
    }
    
    /**
     * 날짜 저장
     *
     * @param dateRealm DateRealm
     * @return completion (Bool, String)
     */
    func setDate(dateRealm: DateRealm,
                 completion: @escaping (Bool, String) -> ()) {
        try! realm.write {
            realm.add(dateRealm)
            completion(true, "")
        }
        completion(false, "")
    }
    
    /**
     * 모든 날짜
     *
     * @return completion (Bool, String)
     */
    func getAllDate() -> Results<DateRealm> {
        let list = realm.objects(DateRealm.self)
//        print(list.sorted(byKeyPath: "day", ascending: true))
//        print(list.filter("day == '07'"))
        return list
    }
    
    /**
     * 날짜 삭제
     *
     * @param year 년
     * @param month 월
     * @param day 일
     * @return completion (Bool, String)
     */
    func deleteDate(year: String,
                    month: String,
                    day: String,
                    completion: @escaping (Bool, String) -> ()) {
        do {
            try realm.write{
                let predicate = NSPredicate(format: "year = %@ AND month = %@ AND day = %@", year, month, day)
                realm.delete(realm.objects(DateRealm.self).filter(predicate))
                completion(true, "")
            }
        } catch{ print("\(error)") }
        completion(false, "")
    }
}

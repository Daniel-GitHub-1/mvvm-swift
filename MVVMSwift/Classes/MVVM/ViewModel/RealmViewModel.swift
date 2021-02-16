//
//  RealmViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/15.
//

import RealmSwift

/**
 * RealmViewModel.swift
 *
 * @description 렐름 뷰 모델
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class RealmViewModel {
    var TAG = "[RealmViewModel]" // 디버그 태그
    let realm = try! Realm() // 렐름
    
    /**
     * 날짜 저장
     *
     * @param dateRealm DateRealm
     * @return onResult (Bool, String)
     */
    func setDate(dateRealm: DateRealm,
                 onResult: @escaping (Bool, String) -> ()) {
        try! realm.write {
            realm.add(dateRealm)
            onResult(true, "")
        }
        onResult(false, "")
    }
    
    /**
     * 모든 날짜
     *
     * @return onResult (Bool, String)
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
                    onResult: @escaping (Bool, String) -> ()) {
        do {
            try realm.write{
                let predicate = NSPredicate(format: "year = %@ AND month = %@ AND day = %@", year, month, day)
                realm.delete(realm.objects(DateRealm.self).filter(predicate))
                onResult(true, "")
            }
        } catch{ print("\(error)") }
        onResult(false, "")
    }
}

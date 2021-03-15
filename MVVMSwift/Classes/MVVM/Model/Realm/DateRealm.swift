//
//  DateRealm.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/15.
//

import RealmSwift

class DateRealm: Object {
    @objc dynamic var year = ""
    @objc dynamic var month = ""
    @objc dynamic var day = ""
}

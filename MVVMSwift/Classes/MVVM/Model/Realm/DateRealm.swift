//
//  DateRealm.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/15.
//

import RealmSwift

/**
 * DateRealm.swift
 *
 * @description 날짜 렐름
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class DateRealm: Object {
    @objc dynamic var year = ""
    @objc dynamic var month = ""
    @objc dynamic var day = ""
}

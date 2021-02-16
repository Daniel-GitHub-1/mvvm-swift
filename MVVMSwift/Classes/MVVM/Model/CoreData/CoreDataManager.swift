//
//  CoreDataManager.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/15.
//

import UIKit
import CoreData

/**
 * CoreDataManager.swift
 *
 * @description Core Data Manager
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class CoreDataManager {
    let TAG: String = "[CoreDataManager]" // 디버그 태그
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate // 앱 델리게이트
    lazy var context = appDelegate?.persistentContainer.viewContext // 컨텍스트
    let modelName = Define.MODEL_NAME // 모델명
    
    static let sharedInstance = CoreDataManager() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 사용자 리스트
     *
     * @param ascending 정렬 (ASC, DESC)
     * @return [Users]
     */
    func getUsers(ascending: Bool = false) -> [Users] {
        var models: [Users] = [Users]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Users] = try context.fetch(fetchRequest) as? [Users] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("\(TAG) Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    /**
     * 사용자 저장
     *
     * @param id 인덱스
     * @param name 이름
     * @param email 이메일
     * @param hp 휴대 전화번호
     * @param devices 디바이스
     * @return onSuccess 결과 (true, false)
     */
    func setUser(id: Int64,
                 name: String,
                 email: String,
                 hp: String,
                 devices: [String],
                 onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
           let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName,
                                         in: context) {
            
            if let user: Users = NSManagedObject(entity: entity,
                                                 insertInto: context) as? Users {
                user.id = id
                user.name = name
                user.email = email
                user.hp = hp
                user.devices = devices
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    /**
     * 사용자 삭제
     *
     * @param id 인덱스
     * @return onSuccess 결과 (true, false)
     */
    func deleteUser(id: Int64,
                    onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results: [Users] = try context?.fetch(fetchRequest) as? [Users] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("\(TAG) Could not delete: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        
        contextSave { success in
            onSuccess(success)
        }
    }
    
    /**
     * 자동 증가값
     *
     * @return recordID Int
     */
    func getAutoIncremenet() -> Int {
        var recordID = 1
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Users] = try context.fetch(fetchRequest) as? [Users] {
                    if let lastRecordID = fetchResult.first?.id {
                        recordID = Int(lastRecordID) + 1
                    }
                }
            } catch let error as NSError {
                print("\(TAG) Could not get AutoIncremenet: \(error), \(error.userInfo)")
            }
        }
        return recordID
    }
}

extension CoreDataManager {
    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("\(TAG) Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}

//
//  EmpCoreData.swift
//  EmployeeManager
//
//  Created by Huy Ong on 9/29/19.
//  Copyright © 2019 Huy Ong. All rights reserved.
//

import CoreData

public class EmpItem: NSManagedObject, Identifiable {
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var jobTitle: String?
    @NSManaged public var isMale: Bool
}

extension EmpItem {
    static func getAllToDoItem() -> NSFetchRequest<EmpItem> {
        let request: NSFetchRequest<EmpItem> = EmpItem.fetchRequest() as! NSFetchRequest<EmpItem>
        
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

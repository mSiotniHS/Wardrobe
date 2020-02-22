//
//  Look.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 22/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import Foundation
import CoreData

public class Look: NSManagedObject, Identifiable {
    @NSManaged public var id      : UUID?
    
    @NSManaged public var label   : String?
    @NSManaged public var style   : String?
    @NSManaged public var season  : String?
    
    static func getAllLooks() -> NSFetchRequest<Look> {
        let request: NSFetchRequest<Look> = Look.fetchRequest() as! NSFetchRequest<Look>
        
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

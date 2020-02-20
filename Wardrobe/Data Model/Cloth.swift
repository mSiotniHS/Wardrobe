//
//  Cloth.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import Foundation
import CoreData

public class Cloth: NSManagedObject, Identifiable {
    @NSManaged public var id        : UUID?
    
    @NSManaged public var label     : String?
    @NSManaged public var brand     : String?
    @NSManaged var type             : String?
    @NSManaged public var color     : String?
    @NSManaged var imageName        : String?
}

extension Cloth {
    static func getAllClothes() -> NSFetchRequest<Cloth> {
        let request: NSFetchRequest<Cloth> = Cloth.fetchRequest() as! NSFetchRequest<Cloth>
        
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

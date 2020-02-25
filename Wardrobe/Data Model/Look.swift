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
    
    @NSManaged public var label       : String?
    @NSManaged public var styleIndex  : NSNumber?
    @NSManaged public var seasonIndex : NSNumber?
    @NSManaged public var clothes     : NSSet?
    
    var style: String {
        LookStyles(rawValue: Int(exactly: self.styleIndex!)!)!.description
    }
    
    var season: String {
        LookSeasons(rawValue: Int(exactly: self.seasonIndex!)!)!.description
    }
}

extension Look {
    static func getAllLooks() -> NSFetchRequest<Look> {
        let request: NSFetchRequest<Look> = Look.fetchRequest() as! NSFetchRequest<Look>
        
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
    @objc(addClothObject:)
    public func addToClothes(_ value: Cloth) {
        self.mutableSetValue(forKey: "clothes").add(value)
    }

    @objc(removeClothObject:)
    public func removeFromClothes(_ value: Cloth) {
        self.mutableSetValue(forKey: "clothes").remove(value)
    }

    @objc(addClothes:)
    public func addAllClothes(_ values: [Cloth]) {
        for value in values {
            self.mutableSetValue(forKey: "clothes").add(value)
        }
    }

//    @objc(removeClothes:)
//    @NSManaged public func removeFromClothes(_ values: NSSet)
}

enum LookStyles: Int, CaseIterable, CustomStringConvertible {
    case usual
    case official
    case festive
    
    var description: String {
        switch self {
        case .usual    : return "Usual"
        case .official : return "Official"
        case .festive  : return "Festive"
        }
    }
}

enum LookSeasons: Int, CaseIterable, CustomStringConvertible {
    case summer
    case winter
    case demi
    
    var description: String {
        switch self {
        case .summer : return "Summer"
        case .winter : return "Winter"
        case .demi   : return "Demi-season"
        }
    }
}

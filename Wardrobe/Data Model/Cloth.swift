//
//  Cloth.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

public class Cloth: NSManagedObject, Identifiable {
    @NSManaged public var id        : UUID?
    @NSManaged public var label     : String?
    @NSManaged public var brand     : String?
    @NSManaged public var typeIndex : NSNumber?
    @NSManaged public var color     : String?
    @NSManaged public var imageData : NSData?
    
    var image: Image {
        Image(uiImage: UIImage(data: imageData! as Foundation.Data)!)
    }
    
    var type: String {
        ClothTypes(rawValue: Int(exactly: self.typeIndex!)!)!.description
    }
}

extension Cloth {
    static func getAllClothes() -> NSFetchRequest<Cloth> {
        let request: NSFetchRequest<Cloth> = Cloth.fetchRequest() as! NSFetchRequest<Cloth>
        
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

enum ClothTypes: Int, CaseIterable, CustomStringConvertible {
    case head
    case body
    case legs
    case shoes
    case accessory
    
    var description: String {
        switch self {
        case .head      : return "Head"
        case .body      : return "Body"
        case .legs      : return "Legs"
        case .shoes     : return "Shoes"
        case .accessory : return "Accessory"
        }
    }
}

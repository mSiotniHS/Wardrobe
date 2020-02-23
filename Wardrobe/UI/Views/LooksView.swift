//
//  LooksView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 22/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI
import CoreData

struct LooksView: View {
    var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: Look.getAllLooks()) var looks: FetchedResults<Look>
    @FetchRequest(fetchRequest: Cloth.getAllClothes()) var clothes: FetchedResults<Cloth>
    
    var addLookButton: some View {
        Button(action: {
//            TODO: IMPLEMENT
//            let look = Look(context: self.managedObjectContext)
//            look.id    = UUID()
//            look.label = "Usual one"
//            look.style = "usual"
//            look.season = "warm"
//            look.addToClothes(self.clothes[0])
//
//            do {
//                try self.managedObjectContext.save()
//            } catch {
//                print("Tried to save look. Error: \(error)")
//            }
//
        }) { Image(systemName: "plus.circle") }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.looks) { look in
                    NavigationLink(destination: LookDetailedView(look: look)) {
                        LookItem(look: look)
                    }
                }
            }.navigationBarItems(trailing: addLookButton)
        }
    }
}

//struct LooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        LooksView()
//    }
//}

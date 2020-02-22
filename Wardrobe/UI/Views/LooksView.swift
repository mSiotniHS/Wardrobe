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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.looks) { look in
                    NavigationLink(destination: LookDetailedView(look: look)) {
                        LookItem(look: look)
                    }
                }
//                .onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
            }
        }
    }
}

//struct LooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        LooksView()
//    }
//}

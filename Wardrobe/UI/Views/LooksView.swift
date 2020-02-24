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
    
    @State var showAdder = false
    
    var addLookButton: some View {
        Button(action: { self.showAdder.toggle() }) {
            Image(systemName: "plus.circle")
                .imageScale(.large)
                .accessibility(label: Text("Add cloth"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.looks) { look in
                    NavigationLink(destination: LookDetailedView(look: look)) {
                        LookItem(look: look)
                    }
                }
                .onDelete(perform: deleteLook)
            }
            .navigationBarTitle(Text("Looks"))
            .navigationBarItems(trailing: addLookButton)
            .sheet(isPresented: self.$showAdder) {
                LookAdder(managedObjectContext: self.managedObjectContext, clothes: self.clothes)
            }
        }
    }
    
    private func deleteLook(at offsets: IndexSet) {
        for index in offsets {
            let look = looks[index]
            self.managedObjectContext.delete(look)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Tried to delete look. An error occured: \(error)")
        }
    }
}

//struct LooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        LooksView()
//    }
//}

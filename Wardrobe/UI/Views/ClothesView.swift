//
//  ClothesView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 22/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI
import CoreData

struct ClothesView: View {
    var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: Cloth.getAllClothes()) var clothes: FetchedResults<Cloth>
    
    @State var showAdder = false
    
    var addButton: some View {
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
                ForEach(self.clothes) { cloth in
                    NavigationLink(destination: ClothDetailedView(cloth: cloth)) {
                        ClothItem(cloth: cloth)
                    }
                }
                .onDelete(perform: deleteCloth)
            }
            .navigationBarTitle(Text("Clothes"))
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: self.$showAdder) {
                ClothAdder(managedObjectContext: self.managedObjectContext)
            }
        }
    }
    
    private func deleteCloth(at offsets: IndexSet) {
        for index in offsets {
            let cloth = clothes[index]
            managedObjectContext.delete(cloth)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Tried to delete object. An error occured: \(error)")
        }
    }
}

//struct ClothesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothesView()
//    }
//}

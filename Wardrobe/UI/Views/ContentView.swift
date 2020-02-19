//
//  ContentView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
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
            List(self.clothes) { cloth in
                NavigationLink(destination: ClothDetailedView(cloth: cloth)) {
                    ClothItem(cloth: cloth)
                }
            }
            .navigationBarTitle(Text("Clothes"))
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: self.$showAdder) {
                ClothAdder(managedObjectContext: self.managedObjectContext)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

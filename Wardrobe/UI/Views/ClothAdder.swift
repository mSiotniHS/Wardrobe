//
//  ClothAdder.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI
import CoreData

struct ClothAdder: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var managedObjectContext: NSManagedObjectContext
    
    @State private var label = ""
    @State private var brand = ""
    @State private var color = ""
    
    var fieldsAreFilled: Bool {
        self.label != "" && self.brand != "" && self.color != ""
    }
    
    var dismissButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Label", text: self.$label)
                TextField("Brand", text: self.$brand)
                TextField("Color", text: self.$color)
                
                Spacer()
                
                Button(action: {
                    let cloth = Cloth(context: self.managedObjectContext)
                    
                    cloth.label = self.label
                    cloth.brand = self.brand
                    cloth.color = self.color
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Tried to save object. Error: \(error)")
                    }
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(EdgeInsets.init(top: 0, leading: 30, bottom: 0, trailing: 30))
                        .background(fieldsAreFilled ? Color.blue : Color.gray)
                        .cornerRadius(20)
                }
                .disabled(!fieldsAreFilled)
            }
            .navigationBarTitle(Text("Add new cloth"), displayMode: .inline)
            .navigationBarItems(trailing: dismissButton)
        }
    }
}

//struct ClothAdder_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothAdder(showModal: true)
//    }
//}

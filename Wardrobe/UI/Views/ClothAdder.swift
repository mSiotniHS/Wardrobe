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
    
    @State private var label     = ""
    @State private var brand     = ""
    @State private var color     = ""
    @State private var typeIndex = 0
    @State private var imageName = ""
    
    private var fieldsAreFilled: Bool {
        self.label != "" &&
        self.brand != "" &&
        self.color != ""
    }
    
    private var dismissButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
        }
    }
    
    @State private var showActionSheet : Bool   = false
    @State private var showImagePicker : Bool   = false
    @State private var image           : Image? = nil
    private var pictureSourceActionSheet: ActionSheet {
        ActionSheet(title: Text("Choose the source of picture"), buttons: [
            .default(Text("Camera")),
            .default(Text("Gallery")) { self.showImagePicker.toggle() },
            .cancel(Text("Cancel")),
        ])
    }
    
    func saveData() {
        let cloth = Cloth(context: self.managedObjectContext)
        
        cloth.id    = UUID()
        cloth.label = self.label
        cloth.brand = self.brand
        cloth.color = self.color
        cloth.type  = ClothType.types[typeIndex]
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Tried to save object. Error: \(error)")
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Label", text: self.$label)
                    TextField("Brand", text: self.$brand)
                    TextField("Color", text: self.$color)
                    Picker("Styles", selection: $typeIndex) { // BUG: when typing text, Picker is "blinking"
                        ForEach(0 ..< ClothType.types.count) { index in
                            Text(ClothType.typesForHuman[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Button(action: { self.showActionSheet.toggle() }) { Text(self.image == nil ? "Add photo" : "Change photo") }
                    if (self.image != nil) {
                        self.image!
                            .resizable()
                            .scaledToFit()
                    }
                }
                Spacer()
                
                Button(action: { self.saveData() }) {
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
        .actionSheet(isPresented: $showActionSheet) { self.pictureSourceActionSheet }
        .sheet(isPresented: self.$showImagePicker) {
            ImagePickerWrapper(showImagePicker: self.$showImagePicker, image: self.$image)
        }
    }
}

struct ClothType {
    static var types         : [String] = ["head", "body", "legs", "shoes"]
    static var typesForHuman : [String] {
        self.types.map { String($0.prefix(1)).uppercased() + $0.dropFirst() }
    }
}

//struct ClothAdder_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothAdder()
//    }
//}

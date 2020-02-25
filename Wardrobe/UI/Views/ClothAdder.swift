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
    
    @State private var label       : String   = ""
    @State private var brand       : String   = ""
    @State private var color       : String   = ""
    @State private var typeIndex   : Int      = 0
    @State private var image       : UIImage? = nil
    @State private var imageSource : UIImagePickerController.SourceType? = nil
    
    private var fieldsAreFilled: Bool {
        self.label != "" &&
        self.brand != "" &&
        self.color != "" &&
        self.image != nil
    }
    
    private var dismissButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
        }
    }
    
    @State private var showActionSheet : Bool = false
    @State private var showImagePicker : Bool = false

    private var pictureSourceActionSheet: ActionSheet {
        ActionSheet(title: Text("Choose the source of picture"), buttons: [
            .default(Text("Camera"))  {
                self.imageSource = .camera;
                self.showImagePicker.toggle()
            },
            .default(Text("Gallery")) {
                self.imageSource = .photoLibrary;
                self.showImagePicker.toggle()
            },
            .cancel(Text("Cancel")),
        ])
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Add new cloth")
                    .font(.headline)
                    .bold()
            }
            .padding(EdgeInsets(top: 13.0, leading: 10.0, bottom: 0.0, trailing: 20.0))
            
            Form {
                TextField("Label", text: self.$label)
                TextField("Brand", text: self.$brand)
                TextField("Color", text: self.$color)
                Picker("Styles", selection: $typeIndex) { // BUG: when typing text, Picker is "blinking"
                    ForEach(0 ..< ClothTypes.allCases.count) { index in
                        Text(ClothTypes.allCases[index].description).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: { self.showActionSheet.toggle() }) {
                    Text(self.image == nil ? "Add photo" : "Change photo")
                }
                
                if (self.image != nil) {
                    Image(uiImage: self.image!)
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
        .actionSheet(isPresented: $showActionSheet) { self.pictureSourceActionSheet }
        .sheet(isPresented: self.$showImagePicker) {
            ImagePicker(isShown: self.$showImagePicker, image: self.$image, sourceType: self.imageSource!)
        }
    }
    
    private func saveData() {
        let cloth = Cloth(context: self.managedObjectContext)
                
        cloth.id        = UUID()
        cloth.label     = self.label
        cloth.brand     = self.brand
        cloth.color     = self.color
        cloth.typeIndex = NSNumber(integerLiteral: self.typeIndex)
        cloth.imageData = self.image?.pngData() as NSData?
                
//      BUG: I assume, it doesn't work. Consider finding the solution
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Tried to save cloth. Error: \(error)")
                }
            }
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

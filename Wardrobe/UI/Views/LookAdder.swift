//
//  LookAdder.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 24/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI
import CoreData

struct LookAdder: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var managedObjectContext : NSManagedObjectContext
    var clothes              : FetchedResults<Cloth>
    
    @State private var label        : String = ""
    @State private var styleIndex   : Int = 0
    @State private var seasonIndex  : Int = 0
    @State private var chosenClothes: [Cloth] = []
    
    private var fieldsAreFilled: Bool {
        self.label  != "" &&
        !self.chosenClothes.isEmpty
    }

    private func saveData() {
        let look = Look(context: self.managedObjectContext)
        
        look.id          = UUID()
        look.label       = self.label
        look.styleIndex  = NSNumber(integerLiteral: self.styleIndex)
        look.seasonIndex = NSNumber(integerLiteral: self.seasonIndex)
        look.addAllClothes(self.chosenClothes)
        
        // Neither does it. Consider finding the solution
        DispatchQueue.main.async {
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Error in saving look. Error: \(error)")
            }
            
            self.presentationMode.wrappedValue.dismiss()
            
        }
    }

    private var clothesPicker: some View {
        List {
            ForEach(self.clothes) { cloth in
                SelectionElement(isSelected: self.chosenClothes.contains(cloth), action: {
                    if (self.chosenClothes.contains(cloth)) {
                        self.chosenClothes.removeAll(where: { $0 == cloth })
                    } else {
                        self.chosenClothes.append(cloth)
                    }
                }) {
                    ClothItem(cloth: cloth)
                }
            }
        }
    }
    
    private var dismissButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Label", text: self.$label)
                    Picker("Style", selection: self.$styleIndex) {
                        ForEach(0 ..< LookStyles.allCases.count) { index in
                            Text(LookStyles.allCases[index].description).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Season", selection: self.$seasonIndex) {
                        ForEach(0 ..< LookSeasons.allCases.count) { index in
                            Text(LookSeasons.allCases[index].description).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("Choose clothes:")
                    self.clothesPicker
                }
                Spacer()
                Button(action: { self.saveData() }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(EdgeInsets.init(top: 0, leading: 30, bottom: 0, trailing: 30))
                        .background(self.fieldsAreFilled ? Color.blue : Color.gray)
                        .cornerRadius(20)
                }
                .disabled(!self.fieldsAreFilled)
            }
            .navigationBarTitle(Text("Add new look"), displayMode: .inline)
            .navigationBarItems(leading: dismissButton)
        }
    }
}

struct SelectionElement<Child>: View where Child: View {
    var child: Child
    var isSelected: Bool
    var action: () -> Void
    
    init(isSelected: Bool, action: @escaping () -> Void, @ViewBuilder content: () -> Child) {
        self.isSelected = isSelected
        self.action = action
        self.child = content()
    }
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                child
                if (self.isSelected) {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

//struct LookAdder_Previews: PreviewProvider {
//    static var previews: some View {
//        LookAdder()
//    }
//}

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
    @State private var style        : String = ""
    @State private var season       : String = ""
    @State private var chosenClothes: [Cloth] = []

    private func saveData() {
        let look = Look(context: self.managedObjectContext)
        
        look.id    = UUID()
        look.label = self.label
        look.style = self.style
        look.season = self.season
        look.addAllClothes(self.chosenClothes)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error in saving look. Error: \(error)")
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
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Label", text: self.$label)
                    TextField("Style", text: self.$style)
                    TextField("Season", text: self.$season)
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
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
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

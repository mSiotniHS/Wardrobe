//
//  ClothDetailedView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct ClothDetailedViewWrapper: View {
    @Environment(\.editMode) var mode
    
    var cloth: Cloth
    
    var body: some View {
        VStack {
            if (self.mode?.wrappedValue == .inactive) {
                ClothDetailedView(cloth: cloth)
            } else {
                ClothEditor()
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
}

struct ClothDetailedView: View {
    var cloth: Cloth
    
    var paddingValue: CGFloat = 14.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                self.cloth.image
                    .resizable()
                    .scaledToFill()
                Text(cloth.label!).font(.largeTitle).bold()
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
                Text("Brand: \(cloth.brand!)")
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
                Text("Type: \(cloth.type)")
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
            }
        }
    }
}

//struct ClothDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothDetailedView(cloth: Cloth.default)
//    }
//}

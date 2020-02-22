//
//  ClothDetailedView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct ClothDetailedView: View {
    var cloth: Cloth
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                self.cloth.image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .listRowInsets(EdgeInsets())
                Text(cloth.label!).font(.largeTitle)
                Text("Brand: \(cloth.brand!)")
                Text("Type: \(cloth.type!.description)")
                Text("UUID: \(cloth.id!)")
            }
        }
    }
}

//struct ClothDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothDetailedView(cloth: Cloth.default)
//    }
//}

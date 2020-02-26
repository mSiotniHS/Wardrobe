//
//  LookDetailedView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 22/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct LookDetailedView: View {
    var look: Look
    
    var paddingValue: CGFloat = 14.0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(look.clothesArray) { cloth in
                            cloth.image
                                .resizable()
                                .renderingMode(.original)
                                .scaledToFill()
                                .frame(width: 200, height: 200, alignment: .center)
                                .clipped()
                        }
                    }
                }
                Text(self.look.label!)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
                Text("Style: \(self.look.style)")
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
                Text("Season: \(self.look.season)")
                    .padding(.leading, paddingValue)
                    .padding(.trailing, paddingValue)
                Section(header: Text("Contains:")) {
                    ForEach(self.look.clothesArray) { cloth in
                        NavigationLink(destination: ClothDetailedView(cloth: cloth)) {
                            ClothItem(cloth: cloth)
                        }
                    }
                }
                .padding(.leading, paddingValue)
                .padding(.trailing, paddingValue)
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
}


//struct LookDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        LookDetailedView()
//    }
//}

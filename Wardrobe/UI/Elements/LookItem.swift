//
//  LookItem.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 22/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct LookItem: View {
    var look: Look
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(look.clothesArray) { cloth in
                        cloth.image
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipped()
                    }
                }
            }
            Text(look.label!)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Text(look.style)
                .font(.headline)
            Text("Season: \(look.season)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

//struct LookItem_Previews: PreviewProvider {
//    static var previews: some View {
//        LookItem()
//    }
//}

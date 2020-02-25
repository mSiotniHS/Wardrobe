//
//  ClothItem.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct ClothItem: View {
    var cloth: Cloth
    
    var body: some View {
        HStack {
            self.cloth.image
                .resizable()
                .renderingMode(.original)
                .frame(width: 90, height: 90)
            VStack(alignment: .leading) {
                Text(cloth.label!)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(cloth.brand!)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

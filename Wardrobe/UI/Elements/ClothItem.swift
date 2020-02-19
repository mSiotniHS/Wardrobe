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
            VStack(alignment: .leading) {
                Text(cloth.label!)
                    .font(.headline)
                Text(cloth.brand!)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
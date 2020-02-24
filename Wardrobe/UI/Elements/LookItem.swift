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
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(self.look.clothes!) as! Array<Cloth>) { cloth in
                        cloth.image
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            Text(look.label!)
            Text(look.style!)
            Text(look.season!)
        }
    }
}

//struct LookItem_Previews: PreviewProvider {
//    static var previews: some View {
//        LookItem()
//    }
//}

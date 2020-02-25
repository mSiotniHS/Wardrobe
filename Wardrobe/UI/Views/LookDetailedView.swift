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
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Label: \(look.label!)")
                Text("Style: \(look.style)")
                Text("Season: \(look.season)")
                ForEach(Array(self.look.clothes!) as! Array<Cloth>) { cloth in
                    Text("Contained cloth: \(cloth.label!)")
                }
            }
        }
    }
}

//struct LookDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        LookDetailedView()
//    }
//}

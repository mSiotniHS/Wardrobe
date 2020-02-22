//
//  ContentView.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        TabView {
            ClothesView(managedObjectContext: managedObjectContext)
                .tabItem {
                    Image(systemName: "command")
                    Text("Clothes")
                }
            
            LooksView(managedObjectContext: managedObjectContext)
                .tabItem {
                    Image(systemName: "option")
                    Text("Looks")
                }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

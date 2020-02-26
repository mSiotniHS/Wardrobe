//
//  Data.swift
//  Wardrobe
//
//  Created by Artem Abramyan on 19/02/2020.
//  Copyright © 2020 Artem Abramyan. All rights reserved.
//

import Foundation

class Data: ObservableObject {
    @Published var clothes : [Cloth] = []
    @Published var looks   : [Look]  = []
}

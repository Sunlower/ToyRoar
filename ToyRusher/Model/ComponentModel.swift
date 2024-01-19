//
//  ComponentModel.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 08/01/24.
//

import Foundation

struct ComponentModel: Identifiable, Hashable {
    var id: String {
        self.name
    }
    var name: String
}

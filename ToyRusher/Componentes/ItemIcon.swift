//
//  ItemIcon.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 07/01/24.
//

import SwiftUI

struct ItemIcon: View {
    
    var image: String
    var name: String
    var tamItem: CGFloat?
    var tamImage: CGFloat?


    var body: some View {
        ZStack {
            Image("Extras/item")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: tamItem)

            VStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: tamImage)
                Text(name)
            }
        }
        
    }
}

#Preview {
    ItemIcon(image: "Car/Alumínio", name: "Alumínio", tamItem: 170, tamImage: 80)
}

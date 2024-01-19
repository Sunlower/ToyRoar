//
//  Scene.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 07/01/24.
//

import SwiftUI

struct SceneMain: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("Cenario/cenario")
                    .resizable()
                    .aspectRatio(contentMode: .fill)

                Image("Cenario/carrinhoFundo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y:-geometry.size.height*0.45)

                Image("Cenario/carrinho")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y:-geometry.size.height*0.45)

                Image("robo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometry.size.height*0.6)
                    .offset(x: geometry.size.width*0.25)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SceneMain()
}

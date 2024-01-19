//
//  Carrinho.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 03/01/24.
//

import SwiftUI

struct CarView: View {
    @State private var isTextVisible = true
    @State var carrinho = "Car/carrinhoDefault"
    var itens: [String] = ["Aluminum","Cardboard","Plastic"]
    @State private var bounce = false

    var body: some View {
        GeometryReader { geometry in

            ZStack{
                SceneMain()

                ZStack{

                    Image("Cenario/esteira")
                        .resizable()
                        .frame(height: geometry.size.width*0.35)
                        .aspectRatio(contentMode: .fit)
                        .offset(y: -geometry.size.height*0.02)

                    HStack{

                        ForEach(itens,id: \.self ){ item in
                            Button {

                                withAnimation(.interpolatingSpring(stiffness: 170, damping: 5)) {
                                    self.carrinho = "Car/car\(item)"
                                    self.bounce.toggle()
                                }

                            } label: {

                                ItemIcon(image: "Car/\(item)", 
                                         name: item, 
                                         tamItem: geometry.size.width*0.13,
                                         tamImage: geometry.size.width*0.065)

                            }
                        }

                    }
                    .offset(y: geometry.size.width*0.06)
                }
                .offset(y: geometry.size.width*0.25)

                Image(carrinho)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometry.size.height*0.38)
                    .scaleEffect(bounce ? 1.02 : 1.0)

                if self.carrinho == "Car/carrinhoDefault" {
                    Image("Extras/btnDesabilitado")
                        .offset(x:geometry.size.height*0.55,
                                y:geometry.size.height*0.44)
                } else {
                    NavigationLink {
                        FinalSceneView(car: carrinho)
                    } label: {
                        Image("Extras/btnNext")
                    }
                    .offset(x:geometry.size.height*0.55,
                            y:geometry.size.height*0.44)
                }

                ZStack{
                    if isTextVisible {

                        TaskMessage(message: "Sensational! Finally, we will choose the body of the car. We have selected some recyclable materials that can be used to give the car a unique touch. Choose one of the materials below to be the body of your car.")

                        Button {
                            withAnimation {
                                self.isTextVisible.toggle()
                            }

                        } label: {
                            Image("Extras/btnNext")
                        }
                        .offset(x:0, y: geometry.size.height*0.16)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CarView()
}

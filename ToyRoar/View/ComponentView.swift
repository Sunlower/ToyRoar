//
//  ComponentView.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 03/01/24.
//

import SwiftUI
import SpriteKit

struct ComponentView: View {
    @State private var isTextVisible = true
    @State var progress: CGFloat = 0.0
    @State var component: Components
    = Components.broken
    @State var popupOne: Bool = false

    var itensDesejados = [ "Diode", "Transistor", "Resistor"]


    var body: some View {

        GeometryReader { geometry in
            ZStack{

                FallingComponentsView(pause: $popupOne, progress: $progress, componentNotToCollect: component)

                ZStack{
                    Image("Extras/sideBar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width*0.17)

                    VStack{
                        ForEach(itensDesejados,id: \.self ){ item in
                            ItemIcon(image: "Circuit/\(item)", name: item, tamItem: geometry.size.width*0.1, tamImage: geometry.size.width*0.04)
                        }
                    }
                }
                .offset(x: -geometry.size.width*0.42,
                        y:-geometry.size.height*0.16)

                if progress >= 3 {
                    NavigationLink {
                        InfoCircuitView()
                    } label: {
                        Image("Extras/btnNext")
                    }
                    .offset(x:geometry.size.width*0.25, y: geometry.size.height*0.43)
                } else {
                    Image("Extras/btnDesabilitado")
                        .offset(x:geometry.size.width*0.25, y:geometry.size.height*0.43)
                }

                ZStack{
                    if isTextVisible {
                        TaskMessage(message: "Your first task will be to gather good electronic components from other toys that no longer work. Drag the basket from side to side to collect the components listed in your deliverables.")

                        Button {
                            withAnimation {
                                self.isTextVisible.toggle()
                                self.popupOne.toggle()
                            }
                        } label: {
                            Image("Extras/btnNext")
                        }
                        .offset(y: geometry.size.height*0.14)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()

        }
    }

}

#Preview {
    ComponentView()
}

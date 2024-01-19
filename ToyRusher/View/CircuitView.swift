//
//  CircuitView.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 03/01/24.
//

import SwiftUI

struct CircuitView: View {
    @State var resistorAlfa: CGFloat = 0.2
    @State var transistorAlfa: CGFloat = 0.2
    @State var diodoAlfa: CGFloat = 0.2
    @State var resistorControl = false
    @State var transistorControl = false
    @State var diodoControl = false
    @State var count: Int = 0

    @State private var isTextVisible = true
    var itens: [String] = ["Diode","Transistor","Resistor"]

    var body: some View {

        GeometryReader{ geometry in

            ZStack{
                Image("Circuit/placaFundo")

                HStack{

                    ZStack{
                        Image("Extras/sideBar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:geometry.size.width*0.2)

                        VStack{
                            ForEach(itens, id: \.self){ item in
                                ItemIcon(image: "Circuit/\(item)",
                                         name: item,
                                         tamItem: geometry.size.width*0.1,
                                         tamImage: geometry.size.width*0.04)
                                    .draggable(item)
                            }
                        }
                    }

                    ZStack{
                        Image("Circuit/placaFaltando")
                            .resizable()
                            .frame(width: geometry.size.width*0.72,
                                   height: geometry.size.width*0.64)

                        Image("Circuit/placaResistor")
                            .resizable()
                            .opacity(resistorAlfa)
                            .frame(width: geometry.size.width*0.37,
                                   height: geometry.size.width*0.085)
                            .offset(x:-geometry.size.width*0.14572,
                                    y:geometry.size.height*0.271)
                            .dropDestination(for: String.self) { droppedItem, location in
                                if resistorControl == false {
                                    if droppedItem[0] == "Resistor"{
                                        self.resistorAlfa = 1
                                        self.count += 1
                                        self.resistorControl = true
                                    }

                                }
                                return true
                            }

                        Image("Circuit/placaTransistor")
                            .resizable()
                            .opacity(transistorAlfa)
                            .frame(width: geometry.size.width*0.175,
                                   height: geometry.size.height*0.14)
                            .offset(x:-geometry.size.width*0.2474,
                                    y:-geometry.size.height*0.24)
                            .dropDestination(for: String.self) { droppedItem, location in
                                if transistorControl == false {
                                    if droppedItem[0] == "Transistor"{
                                        self.transistorAlfa = 1
                                        self.count += 1
                                        self.transistorControl = true
                                    }

                                }
                                return true
                            }

                        Image("Circuit/placaDiodo")
                            .resizable()
                            .opacity(diodoAlfa)
                            .frame(width: geometry.size.width*0.358,
                                   height: geometry.size.height*0.14)
                            .offset(x:geometry.size.width*0.021,
                                    y:-geometry.size.height*0.329)
                            .dropDestination(for: String.self) { droppedItem, location in

                                if diodoControl == false {
                                    if droppedItem[0] == "Diode"{
                                        self.diodoAlfa = 1
                                        self.count += 1
                                        self.diodoControl = true
                                    }

                                }
                                return true
                            }
                    }
                }
                .padding()

                if count >= 3 {
                    NavigationLink {
                        CarView()
                    } label: {
                        Image("Extras/btnNext")
                    }
                    .offset(x:geometry.size.width*0.3, 
                            y: geometry.size.height*0.3)
                } else {
                    Image("Extras/btnDesabilitado")
                        .offset(x:geometry.size.width*0.3, 
                                y: geometry.size.height*0.3)
                }

                ZStack{
                    if isTextVisible {

                        TaskMessage(message: "Very well! Now, with the electronic components, we will assemble the electronic board of the car. Press and drag the components to their corresponding spaces.")

                        Button {
                            withAnimation {
                                self.isTextVisible.toggle()
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
    CircuitView()
}

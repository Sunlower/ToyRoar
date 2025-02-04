//
//  InfoCircuitView.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 18/01/24.
//

import SwiftUI

struct InfoCircuitView: View {
    var body: some View {

        GeometryReader { geometry in

            NavigationStack {
                ZStack{
                    SceneMain()

                    HStack{
                        ZStack{
                            TaskMessage(message: "To assess the condition of the components, besides their appearance, the best way is still to test them with a multimeter. If the device functions partially, we can also take voltage and frequency measurements and analyze signals using an oscilloscope. With these steps completed, let's move on to the circuit assembly!")

                            NavigationLink {
                                CircuitView()
                            } label: {
                                Image("Extras/btnNext")
                            }
                            .offset(y: geometry.size.height*0.18)
                        }
                        .offset(x: -geometry.size.width*0.14)

                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    InfoCircuitView()
}

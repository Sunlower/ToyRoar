//
//  InfoInitialView.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 18/01/24.
//

import SwiftUI

struct InfoInitialView: View {
    var body: some View {

        GeometryReader { geometry in

            NavigationStack {
                ZStack{
                    SceneMain()

                    HStack{
                        ZStack{
                            TaskMessage(message: "Did you know that approximately 54 million metric tons of electronic waste are generated each year, and these materials can be recycled?  Unfortunately, globally, only 17.4% of these materials are recycled. So, we built Toy Roar to create new stories with these materials. Let's get started!")

                            NavigationLink {
                                ComponentView()
                            } label: {
                                Image("Extras/btnNext")
                            }
                            .offset(y: geometry.size.height*0.17)
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
    InfoInitialView()
}

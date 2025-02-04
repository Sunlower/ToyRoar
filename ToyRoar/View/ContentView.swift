import SwiftUI

struct ContentView: View {
    @State private var xOffsetR: CGFloat = 0.0
    @State private var xOffsetL: CGFloat = 0.0
    @State private var isTextVisible = true
    @State private var scale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in

            NavigationStack {
                ZStack{
                    SceneMain()

                    HStack{
                        ZStack{
                            TaskMessage(message: "Welcome, human. Today will be your first day at our toy factory, Toys Roar. I am Jorge, your robot manager, and I will assist you in building your first toy – an electronic car made from recyclable materials.")

                            NavigationLink {
                                InfoInitialView()
                            } label: {
                                Image("Extras/btnNext")
                            }
                            .offset(y: geometry.size.height*0.14)
                        }
                        .offset(x: -geometry.size.width*0.14)

                    }

                    Image("Intro/porta1")
                        .offset(x: xOffsetR)
                        .animation(.easeInOut(duration: 0.7))
                        .offset(x: -geometry.size.width*0.22)

                    Image("Intro/porta2")
                        .offset(x: xOffsetL)
                        .animation(.easeInOut(duration: 0.7))
                        .offset(x: geometry.size.width*0.22)

                    ZStack{
                        if isTextVisible {

                            Image("Intro/logo")
                                .resizable()
                                .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.55)
                                .offset(y: -geometry.size.height*0.1)
                                .scaleEffect(scale)
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                                        self.scale = 1.2
                                    }
                                }


                            Button {
                                withAnimation {
                                    self.xOffsetL += geometry.size.width*0.7
                                    self.xOffsetR -= geometry.size.width*0.7
                                    self.isTextVisible.toggle()
                                }

                            } label: {
                                Image("Intro/btn")
                            }
                            .offset(y: geometry.size.height*0.35)
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

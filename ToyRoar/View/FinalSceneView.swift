import SwiftUI

struct FinalSceneView: View {
    @State private var confetti: [Confetti] = []
    @State private var offset: CGFloat = 0.0
    var car: String

    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                SceneMain()

                ZStack{
                    ZStack{
                        TaskMessage(message: "Congratulations! Your first day was a success. I'm sure the new owner of this little car will have a lot of fun! Thank you for playing!")

                        ForEach(confetti) { confettiPiece in
                            ConfettiPiece(position: confettiPiece.position, color: confettiPiece.color)
                        }

                        NavigationLink {
                            ContentView()
                        } label: {
                            Image("Extras/btnRetry")
                        }
                        .offset(y: geometry.size.height*0.12)

                    }
                    .offset(x: -geometry.size.width*0.15)

                    Image(car)
                        .resizable()
                        .frame(width:geometry.size.width*0.2, 
                               height: geometry.size.height*0.2)
                        .foregroundColor(.blue)
                        .offset(x: offset - geometry.size.width , 
                                y: geometry.size.height*0.3)

                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .onAppear {
                generateConfetti()
                withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                    generateConfetti()
                }

                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                    self.offset = geometry.size.width * 2
                }


            }
        }
    }


    func generateConfetti() {
        confetti.removeAll()

        for _ in 0..<50 {
            let position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let color = Color(hue: Double.random(in: 0...1), saturation: 1, brightness: 1)
            confetti.append(Confetti(position: position, color: color))
        }
    }
}

struct ConfettiView: View {
    @State private var confetti: [Confetti] = []

    var body: some View {
        ZStack {
            ForEach(confetti) { confettiPiece in
                ConfettiPiece(position: confettiPiece.position, color: confettiPiece.color)
            }
        }
        .onAppear {
            // Inicializa a chuva de confetes
            generateConfetti()
        }
        .onTapGesture {
            // Toque na tela para reiniciar a animação
            generateConfetti()
        }
    }

    func generateConfetti() {
        confetti.removeAll()

        for _ in 0..<50 {
            let position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let color = Color(hue: Double.random(in: 0...1), saturation: 1, brightness: 1)
            confetti.append(Confetti(position: position, color: color))
        }
    }
}

struct ConfettiPiece: View {
    let position: CGPoint
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
            .position(position)
            .animation(
                Animation.linear(duration: 2)
                    .repeatForever(autoreverses: false)
                    .delay(Double.random(in: 0...2))
            )
    }
}

struct Confetti: Identifiable {
    let id = UUID()
    let position: CGPoint
    let color: Color
}

#Preview {
    FinalSceneView(car: "Car/carrinhoDefault")
}

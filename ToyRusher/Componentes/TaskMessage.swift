//
//  TaskMessage.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 07/01/24.
//

import SwiftUI

struct TaskMessage: View {

    var message: String

    var body: some View {
        ZStack{
            Image("Extras/balao")
                .resizable()
                .frame(width: 700, height: 400)

            Text(message)
                .frame(width: 600, height: 300)
                .font(.title)
                .offset(y: -30)
        }
    }
}

#Preview {
    TaskMessage(message: "A sua primeira atividade será coletar componentes eletrônicos bons que vieram de outros brinquedos que não funcionam mais. Arraste a cesta abaixo de um lado para o outro para coletar os componentes que aparecem na sua lista de entregáveis.")
}

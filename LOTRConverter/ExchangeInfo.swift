//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Nils Müller on 16.11.24.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(2)

                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                ExchangeDetail(leftImage: .goldpiece, rightImage: .goldpenny, detail: "1 Gold Piece = 4 Gold Pennies")
                ExchangeDetail(leftImage: .goldpenny, rightImage: .silverpiece, detail: "1 Gold Penny = 4 Silver Pieces")
                ExchangeDetail(leftImage: .silverpiece, rightImage: .silverpenny, detail: "1 Silver Piece = 4 Silver Pennies")
                ExchangeDetail(leftImage: .silverpenny, rightImage: .copperpenny, detail: "1 Silver Penny = 100 Copper Pennies")
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}

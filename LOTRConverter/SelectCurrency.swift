//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Nils Müller on 16.11.24.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var sourceCurrency: Currency
    @Binding var destinationCurrency: Currency

    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                Text("Source Currency:")
                    .fontWeight(.bold)
                IconGrid(currency: $sourceCurrency)
                
                Text("Destination Currency:")
                    .fontWeight(.bold)
                IconGrid(currency: $destinationCurrency)
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(sourceCurrency: .constant(.silverPiece), destinationCurrency: .constant(.copperPenny))
}

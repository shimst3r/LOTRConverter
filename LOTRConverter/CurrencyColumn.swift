//
//  CurrencyColumn.swift
//  LOTRConverter
//
//  Created by Nils Müller on 17.11.24.
//

import SwiftUI

struct CurrencyColumn: View {
    var textAlignment = TextAlignment.leading
    @Binding var currency: Currency
    @Binding var amount: String
    @Binding var showSelectCurrency: Bool
    @FocusState var isTyping

    var body: some View {
        VStack {
            HStack {
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                Text(currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .environment(\.layoutDirection, textAlignment == .trailing ? .rightToLeft : .leftToRight)
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(textAlignment)
                .focused($isTyping)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            isTyping = false
                        }
                    }
                }
        }
        .padding(.bottom, -5)
        .onTapGesture {
            showSelectCurrency.toggle()
        }
    }
}

#Preview {
    CurrencyColumn(textAlignment: TextAlignment.trailing, currency: .constant(.cucumberPiece), amount: .constant(""), showSelectCurrency: .constant(false))
}

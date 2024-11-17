//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Nils Müller on 16.11.24.
//

import SwiftUI
import TipKit

/*
 TODO: 3. Dismiss keyboard
 TODO: 4. Refactor currency conversion sections to DRY
 */

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    @AppStorage("SourceCurreny") var sourceCurrency: Currency = .silverPenny
    @AppStorage("DestinationCurrency") var destinationCurrency: Currency = .goldPiece

    @FocusState var leftTyping
    @FocusState var rightTyping

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    Image(.prancingpony)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)

                    Text("Currency Exchange")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    HStack {
                        CurrencyColumn(textAlignment: TextAlignment.leading, currency: $sourceCurrency, amount: $leftAmount, showSelectCurrency: $showSelectCurrency, isTyping: _leftTyping)

                        Image(systemName: "equal")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .symbolEffect(.pulse)

                        CurrencyColumn(textAlignment: TextAlignment.trailing, currency: $destinationCurrency, amount: $rightAmount, showSelectCurrency: $showSelectCurrency, isTyping: _rightTyping)
                    }
                    .padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)
                    .popoverTip(CurrencyTip(), arrowEdge: .top)

                    Spacer()

                    HStack {
                        Spacer()
                        Button {
                            showExchangeInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing)
                    }
                }
            }
            .task {
                try? Tips.configure()
            }
            .onChange(of: leftAmount) {
                if leftTyping {
                    rightAmount = sourceCurrency.convert(leftAmount, to: destinationCurrency)
                }
            }
            .onChange(of: rightAmount) {
                if rightTyping {
                    leftAmount = destinationCurrency.convert(rightAmount, to: sourceCurrency)
                }
            }
            .onChange(of: sourceCurrency) {
                leftAmount = destinationCurrency.convert(rightAmount, to: sourceCurrency)
            }
            .onChange(of: destinationCurrency) {
                rightAmount = sourceCurrency.convert(leftAmount, to: destinationCurrency)
            }
            .sheet(isPresented: $showExchangeInfo) {
                ExchangeInfo()
            }
            .sheet(isPresented: $showSelectCurrency) {
                SelectCurrency(sourceCurrency: $sourceCurrency, destinationCurrency: $destinationCurrency)
            }
        }
    }
}

#Preview {
    ContentView()
}

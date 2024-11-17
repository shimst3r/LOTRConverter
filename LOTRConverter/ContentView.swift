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
                        VStack {
                            HStack {
                                Image(sourceCurrency.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 33)
                                Text(sourceCurrency.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                            .popoverTip(CurrencyTip(), arrowEdge: .top)
                            TextField("Amount", text: $leftAmount)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($leftTyping)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            leftTyping = false
                                        }
                                    }
                                }
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }

                        Image(systemName: "equal")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .symbolEffect(.pulse)
                        VStack {
                            HStack {
                                Text(destinationCurrency.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Image(destinationCurrency.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 33)
                            }
                            TextField("Amount", text: $rightAmount)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($rightTyping)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            rightTyping = false
                                        }
                                    }
                                }
                        }

                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                    }
                    .padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)

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

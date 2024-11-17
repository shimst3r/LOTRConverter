//
//  LOTRConverterTests.swift
//  LOTRConverterTests
//
//  Created by Nils Müller on 17.11.24.
//

import Foundation
@testable import LOTRConverter
import Testing

struct LOTRConverterTests {
    @Test(arguments: Currency.allCases) func goldPieceConversion(destinationCurrency: Currency) {
        let sourceCurrency: Currency = .goldPiece
        let sourceAmount = "1"
        let destinationAmount = String(format: "%.2f", Double(destinationCurrency.rawValue))

        #expect(sourceCurrency.convert(sourceAmount, to: destinationCurrency) == destinationAmount)
    }

    func convert(_ intValue: Int) -> String {
        let doubleValue = Double(intValue) / 3
        if floor(doubleValue) == doubleValue {
            return String(format: "%.0f", doubleValue)
        }
        return String(format: "%.2f", doubleValue)
    }

    @Test func conversion1() {
        #expect(convert(9) == "3")
    }

    @Test func conversion2() {
        #expect(convert(5) == "1.67")
    }
}

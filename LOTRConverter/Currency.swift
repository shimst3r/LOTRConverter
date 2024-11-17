//
//  Currency.swift
//  LOTRConverter
//
//  Created by Nils Müller on 16.11.24.
//
import SwiftUI

/*
 `CaseIterable` is necessary to turn an enum into an iterable container, by accessing
 `Currency.allCases`. `Identifiable` is necessary for the `ForEach` loop, it also
 requires the `id` property.
 */
enum Currency: Int, CaseIterable, Identifiable {
    case cucumberPiece = 12800
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1

    var id: Currency { self }

    var image: ImageResource {
        switch self {
        case .cucumberPiece: .cucumber
        case .copperPenny: .copperpenny
        case .silverPenny: .silverpenny
        case .silverPiece: .silverpiece
        case .goldPenny: .goldpenny
        case .goldPiece: .goldpiece
        }
    }

    var name: String {
        switch self {
        case .cucumberPiece: "Cucumber Piece"
        case .copperPenny: "Copper Penny"
        case .silverPenny: "Silver Penny"
        case .silverPiece: "Silver Piece"
        case .goldPenny: "Gold Penny"
        case .goldPiece: "Gold Piece"
        }
    }

    func convert(_ amountString: String, to destinationCurrency: Currency) -> String {
        guard let amountDouble = Double(amountString) else {
            return ""
        }
        let convertedAmount = (amountDouble / Double(self.rawValue)) * Double(destinationCurrency.rawValue)

        return String(format: "%.2f", convertedAmount)
    }
}

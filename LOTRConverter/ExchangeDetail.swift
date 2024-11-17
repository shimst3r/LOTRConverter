//
//  ExchangeDetail.swift
//  LOTRConverter
//
//  Created by Nils Müller on 16.11.24.
//

import SwiftUI

struct ExchangeDetail: View {
    let leftImage: ImageResource
    let rightImage: ImageResource
    let detail: String
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            Text(detail)
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeDetail(leftImage: .goldpiece, rightImage: .goldpenny, detail: "1 Gold Piece = 4 Gold Pennies")
}

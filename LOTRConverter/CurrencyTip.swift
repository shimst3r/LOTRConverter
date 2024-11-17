//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Nils Müller on 17.11.24.
//

import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    var message: Text? = Text("Tap either currency to bring up the 'Select Currency' screen.")
}

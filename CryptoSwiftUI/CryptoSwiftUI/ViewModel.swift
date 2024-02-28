//
//  ViewModel.swift
//  CryptoSwiftUI
//
//  Created by Mehmet Emin Fırıncı on 28.02.2024.
//

import Foundation


@MainActor 
class CryptoListViewModel : ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = Webservice()

    func downloadCryptosContinuation(url : URL) async {
        do {
            let cryptos = try await webservice.downloadCurrenciesContinuation(url: url)
            self.cryptoList = cryptos.map(CryptoViewModel.init)
        } catch {
            print(error)
        }
    } 
}

struct CryptoViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price
    }
}

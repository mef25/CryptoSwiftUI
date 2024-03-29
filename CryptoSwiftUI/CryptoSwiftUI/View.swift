//
//  ContentView.swift
//  CryptoSwiftUI
//
//  Created by Mehmet Emin Fırıncı on 28.02.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel

    init() {
          self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView{
        
            
            List(cryptoListViewModel.cryptoList,id:\.id) { crypto in
          
                VStack{
    
                Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)

                Text(crypto.price)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
            }.toolbar(content: {
                Button {
                    Task.init {
                        cryptoListViewModel.cryptoList = []
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    Text("Refresh")
                }
            })
            .navigationTitle(Text("Crypto Crazy"))
            
        }.task{
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

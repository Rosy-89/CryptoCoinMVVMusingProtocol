//
//  CryptoViewModel.swift
//  CryptoCoinMVVM
//
//  Created by Alok Kumar Naik on 26/03/2021.
//

import Foundation

protocol didUpdateUITableView{
    
    func didUpdateTableView(_ cryptoModel: CryptoViewModel, coin: Coin)
}
class CryptoViewModel{
    
    var delegate: didUpdateUITableView?
    
    var name: String?
    var price: String?
    var messages = [Coin]()
    
    func fetchData(){
        
        let sharedSession = URLSession.shared
        
            if let url = URL(string: "https://api.coinranking.com/v1/public/coins") {
                
                let request = URLRequest(url: url)
                
                let dataTask = sharedSession.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in

                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CryptoDataContainer.self, from: data!)

                        messages = response.data.coins
                        
                        name = messages[0].name
                        price = messages[0].price
                        
                        var myCoinData = Coin(name: name!, price: price!)
                        
                        self.delegate?.didUpdateTableView(self, coin: myCoinData)

                    }
                    catch {
                        print(error)
                    }
                })

                dataTask.resume()
            }
    }

}

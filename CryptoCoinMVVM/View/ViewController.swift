//
//  ViewController.swift
//  CryptoCoinMVVM
//
//  Created by Alok Kumar Naik on 26/03/2021.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var tableCoins: UITableView!
    
  
    var messages = [Coin]()
    var myViewModel = CryptoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCoins.delegate = self
        tableCoins.dataSource = self
        
        myViewModel.delegate = self
        myViewModel.fetchData()
  
    }
    func format(price: String) -> String {
    
                let double = Double(price)
                let price = String(format: "$%.02f", double!)
                return price
    }
}
    
    //MARK:- TableView methods

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        myViewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let message = myViewModel.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coincell",for: indexPath)
        cell.textLabel?.text = message.name
        
        let formattedprice = format(price: message.price)
        cell.detailTextLabel?.text = formattedprice
        return cell
    }
        
}

extension ViewController: didUpdateUITableView{
    
    func didUpdateTableView(_ cryptoModel: CryptoViewModel, coin: Coin) {
        
        DispatchQueue.main.async {
            self.tableCoins.reloadData()
            
        }
    }
}


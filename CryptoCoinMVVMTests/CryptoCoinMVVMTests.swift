//
//  CryptoCoinMVVMTests.swift
//  CryptoCoinMVVMTests
//
//  Created by Alok Kumar Naik on 26/03/2021.
//

import XCTest
@testable import CryptoCoinMVVM

class CryptoCoinMVVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_GetData(){
        
        let expectation = XCTestExpectation(description: "Post has been completed")
        let url = URL(string: "https://api.coinranking.com/v1/public/coins")!
        var coins = [Coin]()
        
        URLSession.shared.dataTask(with: url){data, response, error in
            
            guard let data = data, error == nil else{
                XCTFail()
                return
            }
            
            let response = try! JSONDecoder().decode(CryptoDataContainer.self, from: data)
            coins = response.data.coins
            
            expectation.fulfill()
            
        }.resume()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssert(coins.count > 0)
    }

}

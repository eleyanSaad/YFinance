//
//  StockDetailsTest.swift
//  YFinanceTests
//
//  Created by macbook on 17/05/2022.
//

import XCTest
import RxSwift

@testable import YFinance
class StockDetailsTest: XCTestCase {

    
    let stockViewModelInstance = MarketViewModel()
    fileprivate let bag = DisposeBag()
    
    func testGetStockDetails(){
        let expectation = self.expectation(description: "response Error")

        stockViewModelInstance.fetchStockSummary(name: "^GSPC")
        stockViewModelInstance.stockViewModelObserver.subscribe(onNext: { (value) in
            DispatchQueue.main.async {
                
                
                if value?.quoteType != nil  {
                    XCTAssertTrue(true)
                }else{
                    XCTAssertTrue(false)
                    expectation.fulfill()

                }
               }
          
            print("xxx")
        },onError: { error in
            XCTFail("\(error.localizedDescription)")
            expectation.fulfill()
            
        }).disposed(by: bag)
        
        waitForExpectations(timeout: 10, handler: nil)

    }
}

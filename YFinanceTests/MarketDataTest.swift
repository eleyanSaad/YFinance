//
//  MarketDataTest.swift
//  YFinanceTests
//
//  Created by macbook on 16/05/2022.
//

import XCTest
import RxSwift

@testable import YFinance

class MarketDataTest: XCTestCase {
    let request = APIRequest()
    let userViewModelInstance = MarketViewModel()
    fileprivate let bag = DisposeBag()
    var markets: Observable<[Result]>?

    override func tearDown() {
        markets = nil
    }
    
    
    func testGetMarketSummary()  {
        let expectation = self.expectation(description: "response Error")
        markets = request.callMarketSummaryAPI()
        markets?.subscribe(onNext: { (value) in
            if value.count == 0 {
                XCTAssertTrue(false)
                expectation.fulfill()
            }else{
                XCTAssertTrue(true)
                expectation.fulfill()

            }
        }, onError:  { [weak self] error in

        }).disposed(by: bag)
        
        self.wait(for: [expectation], timeout: 5)
}

}

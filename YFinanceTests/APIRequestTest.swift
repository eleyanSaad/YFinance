//
//  APIRequestTest.swift
//  YFinanceTests
//
//  Created by macbook on 16/05/2022.
//

import XCTest
import Foundation
import RxSwift
@testable import YFinance

class APIRequestTest: XCTestCase {

    //MARK: - VARAIBLE
    var API : APIRequest!
    var markets: Observable<[Result]>?
    var stock: Observable<StockDetails>?
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        API = APIRequest()
        disposeBag = DisposeBag()
    }
    
    override  func tearDown() {
        super.tearDown()
        disposeBag = nil
        API = nil
    }
 
    func testFetchMarketSummaryList_Request() {
        let expectation = self.expectation(description: "response Error")
        markets = API.callMarketSummaryAPI()
        markets?.subscribe(onNext: { (value) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }, onError: { (error) in
            XCTFail("\(error.localizedDescription)")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchStocksSummary_Valid_Request() {
        let expectation = self.expectation(description: "response Error")
        stock = API.callStockSummaryAPI("^GSPC")
        stock?.subscribe(onNext: { (value) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }, onError: { (error) in
            print("error in test - \(error.localizedDescription)")

            XCTFail("\(error.localizedDescription)")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchStocksSummary_UnValid_Request() {
        let expectation = self.expectation(description: "response Error")
        stock = API.callStockSummaryAPI("")
        stock?.subscribe(onNext: { (value) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }, onError: { (error) in
            print("error in test - \(error.localizedDescription)")

            XCTFail("\(error.localizedDescription)")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }

}

//
//  URLS.swift
//  YFinance
//
//  Created by macbook on 12/05/2022.
//

import Foundation

class URLs {
    static let BaseURL = "https://yh-finance.p.rapidapi.com"
    static  let getMarketSummary = BaseURL + "/market/v2/get-summary?region=US"
    static func getStockSummary(symbol:String,region:String) -> String { return BaseURL + "/stock/v2/get-summary?symbol=\(symbol)&region=\(region)" }
}

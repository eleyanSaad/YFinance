//
//  User.swift
//  MVVM
//
//  Created by Milan Panchal on 19/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import UIKit

//struct MarketList: Codable {
//    let results: [DataModel]
//}

// MARK: - Market

// MARK: - MarketSummaryAndSparkResponse
// MARK: - Welcome


// MARK: - Welcome
struct DataModel: Codable {
    let marketSummaryAndSparkResponse: MarketSummaryAndSparkResponse?
}

// MARK: - MarketSummaryAndSparkResponse
struct MarketSummaryAndSparkResponse: Codable {
    let result: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let fullExchangeName, exchangeTimezoneName, symbol: String?
    let gmtOffSetMilliseconds, firstTradeDateMilliseconds, exchangeDataDelayedBy: Int?
    let language: Language?
    let regularMarketTime: RegularMarket?
    let exchangeTimezoneShortName, quoteType, marketState: String?
    let customPriceAlertConfidence: CustomPriceAlertConfidence?
    let market: String?
    let spark: Spark?
    let priceHint: Int?
    let tradeable: Bool?
    let sourceInterval: Int?
    let exchange: String?
    let region: Region?
    let shortName: String?
    let regularMarketPreviousClose: RegularMarket?
    let triggerable: Bool?
}

enum CustomPriceAlertConfidence: String, Codable {
    case low = "LOW"
}

enum Language: String, Codable {
    case enUS = "en-US"
}

enum Region: String, Codable {
    case us = "US"
}

// MARK: - RegularMarket
struct RegularMarket: Codable {
    let raw: Double?
    let fmt: String?
}

// MARK: - Spark
struct Spark: Codable {
    let symbol: String?
    let timestamp: [Int]?
    let previousClose, chartPreviousClose: Double?
    let dataGranularity: Int?
    let close: [Double]?
    let end, start: Int?
}

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


struct StockDetails: Codable {
    let quoteType: QuoteType?
    let symbol: String?
    let price: Price?
    let summaryDetail: SummaryDetail?
    let futuresChain: FuturesChain?
}

// MARK: - FuturesChain
struct FuturesChain: Codable {
    let futures: [String]?
    let maxAge: Int?
}

// MARK: - FuturesChainDetail
struct FuturesChainDetail: Codable {
    let sourceInterval: Int?
    let esgPopulated: Bool?
    let quoteSourceName, exchange: String?
    let regularMarketTime: Int?
    let shortName, exchangeTimezoneName: String?
    let regularMarketChange, regularMarketPreviousClose: Double?
    let contractSymbol: Bool?
    let exchangeTimezoneShortName: String?
    let exchangeDataDelayedBy, expireDate: Int?
    let customPriceAlertConfidence: String?
    let regularMarketPrice: Int?
    let triggerable: Bool?
    let gmtOffSetMilliseconds, firstTradeDateMilliseconds: Int?
    let region: String?
    let expireISODate: String?
    let marketState, quoteType, symbol, language: String?
    let headSymbolAsString, market, typeDisp: String?
    let regularMarketChangePercent: Double?
    let fullExchangeName: String?
    let tradeable: Bool?

}

// MARK: - Price
struct Price: Codable {
    let quoteSourceName: String?
    let regularMarketOpen: ExpireDate?
    let averageDailyVolume3Month: AverageDailyVolume10Day?
    let exchange: String?
    let regularMarketTime: Int?
    let regularMarketDayHigh: ExpireDate?
    let shortName: String?
    let averageDailyVolume10Day: AverageDailyVolume10Day?
    let longName: String?
    let regularMarketChange: ExpireDate?
    let currencySymbol: String?
    let regularMarketPreviousClose: ExpireDate?
    let exchangeDataDelayedBy: Int?
    let toCurrency: String?
    let expireDate: ExpireDate?
    let exchangeName: String?
    let regularMarketDayLow: ExpireDate?
    let priceHint: AverageDailyVolume10Day?
    let currency: String?
    let regularMarketPrice: ExpireDate?
    let regularMarketVolume: AverageDailyVolume10Day?
    let lastMarket: String?
    let regularMarketSource: String?
    let openInterest: AverageDailyVolume10Day?
    let marketState, underlyingSymbol: String?
    let quoteType: String?
    let symbol: String?
    let maxAge: Int?
    let fromCurrency: String?
    let regularMarketChangePercent: ExpireDate?
}

// MARK: - AverageDailyVolume10Day
struct AverageDailyVolume10Day: Codable {
    let raw: Int?
    let fmt: String?
    let longFmt: String?
}

// MARK: - ExpireDate
struct ExpireDate: Codable {
    let raw: Double?
    let fmt: String?
}

// MARK: - QuoteType
struct QuoteType: Codable {
    let exchange, shortName, exchangeTimezoneName, exchangeTimezoneShortName: String?
    let isEsgPopulated: Bool?
    let gmtOffSetMilliseconds, underlyingSymbol, quoteType, symbol: String?
    let underlyingExchangeSymbol, headSymbol, market: String?
}

// MARK: - SummaryDetail
struct SummaryDetail: Codable {
    let previousClose, regularMarketOpen, twoHundredDayAverage: ExpireDate?
    let regularMarketDayHigh: ExpireDate?
    let averageDailyVolume10Day: AverageDailyVolume10Day?
    let regularMarketPreviousClose, fiftyDayAverage: ExpireDate?
    let summaryDetailOpen: ExpireDate?
    let toCurrency: String?
    let averageVolume10Days: AverageDailyVolume10Day?
    let expireDate: ExpireDate?
    let algorithm: String?
    let regularMarketDayLow: ExpireDate?
    let priceHint: AverageDailyVolume10Day?
    let currency: String?
    let regularMarketVolume: AverageDailyVolume10Day?
    let lastMarket: String?
    let openInterest: AverageDailyVolume10Day?
    let averageVolume: AverageDailyVolume10Day?
    let dayLow, ask: ExpireDate?
    let askSize, volume: AverageDailyVolume10Day?
    let fiftyTwoWeekHigh: ExpireDate?
    let maxAge: Int?
    let fromCurrency: String?
    let fiftyTwoWeekLow, bid: ExpireDate?
    let tradeable: Bool?
    let bidSize: AverageDailyVolume10Day?
    let dayHigh: ExpireDate?
}

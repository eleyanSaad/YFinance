//
//  StockDetailsVC.swift
//  YFinance
//
//  Created by macbook on 13/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StockDetailsVC: UIViewController {

    // MARK: - VARAIBLE
    @IBOutlet var bidLabel: UILabel!
    @IBOutlet var regularMarketPriceLabel: UILabel!
    @IBOutlet var marketChangeLabel: UILabel!
    @IBOutlet var marketPriceLabel: UIStackView!
    @IBOutlet var shortNameLabel: UILabel!
    @IBOutlet var regularMarketChangePercentChangeLabel: UILabel!
    @IBOutlet var expireDateLabel: UILabel!
    @IBOutlet var lastPriceLabel: UILabel!
    @IBOutlet var daysRangeLabel: UILabel!
    @IBOutlet var askLabel: UILabel!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var openLabel: UILabel!
    
    // MARK: - VARAIBLE
    let stockViewModelInstance = MarketViewModel()
    fileprivate let bag = DisposeBag()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockViewModelInstance.fetchStockSummary(name: name)
        getStockDetails()
    }
    
    func getStockDetails(){
        stockViewModelInstance.stockViewModelObserver.subscribe(onNext: { (value) in
            DispatchQueue.main.async {
                
                self.shortNameLabel.text = "\(value?.quoteType?.shortName ?? "")(\(value?.quoteType?.symbol ?? ""))"
                self.regularMarketPriceLabel.text  = value?.price?.regularMarketPrice?.fmt ?? ""
                self.marketChangeLabel.text = "+\(value?.price?.regularMarketChange?.fmt ?? "0")"
                
                self.regularMarketChangePercentChangeLabel.text = "(+\(value?.price?.regularMarketChangePercent?.fmt ?? "0"))"
                self.expireDateLabel.text = value?.price?.expireDate?.fmt ?? ""
                self.lastPriceLabel.text = value?.price?.regularMarketPreviousClose?.fmt ?? ""

                self.daysRangeLabel.text = "\(value?.price?.regularMarketDayLow?.fmt ?? "0" ) - \(value?.price?.regularMarketDayHigh?.fmt ?? "0") "
                self.volumeLabel.text = value?.summaryDetail?.volume?.fmt ?? "0"
                self.askLabel.text = value?.summaryDetail?.ask?.fmt ?? "0"
                self.bidLabel.text = value?.summaryDetail?.bid?.fmt ?? "0"
                self.openLabel.text = value?.price?.regularMarketOpen?.fmt ?? "0"
               }
          
        },onError: { error in
            self.errorAlert(title: "Aelrt", body: "\(error.localizedDescription)")
        }).disposed(by: bag)
    }
}

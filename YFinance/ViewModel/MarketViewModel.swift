
import Foundation
import RxSwift
import RxCocoa


class MarketViewModel {
    
    // MARK: - VARAIBLE
    let request = APIRequest()
    var markets: Observable<[Result]>?
    var stock: Observable<StockDetails>?
    var marketViewModelObserver: Observable<[Result]> {
        return marketSummaryViewModel.asObservable()
    }
    var stockViewModelObserver: Observable<StockDetails?> {
        return stockDetails.asObservable()
    }
    
    let stockDetails:BehaviorRelay<StockDetails?> = BehaviorRelay<StockDetails?>(value:nil)
    private let marketSummaryViewModel = BehaviorRelay<[Result]>(value: [])
    private let disposeBag = DisposeBag()
    let didFailSignIn = PublishSubject<Error>()

    
    
    func fetchUserList() {
        markets = request.callMarketSummaryAPI()
        markets?.subscribe(onNext: { (value) in
            var marketViewModelArray : [Result] = []
            for index in 0..<value.count {
                marketViewModelArray.append(value[index])
            }
            self.marketSummaryViewModel.accept(marketViewModelArray)
        }, onError:  { [weak self] error in
            self?.didFailSignIn.onNext(error)
        }).disposed(by: disposeBag)
    }
    

    func fetchStockSummary(name: String) {
        stock = request.callStockSummaryAPI(name)
        stock?.subscribe(onNext: { (value) in
            var stocModal : StockDetails?
            stocModal = value
            self.stockDetails.accept(stocModal)
        }, onError: { (error) in
            _ = self.stockDetails.catchError { (error) in
                Observable.empty()
            }
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

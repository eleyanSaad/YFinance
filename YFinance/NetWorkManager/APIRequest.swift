

import Foundation
import RxCocoa
import RxSwift

protocol APIRequestProtocol {
     func callMarketSummaryAPI<T: Codable>() -> Observable<T>
}

class APIRequest: APIRequestProtocol {
    let headers = [
        "X-RapidAPI-Host": "yh-finance.p.rapidapi.com",
        "X-RapidAPI-Key": "455590d3admsh1a0e077a455d06dp12dd4fjsndc7258ef54aa"
    ]

    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
    
    
    func callMarketSummaryAPI<T: Codable>() -> Observable<T> {
        let url = URL(string: URLs.getMarketSummary)!
        let request = NSMutableURLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        //create an observable and emit the state as per response.
        return Observable<T>.create { observer in
            self.dataTask = self.session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let networkError = NetworkError(data: data, response: response, error: error) {
                    
                    print(networkError)
                    observer.onError(error as! Error)

                    return
                     }
                     
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                    }
                    let model: DataModel = try JSONDecoder().decode(DataModel.self, from: data!)
                    
                        observer.onNext(model.marketSummaryAndSparkResponse?.result as! T)
                    
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            self.dataTask?.resume()
            
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
    

    func callStockSummaryAPI<T: Codable>(_ name: String) -> Observable<T> {
        
        let decodeUrl = URLs.getStockSummary(symbol: name, region: "US").encodeUrl()!
        let url = URL(string: decodeUrl)!
        let request = NSMutableURLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        //create an observable and emit the state as per response.
        return Observable<T>.create { observer in
            self.dataTask = self.session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                do {
       
                    let model: StockDetails = try JSONDecoder().decode(StockDetails.self, from: data ?? Data())
                    observer.onNext(model as! T )
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            self.dataTask?.resume()
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
}

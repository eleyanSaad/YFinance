//
//  ViewController.swift
//  YFinance
//
//  Created by macbook on 12/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MarketListVC: UIViewController {
    // MARK: - OUTLETS
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - VARIABLE
    let marketData = BehaviorRelay<[Result]>(value: [])
    let marketDatafilteredList = BehaviorRelay<[Result]>(value: [])
    private var usersVM:[MarketViewModel] = []
    let userViewModelInstance = MarketViewModel()
    fileprivate let bag = DisposeBag()
    var updateTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTimer()
        setUpTableView()
        getMarketSummaryData()
        
    }
    
    // MARK: - FUNCATIONS
    func setUpTimer(){
        updateTimer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: "StockCell", bundle: Bundle.main), forCellReuseIdentifier: "stockCell")
        tableView.rowHeight = 60
        searchBar.delegate = self
    }
    
    func getMarketSummaryData(){
        userViewModelInstance.fetchUserList()
        userViewModelInstance.marketViewModelObserver.subscribe(onNext: { (value) in
            self.marketDatafilteredList.accept(value)
            self.marketData.accept(value)
        },onError: { error in
            self.errorAlert(title: "Alert", body: "\(error.localizedDescription)")
        }).disposed(by: bag)
        
        //This binds the table datasource with tableview and also connects the cell to it.
        marketDatafilteredList.bind(to: tableView.rx.items(cellIdentifier: StockCell.cellID, cellType: StockCell.self)) { row, model, cell in
            cell.configureCell(marketObject: model)
        }.disposed(by: bag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.tableView.deselectRow(at: indexPath, animated: true)
          
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StockDetailsVC") as? StockDetailsVC
            
            vc?.name = self.marketData.value[indexPath.row].symbol ?? ""
            self.navigationController?.pushViewController(vc!, animated: true)
        }).disposed(by: bag)
    }

    @objc func runTimedCode(){
//        userViewModelInstance.fetchUserList()
    }
}


// MARK: - UISearchBarDelegate
extension MarketListVC:UISearchBarDelegate{

    // Search code
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let length = searchText.count
        if length > 0 {
            Observable.combineLatest(marketData.asObservable(), searchBar.rx.text, resultSelector: { users, search in
                return users.filter { (user) -> Bool in
                    self.filterUserList(marketModel: user, searchText: search)
                }
            }).bind(to: marketDatafilteredList).disposed(by: bag)
        } else {
            tableView.reloadData()
        }
    }
    
    func filterUserList(marketModel: Result, searchText: String?) -> Bool {
        if let search = searchText, !search.isEmpty, !(marketModel.shortName?.contains(search) ?? false) {
            return false
        }
        return true
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        tableView.reloadData()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        tableView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

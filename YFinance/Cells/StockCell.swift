//
//  MarketResultsCell.swift
//  YFinance
//
//  Created by macbook on 12/05/2022.
//

import UIKit

class StockCell: UITableViewCell {
    
    // MARK: - OUTLET
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
 
    
    // MARK: - VARIABLE
    static var cellID = "stockCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(marketObject: Result) {
        symbolLbl.text = marketObject.symbol ?? ""
        companyLbl.text = marketObject.shortName ?? ""
        infoLbl.text = marketObject.fullExchangeName ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ProductoTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 30/12/22.
//

import UIKit
import SwipeCellKit

class ProductoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var NombreLabel: UILabel!
    @IBOutlet weak var PrecioUnitarioLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var DescripcionLabel: UILabel!
    
    @IBOutlet weak var IdProveedorLabel: UILabel!
    @IBOutlet weak var ImageProductoLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

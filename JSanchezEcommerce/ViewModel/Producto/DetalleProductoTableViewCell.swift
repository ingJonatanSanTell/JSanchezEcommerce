//
//  DetalleProductoTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 23/01/23.
//

import UIKit
import SwipeCellKit

class DetalleProductoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var NombreProductoLabel: UILabel!
    @IBOutlet weak var PrecioUnitarioProductoLabel: UILabel!
    @IBOutlet weak var StockProductoLabel: UILabel!
    @IBOutlet weak var DescripcionProductoLabel: UILabel!
    @IBOutlet weak var DepartamentoProductoLabel: UILabel!
    @IBOutlet weak var ProveedorProductoLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

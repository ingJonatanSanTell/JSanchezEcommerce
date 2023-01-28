//
//  CarritoTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 25/01/23.
//

import UIKit
import SwipeCellKit

class CarritoTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var NombreProductoCarritoLabel: UILabel!
    @IBOutlet weak var PrecioProductoCarritoLabel: UILabel!
    @IBOutlet weak var ImageProductoCarrito: UIImageView!
    @IBOutlet weak var CantidadProductoCarritoLabel: UILabel!
    @IBOutlet weak var CantidadProductoCarritoField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

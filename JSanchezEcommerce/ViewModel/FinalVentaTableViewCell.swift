//
//  FinalVentaTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/01/23.
//

import UIKit
import SwipeCellKit

class FinalVentaTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var ImagenProductoFinal: UIImageView!
    @IBOutlet weak var NombreProductoFinalLabel: UILabel!
    @IBOutlet weak var CantidadProductoFinalLabel: UILabel!
    
    @IBOutlet weak var TotalProductoFinalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

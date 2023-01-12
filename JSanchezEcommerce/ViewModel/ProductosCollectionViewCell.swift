//
//  ProductosCollectionViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 12/01/23.
//

import UIKit

class ProductosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImagenProducto: UIImageView!
    
    @IBOutlet weak var PrecioProductolabel: UILabel!
    @IBOutlet weak var NombreProductoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

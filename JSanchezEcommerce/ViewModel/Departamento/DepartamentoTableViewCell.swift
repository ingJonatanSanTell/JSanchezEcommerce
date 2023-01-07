//
//  DepartamentoTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit
import SwipeCellKit

class DepartamentoTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var IdAreaLabel: UILabel!
    @IBOutlet weak var NombreDepartamentoLabel: UILabel!
    
    @IBOutlet weak var ImagenDepartamento: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

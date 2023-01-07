//
//  UsuarioTableViewCell.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit
import SwipeCellKit

class UsuarioTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var UsuarioImage: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var NombreLabel: UILabel!
    @IBOutlet weak var ApellidoPaternoLabel: UILabel!
    @IBOutlet weak var ApellidoMaternoLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var FechaNacimientoLabel: UILabel!
    @IBOutlet weak var SexoLabel: UILabel!
    @IBOutlet weak var TelefonoLabel: UILabel!
    @IBOutlet weak var CelularLabel: UILabel!
    @IBOutlet weak var CurpLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

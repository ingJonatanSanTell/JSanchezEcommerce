//
//  Area.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 28/12/22.
//

import Foundation

struct Area{
    
    var IdArea : Int
    var Nombre : String
    
    init(IdArea: Int, Nombre: String) {
        self.IdArea = IdArea
        self.Nombre = Nombre
    }
    
    init(){
        
        self.IdArea = 0
        self.Nombre = ""
    }
}

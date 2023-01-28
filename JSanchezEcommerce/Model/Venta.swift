//
//  Venta.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 26/01/23.
//

import Foundation

struct Venta {
    
    var IdVenta : Int
    var Total : Double
    var Fecha : String
    var IdUsuario : Int
    var MetodoPago : MetodoPago?
    
    
    
    init(IdVenta: Int, Total: Double, Fecha: String, IdUsuario: Int, MetodoPago: MetodoPago? = nil) {
        self.IdVenta = IdVenta
        self.Total = Total
        self.Fecha = Fecha
        self.IdUsuario = IdUsuario
        self.MetodoPago = MetodoPago
    }
    
    init() {
        
        self.IdVenta = 0
        self.Total = 0.0
        self.Fecha = ""
        self.IdUsuario = 0
        self.MetodoPago = nil
    }
    
}

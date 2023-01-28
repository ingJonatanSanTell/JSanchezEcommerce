//
//  VentaFinalViewModel.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/01/23.
//

import Foundation
import SQLite3

class VentaFinalViewModel{
    
        
    //ADD
    func Add(venta : Venta) -> Result {
        
        var result = Result()
        let context = DB.init()
        
        let query = "INSERT INTO Venta(Total, Fecha, IdUsuario, IdMetodoPago) VALUES (?,?,?,?)"
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_double(statement, 1, Double(venta.Total))
                sqlite3_bind_text(statement, 2, (venta.Fecha as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 3, Int32(venta.IdUsuario))
                sqlite3_bind_int(statement, 4, Int32(venta.MetodoPago!.IdMetodoPago))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    
                }
                else
                {
                    result.Correct = false
                }
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}

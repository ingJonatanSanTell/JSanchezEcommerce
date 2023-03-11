//
//  VentaProductosViewModel.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 25/01/23.
//

import Foundation
import CoreData
import UIKit

class VentaProductosViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //Add VentaProducto
    func Add(idProducto : Int, cantidad : Int) -> Result {
        
        var result = Result()
        
        let existe = ValidarProductos(idProducto: idProducto)
        
        if existe == -1 {
            //producto no existente
            do{
                let context = appDelegate.persistentContainer.viewContext
                let entidad = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)
                let ventaCoreData = NSManagedObject(entity: entidad!, insertInto: context)
                
                ventaCoreData.setValue(idProducto, forKey: "idProducto")
                ventaCoreData.setValue(cantidad, forKey: "cantidad")
                
                try! context.save()
                result.Correct = true
                
            }catch let error {
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
        }
        else{
            //producto si existe
            do{
                let context = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
                let productos = try context.fetch(request) as! [NSManagedObject]
                
                productos[existe].setValue(productos[existe].value(forKey: "cantidad") as! Int + cantidad, forKey: "cantidad")
                
                try! context.save()
                result.Correct = true
                
            }catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
        }
        
        return result
    }
    
    //GetAll VentaProducto
    func GetAll() -> Result {
        
        var result = Result()
        
        do {
         
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let venta = try context.fetch(request) as! [NSManagedObject]
            
            result.Objects = []
            
            for producto in venta {
                
                let IdProducto = ProductoViewModel().GetById(idProducto: producto.value(forKey: "idProducto") as! Int).Object as! Producto
                
                let productoRecuperado = VentaProductos(IdVentaProducto: Int(producto.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!, Cantidad: producto.value(forKey: "cantidad") as! Int, Producto: IdProducto)
                
                result.Objects?.append(productoRecuperado)
            }
            
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
        
    }
    
    //delete productos carrito
    func Delete(idProducto : Int) -> Result {
        var result = Result()
        
        do{
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let producto = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(producto[idProducto])
            try context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        return result
    }
    
    
    //Validacion si hay Productos
    func ValidarProductos(idProducto : Int) -> Int{
        
        var exiatencia = -1
        
        do{
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let productos = try! context.fetch(request) as! [NSManagedObject]
            
            var contador = 0
            
            while productos.count > contador {
                if productos[contador].value(forKey: "idProducto") as! Int == idProducto {
                    exiatencia = contador
                    break
                }
                contador += 1
            }
        }
        return exiatencia
    }
    
    
    //delete productos carrito
    func DeleteCarrito(idProducto : Int) -> Result {
        var result = Result()
        
        do{
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            let producto = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(producto[idProducto])
            try context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        return result
    }
}

//
//  UsuarioViewModel.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import Foundation
import CoreData
import UIKit

class UsuarioViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(usuario : User) -> Result{
        
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            
            
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
            usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
            usuarioCoreData.setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            usuarioCoreData.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            usuarioCoreData.setValue(usuario.Email, forKey: "email")
            usuarioCoreData.setValue(usuario.Password, forKey: "password")
            usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
            usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
            usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
            usuarioCoreData.setValue(usuario.Curp, forKey: "curp")
            usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func Update(usuario : User) -> Result{
        
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Usuario")
        request.predicate = NSPredicate(format: "IdUsuario = %@", "")
        
        
        do{
            
            let usuarios = try context.fetch(request)
            let objUsuario = usuarios[0] as! NSManagedObject
            
            objUsuario.setValue(usuario.IdUsuario, forKey: "idUsuario")
            objUsuario.setValue(usuario.UserName, forKey: "userName")
            objUsuario.setValue(usuario.Nombre, forKey: "nombre")
            objUsuario.setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            objUsuario.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            objUsuario.setValue(usuario.Email, forKey: "email")
            objUsuario.setValue(usuario.Password, forKey: "password")
            objUsuario.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            objUsuario.setValue(usuario.Sexo, forKey: "sexo")
            objUsuario.setValue(usuario.Telefono, forKey: "telefono")
            objUsuario.setValue(usuario.Celular, forKey: "celular")
            objUsuario.setValue(usuario.Curp, forKey: "curp")
            objUsuario.setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func GetAll() -> Result{
        
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        do{
            let usuarios = try context.fetch(request)
            result.Objects = [User]()
            
            for objUsuario in usuarios as! [NSManagedObject]{
                var usuario = User()
                
                usuario.UserName = objUsuario.value(forKey: "userName") as! String
                usuario.Nombre = objUsuario.value( forKey: "nombre") as! String
                usuario.ApellidoPaterno = objUsuario.value( forKey: "apellidoPaterno") as! String
                usuario.ApellidoMaterno = objUsuario.value( forKey: "apellidoMaterno") as! String
                usuario.Email = objUsuario.value( forKey: "email") as! String
                usuario.Password = objUsuario.value( forKey: "password") as! String
                usuario.FechaNacimiento = objUsuario.value( forKey: "fechaNacimiento") as! Date
                usuario.Sexo = objUsuario.value( forKey: "sexo") as! String
                usuario.Telefono = objUsuario.value(forKey: "telefono") as! String
                usuario.Celular = objUsuario.value(forKey: "celular") as! String
                usuario.Curp = objUsuario.value(forKey: "curp") as! String
                usuario.Imagen = objUsuario.value(forKey: "imagen") as! String
                
                result.Objects?.append(usuario)
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func GetById(idUsuario : Int) -> Result{
        
        var result = Result()
        
        /*do{
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        let usuarios = try context.fetch(request) as! [NSManagedObject]
        
            usuario = User(IdUsuario: Int(usuarios[idUsuario].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                           UserName: usuarios[idUsuario].value(forKey: "userName") as! String,
                           Nombre: usuarios[idUsuario].value( forKey: "nombre") as! String,
                           ApellidoPaterno: usuarios[idUsuario].value( forKey: "apellidoPaterno") as! String,
                           ApellidoMaterno: usuarios[idUsuario].value( forKey: "apellidoMaterno") as! String,
                           Email: usuarios[idUsuario].value( forKey: "email") as! String,
                           Password: usuarios[idUsuario].value( forKey: "password") as! String,
                           FechaNacimiento: usuarios[idUsuario].value( forKey: "fechaNacimiento") as! Date,
                           Sexo: usuarios[idUsuario].value( forKey: "sexo") as! String,
                           Telefono: usuarios[idUsuario].value(forKey: "telefono") as! String,
                           Celular: usuarios[idUsuario].value(forKey: "celular") as! String,
                           Curp: usuarios[idUsuario].value(forKey: "curp") as! String,
                           Imagen: usuarios[idUsuario].value(forKey: "imagen") as! String)
                
                //usuario.IdUsuario = objUsuario.objectID.uriRepresentation().absoluteString

                
            result.Objects = usuario
            result.Correct = true
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }*/
        
        return result
    }

        
    
    func Delete(idUsuario : Int) -> Result{
        
        var result = Result()
        
        do{
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(usuarios[idUsuario])
            
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

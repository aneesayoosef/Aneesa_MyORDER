//
//  CoreDBHelper.swift
//  Aneesa_MyORDER
//
//  Created by user195932 on 5/18/21.
//

import Foundation
import CoreData
import UIKit

class CoreDBHelper{
    
    //singleton instance (pattern)
    private static var shared : CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper {
        if shared != nil{
            //instance of CoreDBHelper class already exists, so return the same
            return shared!
        }else{
            //there is no existing instance of CoreDBHelper class, so create new and return
            shared = CoreDBHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Coffee"
    
    private init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertCoffee(type: String, size: String,q:Int){
        do{
            
            let coffeeToBeInserted = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Coffee
            
            coffeeToBeInserted.coffeeType = type
            coffeeToBeInserted.coffeeSize = size
            coffeeToBeInserted.quantity = Int64(Int(q))
            coffeeToBeInserted.id = UUID()
            coffeeToBeInserted.date = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Data is saved successfully")
            }
            
        }catch let error as NSError{
            print(#function, "Could not save the data \(error)")
        }
    }
    
    private func searchCoffee(coffeId : UUID) -> Coffee?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", coffeId as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? Coffee
            }
            
        }catch let error as NSError{
            print(#function, "Unable to search for task \(error)")
        }
        
        return nil
        
    }
    
    func updateCoffee(updateCoffee: Coffee){
        let searchResult = self.searchCoffee(coffeId: updateCoffee.id! as UUID)
        
        if (searchResult != nil){
            //matching task found
            
            do{
                
                let coffeUpdated = searchResult!
                
                coffeUpdated.coffeeType = updateCoffee.coffeeType
                coffeUpdated.coffeeSize = updateCoffee.coffeeSize
                coffeUpdated.quantity = updateCoffee.quantity
                
                try self.moc.save()
                print(#function, "Task Updated Successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to update task \(error)")
            }
            
        }else{
            print(#function, "No matching task found")
        }
    }
    
    func deleteCoffee(coffeID : UUID){
        let searchResult = self.searchCoffee(coffeId: coffeID)
        
        if (searchResult != nil){
            //matching object found
            do{
                
                self.moc.delete(searchResult!)
                try self.moc.save()
                
//                let delegate = UIApplication.shared.delegate as! AppDelegate
//                delegate.saveContext()
                
                print(#function, "Coffee deleted successfully")
                
                
            }catch let error as NSError{
                print(#function, "Couldn't delete coffee \(error)")
            }
        }else{
            print(#function, "No matching record found")
        }
    }
    
    func getAllCoffees() -> [Coffee]? {
        let fetchRequest = NSFetchRequest<Coffee>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Fetched data : \(result as [Coffee])")
            
            return result as [Coffee]
            
        }catch let error as NSError{
            print(#function, "Could not fetch data from Database \(error)")
        }
        
        return nil
    }
    
}

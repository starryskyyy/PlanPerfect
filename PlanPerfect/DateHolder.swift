//
//  DateHolder.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-24.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject
{
    
    init(_ context: NSManagedObjectContext){
        
    }
    
    func saveContext(_ context: NSManagedObjectContext){
        do{
            try context.save()
        }catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}

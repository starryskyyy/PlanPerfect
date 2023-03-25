//
//  PlanPerfectApp.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-03-24.
//

import SwiftUI

@main
struct PlanPerfectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

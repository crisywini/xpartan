//
//  xpartanApp.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 25/02/26.
//

import SwiftUI
import SwiftData

@main
struct xpartanApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[ User.self,
                              Routine.self,
                              Excercise.self,
                              ExcerciseSet.self]
        )
    }
}

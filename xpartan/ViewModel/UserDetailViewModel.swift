//
//  UserDetailViewModel.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 7/03/26.
//

import SwiftUI
import SwiftData

@Observable
class UserDetailViewModel {
    
    var user: User
    
    var activeRoutine: Routine? = nil
    
    init(user: User) {
        self.user = user
    }
    
    func createRoutine(){
        activeRoutine = Routine(name: "Xpartano")
    }
}


//
//  AddUserViewModel.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 7/03/26.
//

import SwiftUI
import SwiftData

@Observable
class AddUserViewModel {
    
    //Model
    var name: String = ""
    var height: String = ""
    var weight: String = ""
    var age: String = ""
    var photoData: Data?
    
    //View
    var shouldDismiss = false
    
    
    var isFormValid: Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty && !height.trimmingCharacters(in: .whitespaces).isEmpty && !weight.trimmingCharacters(in: .whitespaces).isEmpty && !age.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func saveUser(selectedGender: String, selectedCategory: String, modelContext: ModelContext) {
        let user = User(
                        photo: photoData,
                        name: name,
                        height: Double(height) ?? 0.0,
                        weight: Double(weight) ?? 0.0,
                        gender: selectedGender,
                        category: selectedCategory,
                        age: Int(age) ?? 18,
                        )
        modelContext.insert(user)
        shouldDismiss = true
    }
    

}

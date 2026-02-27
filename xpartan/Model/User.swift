//
//  User.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation

import SwiftData

@Model
final class User {
    
    var photo: Data?
    var name: String
    var height: Double
    var weight: Double
    var gender: String
    var category: String
    var age: Int
    var routines: [Routine]
    
    init(name: String, height: Double, weight: Double, gender: String, category: String, age: Int) {
        self.photo = nil
        self.name = name
        self.height = height
        self.weight = weight
        self.gender = gender
        self.category = category
        self.age = age
        self.routines = []
    }
}

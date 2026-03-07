//
//  AddUserView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation

import SwiftUI
import SwiftData

import PhotosUI

struct AddUserView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var gender: String = ""
    @State private var category: String = ""
    @State private var age: String = ""
    
    @State private var photoData: Data?
    @State private var selectedPhoto: PhotosPickerItem?
    
    @State private var selectedGender: Gender = .male
    @State private var selectedCategory: Category = .wild
    
    var isFormValid: Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty && !height.trimmingCharacters(in: .whitespaces).isEmpty && !weight.trimmingCharacters(in: .whitespaces).isEmpty && !age.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                photoSection
                basicInfoSection
            }
            .navigationTitle("Nuevo Usuario")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        saveUser()
                    }
                    .disabled(!isFormValid)
                    .bold()
                }
            }
            .onChange(of: selectedPhoto) { _, newValue in
                Task {
                    photoData = try? await newValue?.loadTransferable(type: Data.self)
                }
                
            }
        }
    }
    
    private var photoSection: some View {
        Section("Foto") {
            HStack {
                Spacer()
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    if let photoData, let uiImage =  UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "camera.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .opacity(0.6)
                            Text("Agrega una foto")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 120, height: 120)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
    
    private var basicInfoSection: some View{
        Section("Información básica"){
            TextField("Nombre", text: $name)
            TextField("Altura", text: $height)
                .keyboardType(.decimalPad)
            TextField("Peso", text: $weight)
                .keyboardType(.decimalPad)
            TextField("Edad", text: $age)
                .keyboardType(.numberPad)
            Picker("Genero", selection: $selectedGender){
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
            Picker("Categoria", selection: $selectedCategory) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
        }
    }
    
    private func saveUser() {
        let user = User(
                        photo: photoData,
                        name: name,
                        height: Double(height) ?? 0.0,
                        weight: Double(weight) ?? 0.0,
                        gender: selectedGender.rawValue,
                        category: selectedCategory.rawValue,
                        age: Int(age) ?? 18,
                        )
        modelContext.insert(user)
        dismiss()
    }
    
    
}


enum Gender: String, CaseIterable {
    case male = "Hombre"
    case female = "Mujer"
    case other = "Otro"
}


enum Category: String, CaseIterable {
    case wild = "Wild"
    case beginner = "Begins"
}

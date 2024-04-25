//
//  Categories.swift
//  Venmo
//
//  Created by Burak Aksu on 4/23/24.
//

import SwiftUI
import RealmSwift

struct Categories: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isAlertShowing: Bool = false
    @State private var newCategoryName: String = ""
    @State private var newCategoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    func handleSubmit() {
        print("In submit")
        if newCategoryName.count > 0 {
            realmManager.submitCategory(Category(name: newCategoryName, color: newCategoryColor))
            newCategoryName = ""
        } else {
            isAlertShowing = true
        }
    }
    
    func handleDelete(at offsets: IndexSet) {
        if offsets.first != nil {
            realmManager.deleteCategory(category: realmManager.categories[offsets.first!])
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(realmManager.categories, id: \.name) { category in
                    HStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(category.color)
                            .cornerRadius(6)
                            .overlay(
                                Circle()
                                    .stroke(.gray, lineWidth: 2)
                            )
                        Text(category.name)
                    }
                }
                .onDelete(perform: handleDelete)
                
            }
            
            Spacer()
            
            HStack {
                ColorPicker("New Category Color Picker",selection: $newCategoryColor)
                    .labelsHidden()
                
                ZStack(alignment: .trailing) {
                    
                    TextField("New Category", text: $newCategoryName)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit {
                            handleSubmit()
                        }
                    
                    if newCategoryName.count > 0 {
                        Button {
                            newCategoryName = ""
                        } label: {
                            Label("Clear input", systemImage: "xmark.circle.fill")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.gray)
                                .padding(.trailing, 6)
                        }
                    }
                }
                
                Button {
                    handleSubmit()
                } label: {
                    Label("Submit", systemImage: "paperplane.fill")
                        .labelStyle(.iconOnly)
                        .padding(6)
                }
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(6)
                .alert(isPresented: $isAlertShowing) {
                    Alert(title: Text("Invalid Input"), message: Text("Make sure to input a name"))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .navigationTitle("Categories")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    hideKeyboard()
                } label: {
                    Label("Dismiss", systemImage: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}

#Preview {
    Categories()
}

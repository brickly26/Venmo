//
//  Add.swift
//  Venmo
//
//  Created by Burak Aksu on 4/24/24.
//

import SwiftUI
import RealmSwift

struct Add: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var selectedCategory: Category = Category(name: "Create a category first", color: Color.clear)
    
    @State private var amount = ""
    @State private var recurrance = Recurrence.none
    @State private var date = Date()
    @State private var note = ""
    
//    var dataClosedRange: ClosedRange<Date> {
//        let min = Calander.current.date(byAdding: .year, value: -1, to: Date())
//        let max = Date()
//        return min...max
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("Amount",  text: $amount)
                            .multilineTextAlignment(.trailing)
                            .submitLabel(.done)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Recurrance")
                        Spacer()
                        Picker(selection: $recurrance, label: Text(""), content: {
                            Text("None").tag(Recurrence.none)
                            Text("Daily").tag(Recurrence.daily)
                            Text("Weekly").tag(Recurrence.weekly)
                            Text("Monthly").tag(Recurrence.monthly)
                            Text("Yearly").tag(Recurrence.yearly)
                        })
                    }
                    
                    HStack {
                        Text("Date")
                        Spacer()
                        DatePicker(
                            selection: $date,
//                            in: dateClosedRange,
//                            displayedComponents: .data
                            label: { Text("") }
                        )
                    }
                    
                    HStack {
                        Text("Note")
                        Spacer()
                        TextField("Note", text: $note)
                            .multilineTextAlignment(.trailing)
                            .submitLabel(.done)
                    }
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker(
                            selection: $selectedCategory,
                            label: Text(""), content: {
                                if realmManager.categories.count > 0 {
                                    ForEach(realmManager.categories) { category in
                                        Text(category.name).tag(category)
                                    }
                                } else {
                                    Text(selectedCategory.name).tag(selectedCategory)
                                }
                            }
                        )
                    }
                }
                
                
                Button {
                    print("hanldeCreate")
                } label: {
                    Label("Submit Expense", systemImage: "plus")
                        .labelStyle(.titleOnly)
                        .padding(.horizontal, 44)
                        .padding(.vertical, 12)
                }
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                
                Spacer()
            }
            .background(.clear)
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
            .navigationTitle("Add")
        }
        .onAppear {
            print("on Appear")
        }
    }
}

#Preview {
    Add()
}

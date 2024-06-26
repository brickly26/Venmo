//
//  RealmManager.swift
//  Venmo
//
//  Created by Burak Aksu on 4/24/24.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var expenses: [Expense] = []
    @Published var categories: [Category] = []
    
    init() {
        openRealm()
        
        loadExpenses()
        loadCategories()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
                
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func loadExpenses() {
        if let localRealm = localRealm {
            let allExpenses = localRealm.objects(Expense.self).sorted(byKeyPath: "date")
            
            expenses = []
            
            allExpenses.forEach { expense in
                expenses.append(expense)
            }
        }
    }
    
    func loadCategories() {
        if let localRealm = localRealm {
            let allCategories = localRealm.objects(Category.self)
            
            categories = []
            
            allCategories.forEach { category in
                categories.append(category)
            }
        }
    }
    
    func submitCategory(_ category: Category) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(category)
                    
                    loadCategories()
                    print("Category Submitted to Realm!", category)
                }
            } catch {
                print("Error submitting category to Realm:  \(error)")
            }
        }
    }
    
    func deleteCategory(category: Category) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.delete(category)
                    
                    loadCategories()
                    print("Category deleted from Realm!", category)
                }
            } catch {
                print("Error deleting category from Realm: \(error)")
            }
        }
    }
}

//
//  Settings.swift
//  Venmo
//
//  Created by Burak Aksu on 4/22/24.
//

import SwiftUI
import RealmSwift

struct Settings: View {
    @State private var showEraseConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    Categories()
                } label: {
                    HStack {
                        Text("Categories")
                    }
                }
                Button(role: .destructive) {
                    showEraseConfirmation = true
                } label: {
                    Text("Erase Data")
                }
                .alert(isPresented: $showEraseConfirmation) {
                    Alert(title: Text("Are you sure?"), message: Text("This action cannot be undone."), primaryButton: .destructive(Text("Erase data")) {
                            let realm = try! Realm()
                            realm.beginWrite()
                            realm.deleteAll()
                            try! realm.commitWrite()
                        },
                          secondaryButton: .cancel()
                    )
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}

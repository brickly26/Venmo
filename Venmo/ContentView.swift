//
//  ContentView.swift
//  Venmo
//
//  Created by Burak Aksu on 4/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        TabView {
            Expenses()
                .tabItem {
                    Label("Expenses", systemImage: "tray.and.arrow.down.fill")
                }
            
            Reports()
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
            
            Add()
                .environmentObject(realmManager)
                .tabItem {
                    Label("Add", systemImage:"plus")
                }
            
            Settings()
                .environmentObject(realmManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
            
    }
}

#Preview {
    ContentView()
}

//
//  BusesView.swift
//  BusesView
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

struct BusesView: View {
    @State var buses = [Bus]()
    @State var searchText: String = ""
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(filteredBuses) { bus in
                        NavigationLink(destination: BusDetailView(bus: bus)) {
                            BusBox(bus: bus)
                        }
                    }
                }
                .padding(.horizontal, 17)
            }
            .searchable(text: $searchText.animation(), prompt: "Filter by name, start or destination")
            .navigationTitle("Bus+")
            .toolbar {
                Button(action: loadBuses) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
        }
        .task(loadBuses)
    }
    
    var filteredBuses: [Bus] {
        if searchText.isEmpty {
            return buses
        } else {
            return buses.filter { bus in
                // Mirror creates object
                let busMirror = Mirror(reflecting: bus)
                var isGood = false
                
                for child in busMirror.children {
                    if let value = child.value as? String {
                        if value.localizedCaseInsensitiveContains(searchText) {
                            isGood = true
                            break
                        }
                    }
                }
                return isGood
            }
        }
    }
    
    func loadBuses() {
        Task {
            let url = URL(string: "https://hws.dev/bus-timetable")!
            buses = try await URLSession.shared.decode(from: url)
        }
    }
}


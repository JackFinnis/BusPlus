//
//  BusesView.swift
//  BusesView
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

struct BusesView: View {
    @State var buses = [Bus]()
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            List {
                LazyVGrid(columns: layout) {
                    ForEach(buses) { bus in
                        NavigationLink(destination: BusDetailView(bus: bus)) {
                            BusBox(bus: bus)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable(action: loadBuses)
            .navigationTitle("Bus+")
        }
        .tint(.indigo)
        .task(loadBuses)
    }
    
    func loadBuses() async {
        do {
            let url = URL(string: "https://hws.dev/bus-timetable")!
            buses = try await URLSession.shared.decode(from: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}


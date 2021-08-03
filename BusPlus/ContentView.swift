//
//  ContentView.swift
//  BusPlus
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

extension URLSession {
    func decode<T: Decodable>(_ type: T.Type = T.self, from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

struct Bus: Decodable, Identifiable {
    let id: Int
    let name: String
    let location: String
    let destination: String
    let passengers: Int
    let fuel: Int
    let image: URL
}

struct ContentView: View {
    @State var buses = [Bus]()
    
    var body: some View {
        NavigationView {
            List(buses) { bus in
                NavigationLink(destination: Text(bus.name)) {
                    HStack(alignment: .top) {
                        AsyncImage(url: bus.image) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "bus")
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(5)
                        
                        VStack(alignment: .leading) {
                            Text(bus.location)
                                .font(.headline)
                            HStack {
                                Image(systemName: "arrow.turn.down.right")
                                    .foregroundColor(.indigo)
                                Text(bus.destination)
                                    .font(.headline)
                            }
                            Text(bus.name)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.indigo)
                                Text("\(bus.passengers)")
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "fuelpump.fill")
                                    .foregroundColor(.indigo)
                                Text("\(bus.fuel)")
                            }
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

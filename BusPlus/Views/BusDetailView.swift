//
//  BusDetailView.swift
//  BusDetailView
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

struct BusDetailView: View {
    let bus: Bus
    
    var body: some View {
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

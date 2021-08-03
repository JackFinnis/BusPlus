//
//  BusBox.swift
//  BusBox
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

struct BusBox: View {
    let bus: Bus
    
    var body: some View {
        ZStack {
            AsyncImage(url: bus.image) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "bus")
            }
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(bus.location)
                            .font(.subheadline)
                            .lineLimit(1)
                        HStack {
                            Image(systemName: "arrow.turn.down.right")
                                .font(.subheadline.bold())
                                .foregroundColor(.indigo)
                            Text(bus.destination)
                                .font(.subheadline)
                                .lineLimit(1)
                        }
                    }
                    .padding(5)
                    Spacer()
                }
                .background(.thinMaterial)
            }
        }
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(10)
    }
}

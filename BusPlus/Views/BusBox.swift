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
                    .foregroundColor(.indigo)
            }
            VStack {
                HStack {
                    Text(bus.name)
                        .font(.subheadline.bold())
                        .lineLimit(1)
                    Spacer()
                }
                .padding(5)
                .padding(.horizontal, 3)
                .background(.regularMaterial)
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
                    Spacer()
                }
                .padding(5)
                .padding(.horizontal, 3)
                .background(.regularMaterial)
            }
            .foregroundColor(.black)
        }
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(10)
    }
}

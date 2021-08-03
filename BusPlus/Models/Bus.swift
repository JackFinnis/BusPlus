//
//  Bus.swift
//  Bus
//
//  Created by William Finnis on 03/08/2021.
//

import Foundation

struct Bus: Decodable, Identifiable {
    let id: Int
    let name: String
    let location: String
    let destination: String
    let passengers: Int
    let fuel: Int
    let image: URL
}

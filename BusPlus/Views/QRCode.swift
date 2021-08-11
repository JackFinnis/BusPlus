//
//  QRCode.swift
//  QRCode
//
//  Created by William Finnis on 04/08/2021.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct QRCode: View {
    @FocusState var focus: Bool?
    
    @State var name: String = ""
    @State var ref: String = ""
    
    @State var context = CIContext()
    @State var filter = CIFilter.qrCodeGenerator()
    
    var qrCode: Image {
        let id = name + ref
        let data = Data(id.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                return  Image(uiImage: uiImage)
            }
        }
        
        return Image(systemName: "xmark.circle")
    }
    
    var str: String {
        Date.now.formatted()
        + ["actor", "class", "enum"].formatted()
        + ["actor", "class", "enum"].formatted()
        + 0.9999.formatted(.percent)
        + 0.9999.formatted(.percent.precision(.fractionLength(1)))
        + Measurement(value: 500, unit: UnitLength.centimeters).formatted()
    }
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .focused($focus, equals: true)
                .textContentType(.name)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.next)
            TextField("Ref", text: $ref)
                .focused($focus, equals: true)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .keyboardType(.numberPad)
            qrCode
                .interpolation(.none)
                .resizable()
                .frame(width: 250, height: 250)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    focus = nil
                }
            }
        }
    }
}

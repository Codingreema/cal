////
////  ContentView.swift
////  cal
////
////  Created by Rimah on 25/03/1445 AH.
////
//
//import SwiftUI
//
//struct ContentView: View {
//  @State private var isRTL = false
//
//  var body: some View {
//    VStack {
//      Toggle("Right-to-Left", isOn: $isRTL)
//        .padding()
//
//      HStack(alignment: .top) {
//        VStack(alignment: .leading) {
//          Text("مرحبا العالم") // Arabic for "Hello, World"
//          Text("שלום עולם") // Hebrew for "Hello, World"
//        }
//        Spacer()
//        Text("Hello World!")
//      }
//      .frame(maxWidth: .infinity)
//      .padding()
//      .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
//    }
//  }
//}
//
//#Preview {
//    ContentView()
//   
//
//        
//}

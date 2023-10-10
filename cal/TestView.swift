//
//  TestView.swift
//  cal
//
//  Created by Rimah on 30/03/1445 AH.
//

import SwiftUI

struct TestView: View {

    var phase : String
    
    var body: some View {
        HStack{
            Text("MoonPhaseView!")
            Text(phase)
        }
    }
}
#Preview {
    TestView(phase: "Full")
}

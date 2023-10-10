//
//  screen2.swift
//  cal
//
//  Created by Rimah on 25/03/1445 AH.
//

import SwiftUI

struct screen2: View {
    @State var badge1: String = ""
    @State var invest2: String = ""
    
    var calculation: String {
        
        //check if both fields have text else no need for message
        guard badge1.isEmpty == false,
              invest2.isEmpty == false else { return "" }
        
        //check if both are numbers else we need to print "Error"
        guard let badg = Double(badge1), let inv  = Double(invest2) else { return "Error" }
        
        // .2f% this will print two numbers after the dot
        let maths = (badg * inv) / inv / 100
        return String(format: "العائد الاستثماري: %.2f", maths)
        
    }
   
    var body: some View {
            VStack {
                VStack {
                    Text("الحاسبة الاستثمارية")
                        .font(Font.custom("SFProARDisplay-Semibold", size: 18))
                        .padding(/*@START_MENU_TOKEN@*/[.top, .leading], 55.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 500.0, height: 200.0)
                        .environment(\.sizeCategory, .accessibilityLarge)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    
                    Text("حاسبه آليه من خلالها تظهر لك النسبة للعائد المتوقع")
                        .multilineTextAlignment(.trailing)
                        .padding(/*@START_MENU_TOKEN@*/.all, 23.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 420.0, height: 90.0)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                }
                    
                    // this is the fields we desiging for text
                        .padding([.top, .leading], 40.0)
                    Text("نسبة العائد المتوقع:")
                        .font(Font.custom("SFProARDisplay-Semibold", size: 18))
                        .multilineTextAlignment(.trailing)
                        .padding(.leading, 180)
                    TextField("numbers", text: $badge1)
                        .keyboardType(.decimalPad)
                        .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text(" مبلغ الاستثمار:")
                        .font(Font.custom("SFProARDisplay-Semibold", size: 18))
                        .multilineTextAlignment(.trailing)
                        .padding(.leading, 235)
                    TextField("numbers", text: $invest2)
                        .keyboardType(.decimalPad)
                        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
     
                    
                    Text(calculation)
                    Spacer()
                
            }
            
            .frame(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/900.0/*@END_MENU_TOKEN@*/)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.961, green: 0.961, blue: 0.969)/*@END_MENU_TOKEN@*/)
        
    }
    
    }

#Preview {
    screen2()
        
        
}

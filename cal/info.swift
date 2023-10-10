//Created by Riemah and Abrar

import SwiftUI

struct info: View {
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
    NavigationStack{
       
            
        Text("حاسبه آليه من خلالها تظهر لك النسبة للعائد المتوقع")
            .font(.callout)

            .fontWeight(.regular)
            .multilineTextAlignment(.trailing)
            .padding(/*@START_MENU_TOKEN@*/[.top, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
            .frame(height: 20.0)
        
        Form{

            Section{
                
                TextField("ادخل نسبة العائد", text: $badge1)
                    .keyboardType(.decimalPad)
            }//end of section
                    
                    Section{
                
                        TextField("ادخل مبلغ الاستثمار", text: $invest2)
                            .keyboardType(.decimalPad)
                        
                    }//end of section
             
            
                
                Section{
                    Text(calculation)

                    
                }//end of section
            
            
                
            }//end of form
        
        .navigationTitle("الحاسبة الاستثمارية")
      }
   }

 }
#Preview {
    info()
        .environment(\.layoutDirection, .rightToLeft)



}

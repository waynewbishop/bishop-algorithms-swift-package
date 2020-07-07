/*:
 
 # Challenges
 */

import PlaygroundSupport
import Structures
import SwiftUI


struct StackView: View {
    
    var element: String = ""

    
    //default initialization
    init(_ item: String = "") {
        element = item
    }
    
    var body: some View {
        
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Spacer()
            ZStack {
                    RoundedRectangle(cornerRadius: 10)
                       // .stroke(lineWidth: 12)
                        .foregroundColor(.orange)
                        .frame(width: 195.0, height: 100.0)
                    
                    Text(element)
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
            }
            Spacer()
        }
    }
}



PlaygroundPage.current.setLiveView(StackView("8"))



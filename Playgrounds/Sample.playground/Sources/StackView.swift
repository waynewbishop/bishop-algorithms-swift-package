import Foundation
import PlaygroundSupport
import SwiftUI


/*
 note: for this to work the scope the struct as well as all methods must be
 declared public.
 */

public struct StackView: View {
    
    var element: String = ""

    
    //default initialization
   public init(_ item: String = "") {
        element = item
    }
    
   public var body: some View {
        
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Spacer()
            ZStack {
                    RoundedRectangle(cornerRadius: 10)
                       // .stroke(lineWidth: 12)
                        .foregroundColor(.blue)
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

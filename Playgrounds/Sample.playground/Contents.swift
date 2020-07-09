/*:
 
 # Getting Started
 */

import PlaygroundSupport
import Structures
import SwiftUI


//create a new stack
let stack = Stack<Int>()

//push items
stack.push(8)
stack.push(10)
stack.push(2)
stack.push(9)
stack.push(4)


struct StackView: View{
        
   var results = stack.values
    
    var body: some View {
        VStack(alignment: .center) {
                        
            ForEach(results, id: \.id) { result in
                
                ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red)
                            .frame(width: 195.0, height: 65.0)
                    
                        if let tvalue = result.tvalue {
                            Text("\(tvalue)")
                                .foregroundColor(.white)
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.bold)
                        }
                }
                Divider()
                    .frame(width: 350, height:25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}


let stackView = StackView()
PlaygroundPage.current.setLiveView(stackView)


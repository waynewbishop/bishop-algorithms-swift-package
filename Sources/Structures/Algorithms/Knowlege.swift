//
//  Knowledge.swift
//  
//
//  Created by Wayne Bishop on 6/16/21.
//

import Foundation
import NaturalLanguage


public class Knowledge <T: Hashable> {
    
    var canvas = Set<Entity<T>>()

    
    public init() {
        //code goes here..
    }
    
    //add entity to graph canvas
    public func addEntity(_ element: inout Entity<T>) {
        canvas.insert(element)
    }
    
    
    public func newFact(for source: inout Entity<T>, neighbor: inout Entity<T>, token: Token) {
        
        //create a new fact
        let fact = Fact<T>()
                
        //connect source entity with the neighboring fact
        fact.neighbor = neighbor
        fact.token = token
        
        source.neighbors.append(fact)
        
        //add the source as a connection
        neighbor.connections.insert(source)
    }
    
    
    public func mutualFriends(of source: inout Entity<T>) -> [Table<Entity<T>>]? {
                
        let priority = Priority<Entity<T>>()
        var result = [Table<Entity<T>>]() //could the table
        
        //check adjacency list
        for s in source.neighbors {

            //check their connections
            for c in s.neighbor.connections {
                
                if c != source /*&& !source.connections.contains(c)*/ {

                    var isConnected = false
                    
                    //already connected to source?
                    for f in c.neighbors {
                        if f.neighbor == source {
                            isConnected = true
                            break
                        }
                    }
                    
                    if isConnected == false {
                        priority.add(c)
                    }
                }
            }
        }

        
        //obtain vertices with most mutual connections
        guard let items = priority.get() else {
            return nil 
        }
        
             
        var most: Int = 0

        //values are pre-sorted based on priority
        for i in items {
            
            most = max(i.count, most)
            
            if (i.count == most) {
                result.append(i)
                continue
                
            } else {
                break
            }
        }
                
        return result
    }


    
    public func search(term phrase: T) -> () {
        
        /*
         todo: parse keywords in model to determine best
         //matching fact and connection relation..
         //natural language processing??
         */
        
        
        let options = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.joinNames.rawValue
        
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options))

        
        if let inputString = phrase as? String {
            
            tagger.string = inputString
            let range = NSRange(location: 0, length: inputString.utf16.count)
            
            tagger.enumerateTags(in: range, scheme: .nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: options)) { tag, tokenRange, sentenceRange, stop in
                
                guard let range = Range(tokenRange, in: inputString) else {
                    return
                }
                
                let token = inputString[range]
                print("\(tag!.rawValue): \(token)")
                
                //todo: how can this assumed knowledge through tokenization be
                //translated to our knowlege graph?
            }
            
        }//end if
        
    }

    
}
    

//
//  ParkingLot.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class ParkingLot {

    var ticketList = Set<Ticket>()
    var reserveSchedule: Array<Chain<Space>?>

    
    public init() {
        self.reserveSchedule = Array<Chain<Space>?>(repeatElement(nil, count: 24))
    }
    
    
    
    //make a reservation
    public func reserve(start: Date, end: Date) -> Reservation? {
                
        let reserveSlice = Array(reserveSchedule[0...2])
        var spaceNo: Int = 0
        var isFound: Bool = false

        
        //test chains
        for chain in reserveSlice {
            if let items = chain {
                let spaceSchedule = items.values
                
                for s in spaceSchedule {
                    
                    //check conflicts
                    let range = s.reservation.start...s.reservation.end
                    
                    if !range.contains(start) {
                        isFound = true
                        break
                    }
                    
                } //end for
            }
            else {
                print("no schedule items for space \(spaceNo)")
                break
            }
            spaceNo += 1
        }
        
        
        guard isFound == true else {
            return nil
        }
    
        
        let reservedSpace = Space(name: spaceNo)
        
        //create reservation
        let res = Reservation(for: reservedSpace)
        res.start = start
        res.end = end
        
        reservedSpace.reservation = res
        res.space = reservedSpace
        
        
        //check existing chain
        if let echain = reserveSchedule[spaceNo] {
            echain.append(reservedSpace)
        }
        
        else {
            //new series
            let spaceChain = Chain<Space>()
            spaceChain.append(reservedSpace)

            
            //add new chain
            reserveSchedule[spaceNo] = spaceChain
        }        
        
        return res
                                    
    }
    
    
    /*
     public func newTicket(name: String?, reservation: Reservation?) -> Ticket? {
       code goes here..
     }
     */
    
    
    //enter the lot
    public func enter(item: Reservation?) -> Ticket? {
        
        let ticket = Ticket()
        
        /*
         note: the goal of entering the lot is to create a ticket.
         if they have a reservation this is attached to ticket at entry.
         */
                
        guard let reservation = item else {
            print("don't have a reservation..")
            
            //todo: check for capacity in non-reserved spots
            
            return nil
        }
        
        
        //confirm the reservation
        for chain in reserveSchedule {
            if let space = chain {
                if let reserveSpace = reservation.space {
                    
                    //new ticket
                    if space.contains(reserveSpace) {
                        ticket.timeIn = Date()
                        ticket.reservation = reservation
                        ticket.space = reserveSpace
                        
                        ticketList.insert(ticket)
                        
                        return ticket
                    }
                    else {
                        print("no valid reservation")
                        return nil
                    }
                }
            }
        }
                
        
        return nil
    }
    

    
    
    //exit the lot
    public func exit(ticket: Ticket) {
        //return nil
        
        /*
         todo: determine if the customer should be charged and
         by how much. If they have a reservation and it's timeout
         is less than the current time no charge is made.
         
         Otherwise, charge the user based on the difference between
         timein and timout.
         */
        
    }
    
}

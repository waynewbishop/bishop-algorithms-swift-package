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
    let reserved: Int = 6

    
    public init() {
        self.reserveSchedule = Array<Chain<Space>?>(repeatElement(nil, count: reserved))
    }
    
    
    
    //make a reservation
    public func reserve(from start: Date, to end: Date) -> Reservation? {
        
        let desiredRange = start...end
                
        let reserveSlice = ArraySlice(reserveSchedule[0...reserved])
        var spaceNo: Int = 0
        var isFound: Bool = false

        
        //test chains
        for chain in reserveSlice {
            if let items = chain {
                let spaceSchedule = items.values
                
                for s in spaceSchedule {
                    
                    //check conflicts
                    let range = s.reservation.start...s.reservation.end  //todo: call this from the range of the reservation..
                                        
                    if !range.overlaps(desiredRange) {
                        isFound = true
                        break
                    }
                    
                } //end for
            }
            else {
                print("no reservations for space \(spaceNo)")
                isFound = true
                break
            }
            spaceNo += 1
        }
        
        
        guard isFound == true else {
            return nil
        }
    
        
        let reservedSpace = Space(with: spaceNo)
        
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
    
    
    
    //enter the lot
    public func enter(_  res: Reservation? = nil) -> Ticket? {
        
        let ticket = Ticket()
        
        /*
         note: the goal of entering the lot is to create a ticket.
         if they have a reservation this is attached to ticket at entry.
         */
                
        guard let reservation = res else {
            
            let openSchedule = ArraySlice(reserveSchedule[reserved...])
            
            if let chain = openSchedule.firstIndex(where: { $0 == nil }) {
                let spaceNo = chain + reserved
                
                print("available open space: \(spaceNo)")

                
                //new chain
                let openChain = Chain<Space>()
                openChain.append(Space(with: spaceNo))

                
                //update schedule
                reserveSchedule[spaceNo] = openChain

                
                //new ticket..
                ticket.timeIn = Date()
                ticket.space = Space(with: spaceNo)
                
                self.ticketList.insert(ticket)
                
                
                return ticket
                
            }
                        
            return nil
        }
        
        
        //confirm reservation - check chained schedule based on assigned space - O(s + h)
        
        if let rSpace = reservation.space {
            let chain = reserveSchedule[rSpace.name]
            
            if let items = chain {
                let spaceSchedule = items.values
                
                for event in spaceSchedule {
                    if event.reservation == reservation {
                        
                        //new ticket
                        ticket.timeIn = Date()
                        ticket.reservation = reservation
                        ticket.space = rSpace
                        
                        self.ticketList.insert(ticket)
                        
                        return ticket
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

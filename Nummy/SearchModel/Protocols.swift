//
//  Protocols.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/16/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import Foundation


//Design Protocol 
protocol PassDataDelegate {
    func passSearchedQuery(query: String)
}

protocol CanReceive {
    func dataReceived(query: String)
}

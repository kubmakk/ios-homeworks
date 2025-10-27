//
//  Storable.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 08.11.2022.
//

import Foundation
//import RealmSwift
import CoreData

protocol Storable {}

//extension Object: Storable {}
extension NSManagedObject: Storable {}

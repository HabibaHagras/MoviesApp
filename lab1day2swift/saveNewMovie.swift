//
//  saveNewMovie.swift
//  lab1day2swift
//
//  Created by habiba on 4/25/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
protocol saveNewMovie {
    func save(name :String,
      img :Data,
      rating:Float,
      genre:[String],
      relaseint:Int
    )
    
//    func open_Galary(img:Data)
    
}

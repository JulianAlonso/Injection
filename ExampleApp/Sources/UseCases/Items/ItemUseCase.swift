//
//  ItemUseCase.swift
//  App
//
//  Created by Juli Alonso on 20/03/2020.
//

import Foundation

class ItemUseCase {
    let service: ItemService
    
    init(service: ItemService) {
        self.service = service
    }
}

//
//  NoteModel.swift
//  NotesApp
//
//  Created by Arthur Lee on 22.03.2022.
//

import Foundation

struct NoteModel {
    let title: String
    let isMarked: Bool
    
    
    init(title: String, isMarked: Bool = false) {
        self.isMarked = isMarked
        self.title = title
        
    }
    
    func markedToggle() -> NoteModel {
        return NoteModel(title: title, isMarked: !isMarked)
    }
}

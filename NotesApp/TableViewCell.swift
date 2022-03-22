//
//  TableViewCell.swift
//  NotesApp
//
//  Created by Arthur Lee on 22.03.2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func checkCell(_ cell: TableViewCell, didChangeCheckedState checked: Bool)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet var checkbox: CheckView!
    @IBOutlet var label: UILabel!
    
    var delegate: TableViewCellDelegate?
    
    
    @IBAction func checked(_ sender: CheckView) {
        updateChecked()
        delegate?.checkCell(self, didChangeCheckedState: checkbox.checked)
    }
    
    func setNote(title: String, checked: Bool) {
        label.text = title
        checkbox.checked = checked
        updateChecked()
    }
    
    private func updateChecked() {
        let attributedString = NSMutableAttributedString(string: label.text!)
        
        if checkbox.checked {
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length - 1))
        } else {
            attributedString.removeAttribute((.strikethroughStyle), range: NSMakeRange(0, attributedString.length - 1))
        }
        label.attributedText = attributedString
    }
   
}

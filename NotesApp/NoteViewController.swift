//
//  ViewController.swift
//  NotesApp
//
//  Created by Arthur Lee on 22.03.2022.
//

import UIKit

protocol NoteViewControllerDelegate: AnyObject {
    func makeNoteViewController(_ vc: NoteViewController, didSaveNote note: NoteModel)
}


class NoteViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    var note: NoteModel?
    var delegate: NoteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = note?.title
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButton(_ sender: Any) {
        let note = NoteModel(title: textField.text!)
        delegate?.makeNoteViewController(self, didSaveNote: note)
    }
    
}

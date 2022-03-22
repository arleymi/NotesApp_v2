//
//  TableTableViewController.swift
//  NotesApp
//
//  Created by Arthur Lee on 22.03.2022.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    
    var notes = [
    NoteModel(title: "first"),
    NoteModel(title: "Sec"),
    NoteModel(title: "Third")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        
        let noteName = notes[indexPath.row]
        
        cell.setNote(title: noteName.title, checked: noteName.isMarked)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Mark note") { action, view, complete in
            
            let note = self.notes[indexPath.row].markedToggle()
            self.notes[indexPath.row] = note
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            cell.setNote(title: note.title, checked: note.isMarked)
            
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = notes.remove(at: sourceIndexPath.row)
        notes.insert(note, at: destinationIndexPath.row)
    }
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = true
    }
    @IBSegueAction func noteViewController(_ coder: NSCoder) -> NoteViewController? {
        let vc = NoteViewController(coder: coder)
        if let indexPath = tableView.indexPathForSelectedRow {
            let note = notes[indexPath.row]
            vc?.note = note
        }
        
        vc?.delegate = self
        
        return vc
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableTableViewController: TableViewCellDelegate {
    func checkCell(_ cell: TableViewCell, didChangeCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let note = notes[indexPath.row]
        let newNote = NoteModel(title: note.title, isMarked: checked)
        
        notes[indexPath.row] = newNote
    }
}

extension TableTableViewController: NoteViewControllerDelegate {
    func makeNoteViewController(_ vc: NoteViewController, didSaveNote note: NoteModel) {
        if let indexPath = tableView.indexPathForSelectedRow {
            // update
            notes[indexPath.row] = note
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            //create
            notes.append(note)
            tableView.insertRows(at: [IndexPath(row: notes.count - 1, section: 0)], with: .automatic)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

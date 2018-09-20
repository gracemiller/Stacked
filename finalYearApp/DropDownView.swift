import UIKit

protocol DropDownProtocol {
    func dropDownPressed(exercise : Exercise)
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var addExercise = NSObject()
    
    var tableView = UITableView()
    
    var delegate: DropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.orange
        self.backgroundColor = UIColor.orange
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExerciseManager.shared.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let exercise = ExerciseManager.shared.exercises[indexPath.row]
        
        cell.textLabel?.text = exercise.name
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = ExerciseManager.shared.exercises[indexPath.row]
        self.delegate.dropDownPressed(exercise: exercise)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


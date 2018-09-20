import Foundation

class ExerciseManager {
    
    static let shared = ExerciseManager()
    
    var exercises = [Exercise]()
    
    private init() { }
    
    func configure() {
        exercises.append(Exercise(name: "Back Squat", sceneName: "art.scnassets/BackSquatFixed", identifier: "BackSquatFixed-1"))
        exercises.append(Exercise(name: "Snatch", sceneName: "art.scnassets/SnatchFixed", identifier: "SnatchFixed-1"))
        exercises.append(Exercise(name: "Overhead Squat", sceneName: "art.scnassets/OverheadSquatFixed", identifier: "OverheadSquatFixed-1"))
        exercises.append(Exercise(name: "Clean and Jerk", sceneName: "art.scnassets/CleanFixed", identifier: "CleanFixed-1"))
    }
    
}

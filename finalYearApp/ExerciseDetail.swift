//import Foundation
//import Firebase
//
//class NewExerciseDetail {
//
//    let image: UIImage
//    let exercise: String
//    let weights: Int
//    let reps: Int
//    let sets: Int
//
//
//    init(snapshot: DataSnapshot) {
//        let data = snapshot.value as! [String: Any]
//        image = data[#imageLiteral(resourceName: "backsquat")] as! UIImage
//        exercise = data["Exercise"] as! String
//        weights = data["Weights"] as! Int
//        reps = data["Reps"] as! Int
//        sets = data["Sets"] as! Int
//    }
//
//}
//

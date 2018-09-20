import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class Post: NSObject {
    
    var postID: String!
    
    var weights: Int!
    var sets: Int!
    var reps: Int!
    var date: Date!
    var videoURL: String?
    var imageURL: String?
    
    var exercise: Exercise!
    
    init(snapshot: DataSnapshot) {
        let dict = snapshot.value as! [String: Any]
        postID = snapshot.key
            
        exercise = Exercise(snapshot: snapshot.childSnapshot(forPath: "exercise"))
        reps = dict["reps"] as! Int
        sets = dict["sets"] as! Int
        weights = dict["weights"] as! Int
        date = Date(timeIntervalSince1970: dict["date"] as! TimeInterval)
        
        if let videoURL = dict["video"] as? String {
            self.videoURL = videoURL
        }
        
    }

    func toDict() -> [String: Any] {
        let dict = [
            "exercise": exercise,
            "weights": weights,
            "reps": reps,
            "sets": sets,
            "date": date,
            "video": videoURL
            ] as [String : Any]
        return dict
    }
    
}


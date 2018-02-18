import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class Post: NSObject {
    
    var exercise: String?
    var weights: String?
    var sets: String?
    var reps: String?
    var imageDownlaodURL: String?
    private var image: UIImage!
    
    init(image: UIImage)
         //exercise: String, weights: String, sets: String, reps: String)
        {
        self.image = image
       // self.exercise = exercise
 
    }
    
    func save() {
        //new datatbase ref
        let newPostRef = Database.database().reference().child("photoPost").childByAutoId()
        let newPostKey = newPostRef.key
        
        if let imageData = UIImageJPEGRepresentation(self.image, 0.6){
            
            //creates storage ref
            let imageStorageReference = Storage.storage().reference().child("images")
            let newImageRef = imageStorageReference.child(newPostKey)
            
            //save image to storage
            newImageRef.putData(imageData).observe(.success, handler:{ (snapshot) in
               
                //save post and download url
                self.imageDownlaodURL = snapshot.metadata?.downloadURL()?.absoluteString
                let newPostDictionary = [
                    "imageDictionaryURL" : self.imageDownlaodURL,
                    //"exercise" : self.exercise
                
                ]
                
                newPostRef.setValue(newPostDictionary)
                
            })
            
        }  
        
    }
    
}

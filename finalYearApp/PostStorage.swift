import UIKit
import Foundation
import FirebaseStorage
import FirebaseDatabase

class Post {
    
    var caption: String!
    var imageDownloadURL: String!
    private var image: UIImage!
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
    func save() {
    //Database ref:
        let newPostRef = Database.database().reference().child("photoPost").childByAutoId()
        let newPostKey = newPostRef.key
        if let imageData = UIImageJPEGRepresentation(self.image, 0.6) {
            //Storage Ref:
            let imageStorageRef = Storage.storage().reference().child("image")
            let newImageRef = imageStorageRef.child(newPostKey)
        
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
                self.imageDownloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                
                let newPostDictionary = ["imageDownloadURL" : self.imageDownloadURL, "caption" : self.caption ]
                
                newPostRef.setValue(newPostDictionary)
            })
    }
    
}
    
}

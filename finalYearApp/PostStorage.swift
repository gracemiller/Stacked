//import UIKit
//import Foundation
//import FirebaseStorage
//import FirebaseDatabase
//
//class Post: UIViewController {
//
//    override func viewDidLoad() {
//        
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        
//        self.ref.child("users").child(user.uid).setValue(["username": username])
//        self.ref.child("users/\(user.uid)/username").setValue(username)
//        
//        refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            // ...
//        })
//
//
//        let userID = Auth.auth().currentUser?.uid
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
//        let key = ref.child("posts").childByAutoId().key
//        let post = ["uid": userID,
//                    "author": username,
//                    "title": title,
//                    "body": body]
//        let childUpdates = ["/posts/\(key)": post,
//                            "/user-posts/\(userID)/\(key)/": post]
//        ref.updateChildValues(childUpdates)
//}
//
//
////
////     @IBOutlet weak var photoImageView: UIImageView!
////
////    var userID: String = ""
////    private var photosCollection = [PhotoCollection]()
////
////    var ref: DatabaseReference!
////    override func viewDidAppear(_ animated: Bool) {
////        userID = (Auth.auth().currentUser?.uid)!
////        ref = Database.database().reference()
////        GetAllUserPhotos()
////    }
////
////
////        override func viewDidLoad() {
////            super.viewDidLoad()
////            ref = Database.database().reference()
////            storage = Storage.storage().reference()
////        }
////
////    func UploadImageToFirebaseStorage(data : Data){
////
////        let photoId = UUID().uuidString
////
////        let storageRef = Storage.storage().reference(withPath: String("\(photoId).jpg"))
////        let uploadMetaData = StorageMetadata()
////        uploadMetaData.contentType = "image/jpeg"
////        storageRef.putData(data, metadata: uploadMetaData){(metadata, error) in
////            if(error != nil){
////                print(error?.localizedDescription ?? "error")
////            }else{
////                print("success")
////                let photoUrl =  metadata?.downloadURL()?.absoluteString
////                let userPhotoRef = self.ref.child("Photos").child(self.userID).childByAutoId()
////                userPhotoRef.setValue(photoUrl)
////                self.GetAllUserPhotos()
////            }
////        }
////    }
////    func GetAllUserPhotos(){
////        let userPhotosRef = self.ref.child("Photos").child(self.userID)
////        userPhotosRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
////            if let photoURLCollection = snapshot.value as? NSDictionary{
////                self.photosCollection.removeAll()
////                for photo in photoURLCollection {
////                    let newPhoto = PhotoCollection()
////                    newPhoto.photoKey = photo.key as! String
////                    newPhoto.photoUrl = (photo.value as? String)!
////                    self.photosCollection.append(newPhoto)
////                }
////                self.collectionView?.reloadData()
////            }
////        }
////    }
////
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        dismiss(animated: true, completion: nil)
////        return
////    }
////
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
////
////        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage,
////            let imageData = UIImageJPEGRepresentation(originalImage, 0.8){
////            UploadImageToFirebaseStorage(data: imageData)
////        }
////        dismiss(animated: true, completion: nil)
////    }
////}
////
////
////
////    func presentCameraViewController() {
////
////        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////        let CameraViewController: CameraViewController = storyboard.instantiateViewController(withIdentifier: "CameraVC") as! CameraViewController
////
////        self.present(CameraViewController, animated: true, completion: nil)
////
////
////    }
////


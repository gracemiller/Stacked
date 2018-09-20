import Foundation
import SceneKit
import ARKit
import Firebase

class Exercise {
    
    var name: String!
    var sceneName: String!
    var identifier: String!
    var animation: CAAnimation!
    var image: UIImage?

    init(name: String, sceneName: String, identifier: String) {
        self.name = name
        self.sceneName = sceneName
        self.identifier = identifier
        setup()
        
        loadAnimation(withKey: name, sceneName: sceneName, animationIdentifier: identifier)
    }
    
    private func setup() {
        image = UIImage(named: name)
    }
    
    
    init(snapshot: DataSnapshot) {
        let dict = snapshot.value as! [String: Any]
        
        name = dict["name"] as! String
        identifier = dict["identifier"] as! String
        sceneName = dict["sceneName"] as! String
        setup()
    }
    
    
    func toDict() -> [String: Any] {
        let dict = [
            "name": name,
            "sceneName": sceneName,
            "identifier": identifier
            ] as [String : Any]
        return dict
    }
    
    private func loadAnimation(withKey: String, sceneName:String, animationIdentifier: String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
        
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            // The animation will only play once
            animationObject.repeatCount = 1
            
            // Store the animation for later use
            animation = animationObject
        }
    }
  
}



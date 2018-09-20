import UIKit
import SceneKit
import ARKit

class ARDemoViewController: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    var idle = true
    
    var currentAngleY: Float = 0.0
    var isRotating = false
    
    let backSquatNode = SCNNode()
    let overheadSquatNode = SCNNode()
    let snatchNode = SCNNode()
    var node = SCNNode()
    
    var exercise: Exercise?
    
    var button = dropDownBtn()
    var cellButtonTapped: ((UITableViewCell) -> Void)?
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.eulerAngles.z = Float.pi / 2
        
        sceneView.isUserInteractionEnabled = true
        sceneView.isMultipleTouchEnabled = true
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveNode(_:)))
//        self.view.addGestureRecognizer(panGesture)
        
        //BUTTON
        button = dropDownBtn(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Add Demo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.dropView.delegate = self
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        sceneView.delegate = self
        sceneView.showsStatistics = true

        let scene = SCNScene()
        
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        
        loadAnimations()
    }
    
//    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    @objc func moveNode(_ gesture: UIPanGestureRecognizer) {
//
//        if !isRotating{
//            let currentTouchPoint = gesture.location(in: self.sceneView)
//            guard let hitTest = self.sceneView.hitTest(currentTouchPoint, types: .existingPlane).first else { return }
//            let worldTransform = hitTest.worldTransform
//            let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
//
//            node.simdPosition = float3(newPosition.x, newPosition.y, newPosition.z)
//
//        }
//    }
    
    func loadAnimations () {
        let idleScene = SCNScene(named: "art.scnassets/idleFixed.dae")!
            for child in idleScene.rootNode.childNodes {
            node.addChildNode(child)
        }
        

        node.position = SCNVector3(0, -1, -2)
        node.scale = SCNVector3(0.008, 0.008, 0.008)
        node.eulerAngles = SCNVector3(0, 3, 0)
        
        sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: sceneView)
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        
        let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
        
        if hitResults.first != nil {
            if(idle) {
                playAnimation(key: exercise!.name)
            } else {
                stopAnimation(key: exercise!.name)
            }
            idle = !idle
            return
        }
    }
    
    func playAnimation(key: String) {
        guard let exercise = exercise else { return }
        sceneView.scene.rootNode.addAnimation(exercise.animation, forKey: exercise.name)
    }
    
    func stopAnimation(key: String) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func ResetScene(_ sender: Any) {
        resetSession()
    }
    
    func resetSession() {
        sceneView.session.pause()
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configuration.planeDetection = [.horizontal, .vertical]
        } else {
            // Fallback on earlier versions
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        node.position = SCNVector3(0, -1, -2)
        node.scale = SCNVector3(0.008, 0.008, 0.008)
        node.eulerAngles = SCNVector3(0, 3, 0)
    }

}

extension ARDemoViewController: DropDownProtocol {
    func dropDownPressed(exercise: Exercise) {
        self.exercise = exercise
    }
}

extension Int{
    var degreesToRadians: Double{return Double(self) * .pi / 180}
}




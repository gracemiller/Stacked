import Foundation
import UIKit
import SceneKit
import ARKit

class ARDemoViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var searchDemo: UISearchBar!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var nodeModel:SCNNode!
    let nodeName = "robot"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.antialiasingMode = .multisampling4X
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        addTapGestureToSceneView()
        addBackSquat(x: 100, y: -100.0, z: 0)
        
    }
    
    func addBackSquat(x: Float, y: Float, z: Float) {
        let modelScene = SCNScene(named:"Models.scnassets/backSquat.scn")!
        let modelNode = modelScene.rootNode.childNode(withName: "backSquat", recursively: true)
        //modelNode?.scale = SCNVector3(0.5, 0.5, 0.5)
        //modelNode?.position = SCNVector3Make(x, y, z)
        
        sceneView.scene.rootNode.addChildNode(modelNode!)
        
        
        nodeModel =  modelScene.rootNode.childNode(
            withName: nodeName, recursively: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else { return }
        let hitTransform = hitResult.worldTransform
        //let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        //createDemo(position: hitVector)
        
//        let location = touches.first!.location(in: sceneView)
//        var hitTestOptions = [SCNHitTestOption: Any]()
//        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
//        let hitResults: [SCNHitTestResult]  =
//            sceneView.hitTest(location, options: hitTestOptions)
//        
//        
//        if let hit = hitResults.first {
//            if let node = getParent(hit.node) {
//                node.removeFromParentNode()
//                return
//            }
//        }
        
    }
    
//    func createDemo(position: SCNVector3) {
//        var
//
//
//    }
    
    func getParent(_ nodeFound: SCNNode?) -> SCNNode? {
        if let node = nodeFound {
            if node.name == nodeName {
                return node
            } else if let parent = node.parent {
                return getParent(parent)
            }
        }
        return nil
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
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARDemoViewController.didTap))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addBackSquat(x: translation.x, y: translation.y, z: translation.z)
                
            }
            return }
        node.removeFromParentNode()
    }
    
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}



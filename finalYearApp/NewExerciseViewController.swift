import UIKit
import Firebase
import AVKit

class NewExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let ref = Database.database().reference().child("Posts/\(Auth.auth().currentUser!.uid)")
    
    var asset: AVURLAsset?
    var pickerView = UIPickerView()
    
    var selectedExercise: Exercise?
        
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var percentage: UILabel!
    @IBOutlet var percentageLabel: UILabel!
    
    @IBOutlet var exerciseTextField: UITextField!
    @IBOutlet var weightsTextField: UITextField!
    @IBOutlet var setsTextField: UITextField!
    @IBOutlet var repsTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        exerciseTextField.inputView = pickerView
        exerciseTextField.textAlignment = .left
        exerciseTextField.placeholder = "Select Exercise"
        
        if navigationController != nil {
            closeButton.isHidden = true
        }
        
        progressBar.isHidden = true
        percentageLabel.isHidden = true
        percentage.isHidden = true
            
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.performSegue(withIdentifier: "close", sender: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExerciseManager.shared.exercises.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ExerciseManager.shared.exercises[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedExercise = ExerciseManager.shared.exercises[row]
        exerciseTextField.text = selectedExercise?.name
        exerciseTextField.resignFirstResponder()
    }
        
    func uploadVideo(asset: AVURLAsset, completion: @escaping (StorageMetadata?) -> ()) {
        
        let videoRef = String(UUID().uuidString)
        let ref = Storage.storage().reference(withPath: "\(videoRef).mov")
        let meta = StorageMetadata()
        meta.contentType = "video/mov"
        
        let uploadTask = ref.putFile(from: asset.url, metadata: meta) { meta, error in
            completion(meta)
        }
        
        uploadTask.observe(.progress) { snapshot in
            self.progressBar.progress = Float(snapshot.progress!.fractionCompleted)
            let progressPercent = Int(snapshot.progress!.fractionCompleted*100)
            self.percentage.text = "\(progressPercent)"
        }
        
    }
    
    
    func save(_ data: [String: Any]) {
        self.ref.childByAutoId().setValue(data, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "profile", sender: nil)
            }
        })
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        if navigationController != nil {
            progressBar.isHidden = true
            percentageLabel.isHidden = true
            percentage.isHidden = true
        } else {
            progressBar.isHidden = false
            percentageLabel.isHidden = false
            percentage.isHidden = false
        }

        guard let weightsString = self.weightsTextField.text, let repsString = self.repsTextField.text, let setsString = self.setsTextField.text, let exercise = self.selectedExercise  else {
            return
        }
        
        guard let weight = Int(weightsString), let reps = Int(repsString), let sets = Int(setsString) else { return }

        let date = Date()
        
        var dict = [
            "weights": weight,
            "reps": reps,
            "sets": sets,
            "exercise": exercise.toDict(),
            "date": date.timeIntervalSince1970
            ] as [String : Any]
        
        if let asset = asset {
            uploadVideo(asset: asset) { meta in
                guard let meta = meta else { return }
                dict["video"] = meta.name!
                self.save(dict)
            }
        } else {
            save(dict)
        }
        

    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "close" {
            _ = segue.destination as! VideoRecorderViewController
        } else {
            if segue.identifier == "profile" {
                _ = segue.destination as! LoggedInViewController
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        weightsTextField.resignFirstResponder()
        setsTextField.resignFirstResponder()
        repsTextField.resignFirstResponder()
    }
}
    



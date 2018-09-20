import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import AVKit
import AVFoundation

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    let ref = Database.database().reference().child("Posts/\(Auth.auth().currentUser!.uid)")
    var posts = [Post]()
    var databaseHandle: DatabaseHandle!
    
    var delete: IndexPath? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    var filteredPosts =  [Post]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.filteredPosts = posts
                
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
        
        databaseHandle = ref.observe(.value, with: { snapshot in
            self.posts.removeAll()
            for data in snapshot.children {
                let dataSnapshot = data as! DataSnapshot
                let post = Post(snapshot: dataSnapshot)
                self.posts.append(post)
            }
            
            
            self.posts.sort { $0.date > $1.date }
            self.tableView.reloadData()

            
        })

        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 123.0
        

    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            
            let location = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) {
                
                let customCell = tableView.cellForRow(at: indexPath) as! CustomCell
                guard let post = customCell.post else { return }
                
                cell.clipsToBounds = false

                let alert = UIAlertController(title: "Delete Post", message: "Are you sure you want to permanently delete this post?", preferredStyle: .actionSheet)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.ref.child(post.postID).removeValue()
                    self.posts.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in }
                
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
            
                self.present(alert, animated: true, completion: nil)

            }
        }
    }
    
    func setupNavBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController

        } else {
            let searchBar = searchController.searchBar
            searchBar.barTintColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            tableView.tableHeaderView = searchBar
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        if isFiltering() {
            return filteredPosts.count
        }
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.post = self.posts[indexPath.row]
        
        let post: Post
        if isFiltering() {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }
        
        
        cell.setsLabel.text = "\(post.sets!)"
        cell.repsLabel.text = "\(post.reps!)"
        cell.weightsLabel.text = "\(post.weights!)"
        cell.screenShotImage.image = post.exercise.image
        cell.selectionStyle = .none
        cell.dateLabel.text = dateLabel(date: post.date)
        
        let image = #imageLiteral(resourceName: "newPB")
        cell.newPB.image = image
        
        var SnatchWeights = [Int]()
        var BackSquatWeights = [Int]()
        var CleanWeights = [Int]()
        var OverHeadWeights = [Int]()
        
        for ex in posts {
            switch ex.exercise.name! {
            case "Back Squat":
                BackSquatWeights.append(ex.weights)
            case "Snatch":
                SnatchWeights.append(ex.weights)
            case "Overhead Squat":
                OverHeadWeights.append(ex.weights)
            case "Clean and Jerk":
                CleanWeights.append(ex.weights)
            default: break
            }
        }
        
        var pb: Int = 0
        
        switch post.exercise.name! {
        case "Back Squat":
            pb = BackSquatWeights.max()!
        case "Snatch":
            pb = SnatchWeights.max()!
        case "Overhead Squat":
            pb = OverHeadWeights.max()!
        case "Clean and Jerk":
            pb = CleanWeights.max()!
        default: break
        }
        
        if post.weights != pb {
            cell.newPB.isHidden = true
        }

        return cell
    
    }
    
    func dateLabel(date: Date) -> String {
        let result = timeAgoSince(date)
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        guard let videoURL = post.videoURL  else {
            
            let alert = UIAlertController(title: "Alert", message: "No Video Found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)

            return
        }
        
        let ref = Storage.storage().reference(withPath: videoURL)
        ref.downloadURL { url, error in
            let url = url
            let player = AVPlayer(url: url!)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
            vc.player = player
            self.present(vc, animated: true, completion: nil)

        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVCSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.post = sender as! Post
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredPosts = posts
        } else {
            // Filter the results
            filteredPosts = posts.filter { $0.exercise.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }

        self.tableView.reloadData()
    }
    

    @IBAction func addPost(_ sender: Any) {
        ref.child("Posts").childByAutoId().setValue("Please work for me Firebase")
    }
    
    func add(_ Post: Dictionary<String, Any>) {
        let index = 0
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
    
    do {
        try Auth.auth().signOut()
            }   catch {
            print("There was a problem logging out")
            }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc!, animated: true, completion: nil)
    }


}



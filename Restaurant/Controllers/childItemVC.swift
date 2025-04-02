
import UIKit
 
class childItemVC: UIViewController {

    @IBOutlet weak var tblChildItemList: UITableView!
    
    var resModel = [ChildItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tblChildItemList.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tblChildItemList.reloadData()
    }
    
    @IBAction func onclickBack(_ sender : Any){
        self.dismiss(animated: true)
    }
    
}

extension childItemVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let dict = resModel[indexPath.row]
        cell.lbl.text = "\(dict.name ?? "")"
        cell.setupChildItem(obj: dict)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


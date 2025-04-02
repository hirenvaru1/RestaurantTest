
import UIKit

class ItemListCell:UITableViewCell{
    @IBOutlet weak var lbl: UILabel!
    
}

class ItemListVC: UIViewController {

    @IBOutlet weak var tblMenuItemList: UITableView!
    
    var resModel = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMenuItemList.reloadData()
    }
    
    @IBAction func onclickBack(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ItemListVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath) as! ItemListCell
        let dict = resModel[indexPath.row]
        cell.lbl.text = "\(dict.mainItemName ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "childItemVC") as! childItemVC
        vc.resModel = resModel[indexPath.row].childItems ?? []
        navigationController?.present(vc, animated: true)
    }
    
}



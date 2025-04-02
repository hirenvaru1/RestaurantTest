
import UIKit

class MenuListCellTbl:UITableViewCell{
    @IBOutlet weak var lbl: UILabel!
    
}

class MenuDisplayVC: UIViewController {

    @IBOutlet weak var tblMenuList: UITableView!
    
    var resModel = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let idx = resModel.firstIndex(where: { $0.menuStatus == false }) {
            resModel.remove(at: idx)
        }
        tblMenuList.reloadData()
    }
    
    @IBAction func onclickBack(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MenuDisplayVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListCellTbl", for: indexPath) as! MenuListCellTbl
        let dict = resModel[indexPath.row]
        cell.lbl.text = dict.menuName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemListVC") as! ItemListVC
        vc.resModel = resModel[indexPath.row].menuItems ?? []
        navigationController?.pushViewController(vc, animated: true)

    }
    
}



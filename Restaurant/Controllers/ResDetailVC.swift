
import UIKit

class cellTbl:UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblLatLong: UILabel!
}

class ResDetailVC: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    
    var resModel = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI(model: Welcome.self, url: WebURL.mainURL, method: APIType.get, parameter: [:], isHudShow: true) { data in
            self.resModel = data.restaurants ?? []
            self.tblList.reloadData()
        }
    }
    
    func loadJson(filename fileName: String) -> [Restaurant]! {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Welcome.self, from: data)
                return jsonData.restaurants
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension ResDetailVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTbl", for: indexPath) as! cellTbl
        let dict = resModel[indexPath.row]
        cell.lblName.text = dict.name
        cell.lblCity.text = dict.location
        cell.lblLatLong.text = "\(dict.lat ?? 0.0), \(dict.long ?? 0.0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuDisplayVC") as! MenuDisplayVC
        vc.resModel = resModel[indexPath.row].menus ?? []
        navigationController?.pushViewController(vc, animated: true)
    }
}

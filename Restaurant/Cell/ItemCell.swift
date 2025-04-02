
import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var vwOfExtraIngredients: UIView!
    @IBOutlet weak var tblExtraIngredients: UITableView!
    @IBOutlet weak var childItemHeight: NSLayoutConstraint!
   
 
    var dataOfItem = ChildItem()
    var selectedSingleIndex: IndexPath?
   
    var selectedMultiIndex: Set<IndexPath> = []

    override func awakeFromNib() {
        super.awakeFromNib()
        tblExtraIngredients.register(UINib(nibName: "extraIngredientsCell", bundle: nil), forCellReuseIdentifier: "extraIngredientsCell")
    }
    
    func setupChildItem(obj: ChildItem){
        dataOfItem = obj
        vwOfExtraIngredients.isHidden = dataOfItem.extraIngredients?.count == 0 ? true : false
        childItemHeight.constant = CGFloat((dataOfItem.extraIngredients?.count ?? 0) * 45)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ItemCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOfItem.extraIngredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "extraIngredientsCell", for: indexPath) as! extraIngredientsCell
        cell.name.setTitle(" \(dataOfItem.extraIngredients?[indexPath.row] ?? "")", for: .normal)
        
        var imageName = ""
        if dataOfItem.selectionType == .single{
            imageName = selectedSingleIndex == indexPath ? "circle_fill" : "circle_unfill"
        }
        else {
            if selectedMultiIndex.contains(indexPath) {
                imageName = "box_fill"
            } else {
                imageName = "box_unfill"
            }
        }
        cell.name.setImage(UIImage(named: imageName), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataOfItem.selectionType == .single{
            selectedSingleIndex = indexPath
        }
        else {
            if selectedMultiIndex.contains(indexPath) {
                selectedMultiIndex.remove(indexPath)
            } else {
                selectedMultiIndex.insert(indexPath)
            }
         }
        tableView.reloadData()
    }
}


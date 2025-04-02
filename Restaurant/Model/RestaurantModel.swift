
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    var restaurants: [Restaurant]?
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id: Int?
    var name, location: String?
    var lat, long: Double?
    var menus: [Menu]?
}

// MARK: - Menu
struct Menu: Codable {
    var id: Int?
    var menuName: String?
    var menuStatus: Bool?
    var menuItems: [MenuItem]?
}

// MARK: - MenuItem
struct MenuItem: Codable {
    var id: Int?
    var mainItemName: String?
    var childItems: [ChildItem]?
}

// MARK: - ChildItem
struct ChildItem: Codable {
    var id: Int?
    var name: String?
    var extraIngredients: [String]?
    var selectionType: SelectionType?
    var defaultSelection: Bool?
}

enum SelectionType: String, Codable {
    case multi = "multi"
    case single = "single"
}

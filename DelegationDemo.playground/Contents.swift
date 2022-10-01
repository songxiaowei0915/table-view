import Foundation

protocol ListTableDataSource: AnyObject {
    func numberOfRows(listTable: ListTable) -> Int
    func cellForRowAtIndex(listTable: ListTable, index: Int) ->ListCell
}

protocol ListTableDelegate: AnyObject {
    func disSelectRowAtIndex(listTable: ListTable, index: Int)
}

class ListTable {
    weak var dataSource: ListTableDataSource?
    weak var delegate: ListTableDelegate?
    
    func triggerCellSelection(_ index: Int) {
        if self.delegate != nil {
            self.delegate!.disSelectRowAtIndex(listTable: self, index: index)
        }
    }
    
    func draw() {
        if self.dataSource != nil {
            for index in 1...self.dataSource!.numberOfRows(listTable: self) {
                let listCell = self.dataSource!.cellForRowAtIndex(listTable: self, index: index)
                listCell.draw()
            }
        }
    }
}

class ListCell {
    func draw() {
        print("a list cell")
    }
}

class CustomListCell: ListCell {
    override func draw() {
        print("a custom list cell")
    }
}

class ListTableController : ListTableDataSource, ListTableDelegate {
    func disSelectRowAtIndex(listTable: ListTable, index: Int) {
        let cell = self.cellForRowAtIndex(listTable: listTable, index: index)
        print("\(cell) \(index) is selected")
    }
    
    func numberOfRows(listTable: ListTable) -> Int {
        return 10
    }
    
    func cellForRowAtIndex(listTable: ListTable, index: Int) -> ListCell {
        if index % 2 == 0 {
            return CustomListCell()
        }
        else {
            return ListCell()
        }
    }
    
    var listTable: ListTable!
    
    init() {
        self.listTable = ListTable()
    }
    
    func listWillDispaly() {
        self.listTable.dataSource = self
        self.listTable.delegate = self
    }
}

var listTableController = ListTableController()
listTableController.listWillDispaly()
listTableController.listTable.draw()
listTableController.listTable.triggerCellSelection(2)

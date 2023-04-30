//
//  ViewControllerPresenter.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import Foundation
import UIKit



class ViewModel {
    
    var requestObj: APIRequest?
    
    var homeObj: Obserable<[UserTableViewCellViewModel]> = Obserable(value: [])
    
    init(request: APIRequest) {
        self.requestObj = request
    }
   
    func fetchData() {
        self.requestObj?.loadData(completion: { home in
            self.homeObj.value = home.data?.compactMap({ data in
                UserTableViewCellViewModel(dataObj: data)
            })
        })
    }
}

struct UserTableViewCellViewModel {
    var dataObj: Datum
}

class Obserable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listner: @escaping (T?) -> Void) {
        listner(value)
        self.listener = listner
    }
}

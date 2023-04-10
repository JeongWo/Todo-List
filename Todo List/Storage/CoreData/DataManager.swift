//
//  DataManage.swift
//  Todo List
//
//  Created by 김정우 on 2023/04/10.
//
import UIKit

final class DataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

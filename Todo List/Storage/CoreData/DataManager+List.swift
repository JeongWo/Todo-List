//
//  DataManager+List.swift
//  Todo List
//
//  Created by 김정우 on 2023/04/10.
//

import CoreData

protocol DataMangerCRUD {
    func saveTodo(description: String)
    func allTodo() -> [Todo]
    func deleteTodo(uuid: String)
    func updateTodo(uuid: String, title: String)
}

extension DataManager: DataMangerCRUD {
    func saveTodo(description: String) {
        let todo = Todo(context: context)
        todo.title = description
        todo.id = UUID()
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func allTodo() -> [Todo] {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        var lists = [Todo]()
        do{
            lists = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return lists
    }
    
    func deleteTodo(uuid: String) {
        searchTodo(uuid: uuid) { [weak self] todo in
            guard let self = self else {return}
            do {
                self.context.delete(todo)
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateTodo(uuid: String, title: String) {
        searchTodo(uuid: uuid) { [weak self] todo in
            guard let self = self else {return}
            do {
                todo.title = title
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func searchTodo(uuid: String, completion: @escaping(Todo) -> Void) {
        let fetchListRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %@", uuid)
        fetchListRequest.predicate = predicate
        do {
            let objects = try context.fetch(fetchListRequest)
            guard let todo = objects.first else { return }
            completion(todo)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

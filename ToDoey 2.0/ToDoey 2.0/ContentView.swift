//
//  ContentView.swift
//  ToDoey 2.0
//
//  Created by Millie Kembe on 3/5/23.
//

import SwiftUI

struct ToDoItem: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool = false
}

struct ToDoList: Identifiable {
    var id = UUID()
    var name: String
    var toDoList = [ToDoItem]()
    var color: Color
    var icon: String
}


struct ContentView: View {
    
    @State var lists: [ToDoList] = [ToDoList(name: "Reminders", color: .blue, icon: "list.bullet.circle.fill"),
                                    ToDoList(name: "Homework", color: .red, icon: "graduationcap.circle.fill"),
                                    ToDoList(name: "App Team", color: .green, icon: "iphone.circle.fill"),
                                    ToDoList(name: "Today", color: .purple, icon: "calendar.circle.fill")]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach($lists) { $list in
                        NavigationLink(destination: ToDoListView(currentList: $list, newTodoTitle: "")) {
                            toDoView(list: $list)
                        }
                    }
                }
                .navigationTitle("Reminders")
                
            }
        }

    }
}

struct toDoView: View {
    @Binding var list: ToDoList
    
    var body: some View {
            HStack {
                Image(systemName: "\(list.icon)")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(list.color)
                Text("\(list.name)")
                Spacer()
                Text("\(list.toDoList.count)")
            }
        
    }
}

struct ToDoListView: View {
    
    @Binding var currentList: ToDoList
    @State var newTodoTitle: String
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("\(currentList.name)")
                    .foregroundColor(currentList.color)
                    .font(.title)
                    .bold()
                    .padding(.leading, 18)

                Spacer()
                Text("\(currentList.toDoList.count)")
                    .foregroundColor(currentList.color)
                    .font(.title)
                    .bold()
                    .padding(.trailing, 20)
                
            }
            .padding(.top, -50)
            List {

                ForEach($currentList.toDoList) { $item in
                    ToDoItemView(todo: $item, todoTitle: $newTodoTitle, currentList: $currentList)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                currentList.toDoList.append(ToDoItem(name: "", isCompleted: false))
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(currentList.color
                    )
                Text("New Reminder")
                    .foregroundColor(currentList.color)
            }
            .padding(.trailing, 190)
        }
        
    }
}

struct ToDoItemView: View {
    @Binding var todo: ToDoItem
    @Binding var todoTitle: String
    @Binding var currentList: ToDoList
    
    var body: some View {
        
        HStack {
            Button {
                todo.isCompleted.toggle()
            } label: {
                if(todo.isCompleted) {
                    Image(systemName: "circle.fill")
                        .foregroundColor(currentList.color)
                }
                else {
                    Image(systemName: "circle")
                        .foregroundColor(currentList.color)
                }
            }
            if(todo.isCompleted) {
                TextField("", text: $todo.name)
                    .foregroundColor(.gray)
                    .strikethrough()
            } else {
                TextField("", text: $todo.name)
            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

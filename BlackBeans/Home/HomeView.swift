//
//  HomeView.swift
//  BlackBeans
//
//  Created by Ricardo Gehrke on 05/01/20.
//  Copyright © 2020 Ricardo Gehrke Filho. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeView: View {
  
  @FetchRequest(fetchRequest: Bean.allBeansFetchRequest()) var beans: FetchedResults<Bean>
  
  @State private var isShowingAddBeanView: Bool = false
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(beans, id: \.self) {
            BeanCell(bean: $0)
          }.onDelete { indexSet in
            for index in indexSet {
              let bean = self.beans[index]
              try? Persistency.deleteBean(bean: bean)
            }
          }
        }
        Spacer()
        HStack {
          Text("Total")
          Spacer()
          Text(Persistency.allBeansSum.toCurrency ?? "")
        }.padding()
      }.sheet(isPresented: self.$isShowingAddBeanView) {
        AddBeanView(isShowing: self.$isShowingAddBeanView)
      }
      .navigationBarTitle("Everything")
      .navigationBarItems(trailing: Button(action: {
        self.isShowingAddBeanView.toggle()
      }) {
        Image(systemName: "plus")
      })
    }
  }
}

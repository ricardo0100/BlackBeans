//
//  BeanCell.swift
//  BlackBeans
//
//  Created by Ricardo Gehrke on 20/01/20.
//  Copyright © 2020 Ricardo Gehrke Filho. All rights reserved.
//

import SwiftUI

struct BeanCell: View {
  
  @State var bean: Bean
  
  var body: some View {
    let value = Text(bean.toCurrency)
      .foregroundColor(bean.isCredit ? Color.green : Color.red)
    return HStack {
      Text(bean.name)
      Spacer()
      value
    }
  }
  
}
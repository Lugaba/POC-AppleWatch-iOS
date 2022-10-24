//
//  ContentView.swift
//  watchTeste2
//
//  Created by Luca Hummel on 24/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var counter: Counter = Counter()
    
    var body: some View {
        HStack {
            Button {
                counter.descrease()
            } label: {
                Text("-")
            }.buttonStyle(.borderedProminent)
            .tint(.red)
            
            Spacer()
            
            Text("\(counter.num)").frame(minWidth: 80)
            
            Spacer()
            
            Button {
                counter.increase()
            } label: {
                Text("+")
            }.buttonStyle(.borderedProminent)
            .tint(.green)
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

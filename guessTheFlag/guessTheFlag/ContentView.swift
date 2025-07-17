import SwiftUI

struct ContentView: View {
    let countryNames = [
        "estonia",
        "france",
        "germany",
        "ireland",
        "italy",
        "monaco",
        "nigeria",
        "poland",
        "russia",
        "spain",
        "uk",
        "us"
    ]
    
    @State private var shuffledCountries: [String] = []

    
    @State private var selectedFlag = ""
    @State private var ans = 0
    @State private var showScore = false
    @State private var alertTitle = ""
    @State private var quesNum = 0
    @State private var scoreNum = 0
    
    
    @State private var angle: Double = 0
    @State private var tappedId:Int? = nil
    
    var body: some View {
       
            ZStack{
                
                BackgroundView()
                
                if shuffledCountries.count>=3{
                    VStack{
                        Spacer()
                        VStack{
                            Text("\(quesNum). Select the flag of")
                                .font(.title2)
                            Text("\(shuffledCountries[ans].uppercased())")
                                .font(.largeTitle)
                                .bold()
                        }.foregroundStyle(.white)
                        
                        VStack(spacing: 30){
                            ForEach(0..<3){i in
                                Image(shuffledCountries[i])
                                    .flagStyle()
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 1.5)) {
                                            selectedFlag = shuffledCountries[i]
                                            tappedId = i
                                            showScore = true
                                            alertTitle = matchFlags(selectedFlag) ? "✅ Correct!" : "❌ Wrong!"
                                        }
                                    }
                                    .shadow(color: .black, radius: 10)
                                    .rotation3DEffect(
                                        Angle(degrees: tappedId == i ? angle : 0),
                                        axis: (x: 0, y: 1, z: 0),
                                        perspective: 0.5
                                    )
                                    .animation(
                                        .easeInOut(duration: 2),
                                        value: tappedId
                                    )
                                    .opacity(tappedId == nil || tappedId == i ? 1 : 0.25)
                            }
                          
                        }
                        Spacer()
                        VStack{
                            Text("Score :\(scoreNum)")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        
                        
                    }
                }else{
                    ProgressView()
                }
                
            }
            .alert(
                Text("\(alertTitle)"),
                isPresented: $showScore
            ) {
                Button("OK", role: .cancel) {
                    askQuestion()
                   
                }
            } message: {
                Text("Keep going my man")
            }
            .onAppear{
                askQuestion()
            }
        
    }
    
    func askQuestion() {
        if quesNum >= 10 {
            quesNum = 0
            scoreNum = 0
        }
        quesNum += 1
        shuffledCountries = countryNames.shuffled()
        ans = Int.random(in: 0...2)
        tappedId = nil
    }


    func matchFlags(_ inputFlag:String)->Bool{
        if shuffledCountries[ans] == inputFlag{
            scoreNum+=1
            angle += 360
            return true
        }
        return false
    }
    
    func reset(){
        if quesNum>10{
            quesNum=1
            scoreNum=0
        }
    }
    
}

struct BackgroundView:View{
    var body : some View{
        
        AngularGradient(
            colors: [Color.red,Color.pink,Color.blue],
            center: .bottomLeading,
            angle: .degrees(40)
        ).ignoresSafeArea()
    }
}

//struct FlagModifier:ViewModifier{
//    func body(content:Content)->some View{
//            content
//                .resizable()   //only work for images or sth
//                .frame(width: 200,height: 130)
//                .clipShape(.capsule)
//    }
//}

extension Image{
    func flagStyle()->some View{
        self
            .resizable()
                        .frame(width: 200,height: 130)
                        .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}




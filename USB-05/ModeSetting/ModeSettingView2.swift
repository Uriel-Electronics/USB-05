//
//  ModeSettingView2.swift
//  USB-05
//
//  Created by 이요섭 on 3/13/24.
//

import SwiftUI
import CoreBluetooth


struct ModeSettingView2: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @StateObject private var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedSegment: Int = 1 // 0, 1, 2
    @State private var selectedSegmentText: Int = 1 // 0, 1
    
    @State private var selectedSegment2: Int = 1 // 0, 1, 2
    @State private var selectedSegmentText2: Int = 1 // 0, 1
    
//    @State private var Mode2OnTime: Int = UserDefaults.standard.integer(forKey: "Mode2 OnTime") // 일몰 전 시간
//    @State private var Mode2OffTime: Int = UserDefaults.standard.integer(forKey: "Mode2 OffTime") // 일몰 후 시간
//    @State private var Mode2OnTime2: Date = UserDefaults.standard.object(forKey: "Mode2 OnTime2") as? Date ?? Date()
//    @State private var Mode2OffTime2: Date = UserDefaults.standard.object(forKey: "Mode2 OffTime2") as? Date ?? Date()
    
    @State var Mode2OnTime: Int
    @State var Mode2OffTime: Int
    @State var Mode2OnTime2 = Date()
    @State var Mode2OffTime2 = Date()
    
    @State private var showingAlert = false // Alert 표시 상태
    @State private var alertMessage = "" // Alert에 표시할 메시지
    
    let segmentTitles = ["일몰 전", "일몰 정각", "일몰 후"]
    let segmentTitles2 = ["일출 전", "일출 정각", "일출 후"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    VStack {
                        VStack {
                            Text("모드 2")
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                                .padding()
                            
                            Text("일몰 켜짐, 밤중 꺼짐\n새벽 켜짐, 일출 꺼짐")
                                .font(Font.custom("Pretendard", size: 24).weight(.bold))
                                .foregroundColor(.textLight)
                            
                            HStack(alignment: .top, spacing: 4) {
                                HStack(spacing: 0) {
                                    Text("일몰")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 9, bottom: 12, trailing: 10))
                                .cornerRadius(8)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("밤중")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 0, bottom: 12, trailing: 0))
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("새벽")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 0, bottom: 12, trailing: 0))
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("일출")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 9, bottom: 12, trailing: 10))
                                .cornerRadius(8)
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .padding(EdgeInsets(top: 12, leading: 14, bottom: -6, trailing: 14))
                            
                            
                            HStack(alignment: .top, spacing: 0) {
                                VStack {}.frame(width: 2, height: 16).background(Color.urielRed)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielPurple)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielDarkBlue)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielBlue)
                            }
                            .padding(EdgeInsets(top: 0, leading: 56, bottom: 0, trailing: 56))
                            .frame(maxWidth: .infinity)
                            
                            
                            HStack(spacing: 2) {
                                VStack(spacing: 0) {
                                    Text("OFF")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.white)
                                        .opacity(0.50)
                                }
                                .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                .frame(height: 40)
                                .cornerRadius(8)
                                HStack(spacing: 0) {
                                    Text("ON")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.black)
                                }
                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(8)
                                HStack(spacing: 0) {
                                    Text("OFF")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.white)
                                        .opacity(0.50)
                                }
                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                // .frame(width: 83, height: 40)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                                HStack(spacing: 0) {
                                    Text("ON")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.black)
                                }
                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(8)
                                VStack(spacing: 0) {
                                    Text("OFF")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.white)
                                        .opacity(0.50)
                                }
                                .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                .frame(height: 40)
                                
                                .cornerRadius(8)
                            }
                            .padding(EdgeInsets(top: 12, leading: 6, bottom : 12, trailing: 6))
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.13, green: 0.14, blue: 0.15))
                            .cornerRadius(12)
                            .padding(EdgeInsets(top: -12, leading: 14, bottom: 24, trailing: 14))
                        }
                        .background(Color.black)
                        
                        
                        
                        VStack {
                            VStack(alignment: .leading) {
                                
                                VStack {
                                    Text("일몰 때 켜지는 시간 설정")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        
                                        Rectangle().fill(Color.urielBlack).frame(width: geometry.size.width, height: geometry.size.height)
                                        
                                        
                                        Rectangle().fill(Color.white).frame(width: geometry.size.width / CGFloat(segmentTitles.count), height: 38).cornerRadius(12).offset(x: CGFloat(selectedSegment) * (geometry.size.width / CGFloat(segmentTitles.count)), y: 0).animation(.easeInOut(duration:0.3), value: selectedSegment)
                                        
                                        HStack(spacing: 0) {
                                            ForEach(0..<segmentTitles.count, id: \.self)
                                            {
                                                index in Text(self.segmentTitles[index]).font(Font.custom("Pretendard", size: 16).weight(.bold)).foregroundColor(self.selectedSegment == index ? .black : .white).frame(width: geometry.size.width / CGFloat(self.segmentTitles.count), height: 40).background(Color.clear).onTapGesture {
                                                    self.selectedSegment = index
                                                    switch index {
                                                    case 0:
                                                        self.Mode2OnTime = -60
                                                    case 1:
                                                        self.Mode2OnTime = 0
                                                    case 2:
                                                        self.Mode2OnTime = 60
                                                    default:
                                                        break
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 56)
                                    .background(.urielBlack)
                                    .cornerRadius(12)
                                }
                                .padding()
                                .frame(height: 48)
                                
                                
                                HStack {
                                    Text("일몰")
                                    
                                    // 일몰 전후 60분 선택
                                    Picker("Before Sunset:", selection: $Mode2OnTime) {
                                        ForEach(-60..<61) { minute in
                                            Text("\(minute)").tag(minute)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .frame(height: 100)
                                    .background(Color.urielBlack)
                                    .cornerRadius(16)
                                    .onChange(of: Mode2OnTime) { newValue in
                                        if newValue < 0 {
                                            selectedSegment = 0
                                            selectedSegmentText = 0
                                        } else if newValue == 0 {
                                            selectedSegment = 1
                                            selectedSegmentText = 1
                                        } else {
                                            selectedSegment = 2
                                            selectedSegmentText = 1
                                        }
                                        
                                    }
                                    
                                    Text("분 \(segmentText(for: selectedSegmentText)) 켜짐")
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom: 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            // 밤 중에 꺼지는 시간 (offTime2)
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("밤 중 꺼지는 시간")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                HStack {
                                    DatePicker("Before Sunset:", selection: $Mode2OffTime2, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .onAppear {
                                            Mode2OffTime2 = convertMinutesToDate(minutes: bluetoothManager.Mode2OffTime2)
                                        }
                                        .labelsHidden()
                                        .frame(height: 100)
                                        .padding(8)
                                        
                                    
                                    Text("꺼짐")
                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .opacity(0.5)
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom: 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            // 새벽에 켜지는 시간 (onTime2)
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("새벽에 켜지는 시간")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                HStack {
                                    DatePicker("Before Sunrise", selection: $Mode2OnTime2, displayedComponents: .hourAndMinute)
                                    
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .onAppear {
                                            Mode2OnTime2 = convertMinutesToDate(minutes: bluetoothManager.Mode2OnTime2)
                                        }
                                        .labelsHidden()
                                        .frame(height: 100)
                                        .padding(8)
                                    
                                    Text("켜짐")
                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .opacity(0.5)
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom: 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            VStack(alignment: .leading) {
                                
                                VStack {
                                    Text("일출 때 꺼지는 시간 설정")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(Color.urielBlack)
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                        
                                        // 선택 표시 배경
                                        Rectangle()
                                            .fill(Color.white)
                                            .frame(width: geometry.size.width / CGFloat(segmentTitles2.count) - 2, height: 38)
                                            .cornerRadius(12)
                                            .offset(x: CGFloat(selectedSegment2) * (geometry.size.width / CGFloat(segmentTitles2.count)), y: 0)
                                            .animation(.easeInOut(duration: 0.3), value: selectedSegment2)
                                        
                                        
                                        HStack(spacing: 0) {
                                            ForEach(0..<segmentTitles2.count, id: \.self) { index in
                                                Text(self.segmentTitles2[index])
                                                    .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                    .foregroundColor(self.selectedSegment2 == index ? .black : .white)
                                                    .frame(width: geometry.size.width / CGFloat(self.segmentTitles2.count), height: 40)
                                                    .background(Color.clear)
                                                    .onTapGesture {
                                                        self.selectedSegment2 = index
                                                        switch index {
                                                        case 0:
                                                            self.Mode2OffTime = -60 // "일몰 전" 선택 시
                                                        case 1:
                                                            self.Mode2OffTime = 0 // "일몰 정각" 선택 시
                                                        case 2:
                                                            self.Mode2OffTime = 60 // "일몰 후" 선택 시
                                                        default:
                                                            break
                                                        }
                                                    }
                                            }
                                        }
                                        
                                    }
                                    .frame(height: 56)
                                    .background(.urielBlack)
                                    .cornerRadius(12)
                                }
                                .padding()
                                .frame(height: 48)
                                
                                HStack {
                                    Text("일출")
                                    
                                    // 일출 후 시간 선택
                                    Picker("After Sunrise:", selection: $Mode2OffTime) {
                                        ForEach(-60..<61) { minute in
                                            Text("\(minute)").tag(minute)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .background(Color.urielBlack)
                                    .frame(height: 100)
                                    .cornerRadius(16)
                                    .onChange(of: Mode2OffTime) { newValue in
                                        if newValue < 0 {
                                            selectedSegment2 = 0
                                            selectedSegmentText2 = 0
                                        } else if newValue == 0 {
                                            selectedSegment2 = 1
                                            selectedSegmentText2 = 1
                                        } else {
                                            selectedSegment2 = 2
                                            selectedSegmentText2 = 1
                                        }
                                    }
                                    
                                    Text("분 \(segmentText(for: selectedSegmentText2)) 꺼짐")
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom : 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            HStack(spacing: 8) {
                                Button("취소") {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                
                                Button("확인") {
                                    sendMode2Data()
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.urielBlack)
                                .cornerRadius(12)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .background(Color.urielBlack)
                        .cornerRadius(24)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                        }
                    }
                }
            }
        }
    }

    
    func segmentText(for index: Int) -> String {
        switch index {
        case 0:
            return "전"
        case 1:
            return "후"
        default:
            return "후"
        }
    }
    
    func sendData() {
        if !bluetoothManager.bluetoothIsReady {
            print("기기가 연결되지 않음")
            alertMessage = "블루투스가 준비되지 않았습니다."
            showingAlert = true
            return
        }
        
        let date = Date()
        let yform = DateFormatter()
        let mform = DateFormatter()
        let dform = DateFormatter()
        let dayform = DateFormatter()
        let hhform = DateFormatter()
        let minform = DateFormatter()
        let ssform = DateFormatter()
        
        yform.dateFormat = "yyyy"
        mform.dateFormat = "MM"
        dform.dateFormat = "dd"
        dayform.dateFormat = "ccc"
        hhform.dateFormat = "HH"
        minform.dateFormat = "mm"
        ssform.dateFormat = "ss"
        
        let yy = yform.string(from: date)
        let mm = mform.string(from: date)
        let dd = dform.string(from: date)
        let day = dayform.string(from: date)
        print(day)
        let hh = hhform.string(from: date)
        let minute = minform.string(from: date)
        let ss = ssform.string(from: date)
            
            
        // 시리얼의 delegate를 SerialViewController로 설정합니다.
        //serial.delegate = self
        
        let YY = UInt8(Int(yy)! - 2000)
        print(YY)
        let MM = UInt8(Int(mm)!)
        print(MM)
        let DD = UInt8(Int(dd)!)
        print(DD)
        let DAY: UInt8 = {
            switch day {
            case "월": return 1
            case "화": return 2
            case "수": return 3
            case "목": return 4
            case "금": return 5
            case "토": return 6
            case "일": return 7
            default: return 0 // 잘못된 요일 값 처리
            }
        }()
        let HH = UInt8(Int(hh)!)
        let MIN = UInt8(Int(minute)!)
        let SS = UInt8(Int(ss)!)
        
        
        let LAT = locationManager.formattedLAT
        let LNG = locationManager.formattedLNG
        
        let bigLAT: Int16 = Int16(LAT)
        let bigLNG: Int16 = Int16(LNG)
        
        let upperLAT = UInt8(bigLAT >> 8)
        let lowerLAT = UInt8(bigLAT & 0x00FF)
        
        let upperLNG = UInt8(bigLNG >> 8)
        let lowerLNG = UInt8(bigLNG & 0x00FF)
        
        let _: Int16 = 0
        let _: Int16 = 0
               
        let CHECKSUM = 175 &+ YY &+ MM &+ DD &+ DAY &+ HH &+ MIN &+ SS &+ upperLAT &+ lowerLAT &+ upperLNG &+ lowerLNG &+ 5 &+ 70
        print(DAY)
        print(CHECKSUM)
        
        let packet: [UInt8] = [175, YY, MM, DD, DAY, HH, MIN, SS, upperLAT, lowerLAT, upperLNG, lowerLNG, 5, 70, CHECKSUM, 13, 10]
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
    }
    
    /* power on,off */
    func sendMode2Data() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        // 일몰
        if (Mode2OnTime < 0 && Mode2OffTime >= 0) {
            let onTimeData = Mode2OnTime
            
            let negativeOnTime: Int16 = Int16(onTimeData)
            let negativeOnTimeUInt16 = UInt16.init(bitPattern: negativeOnTime)
            
            let negativeOnTimeUInt1 = UInt8(negativeOnTimeUInt16 >> 8)
            let negativeOnTimeUInt2 = UInt8(negativeOnTimeUInt16 & 0x00FF)
            
            
            // let offTimeData2 = offTime2
            let offTime2minutes = dateToMinutes(date: Mode2OffTime2)
            let offTime2result: UInt16 = UInt16(offTime2minutes)
            let offTime2upperByte = UInt8(offTime2result >> 8)
            let offTime2lowerByte = UInt8(offTime2result & 0x00FF)
            
            
            // let onTimeData2 = onTime2
            let onTime2minutes = dateToMinutes(date: Mode2OnTime2)
            let onTime2result: UInt16 = UInt16(onTime2minutes)
            let onTime2upperByte = UInt8(onTime2result >> 8)
            let onTime2lowerByte = UInt8(onTime2result & 0x00FF)
            
            
            if (onTime2minutes == offTime2minutes) {
                alertMessage = "ON/OFF 시간을 다르게 설정해주세요."
                showingAlert = true
                return
            }
            
            
            let offTimeData = UInt8(Mode2OffTime)
            
            
            // Mode 2라서 207 &+ 2
            let CHECKSUM = 207 &+ 2 &+ negativeOnTimeUInt1 &+ negativeOnTimeUInt2 &+ offTimeData &+ onTime2upperByte &+ onTime2lowerByte &+ offTime2upperByte &+ offTime2lowerByte
            print(CHECKSUM)
            let packet: [UInt8] = [207, 2, 0, negativeOnTimeUInt1, negativeOnTimeUInt2, 0, offTimeData, onTime2upperByte, onTime2lowerByte, offTime2upperByte, offTime2lowerByte, CHECKSUM, 13, 10]
            
            print(packet)
            sendData()
            bluetoothManager.sendBytesToDevice(packet)

            alertMessage = "데이터가 성공적으로 전송되었습니다."
            showingAlert = true
            
            
            
            UserDefaults.standard.set(Mode2OnTime, forKey: "Mode2 OnTime")
            UserDefaults.standard.set(Mode2OffTime, forKey: "Mode2 OffTime")
            UserDefaults.standard.set(Mode2OnTime2, forKey: "Mode2 OnTime2")
            UserDefaults.standard.set(Mode2OffTime2, forKey: "Mode2 OffTime2")
            UserDefaults.standard.set("모드 2, 일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐", forKey: "selectedMode")
            self.presentationMode.wrappedValue.dismiss()
            
        } else if (Mode2OffTime < 0 && Mode2OnTime >= 0) {
            let onTimeData = UInt8(Mode2OnTime)
            
            
            let offTime2minutes = dateToMinutes(date: Mode2OffTime2)
            let offTime2result: UInt16 = UInt16(offTime2minutes)
            let offTime2upperByte = UInt8(offTime2result >> 8)
            let offTime2lowerByte = UInt8(offTime2result & 0x00FF)
            
            
            let onTime2minutes = dateToMinutes(date: Mode2OnTime2)
            let onTime2result: UInt16 = UInt16(onTime2minutes)
            let onTime2upperByte = UInt8(onTime2result >> 8)
            let onTime2lowerByte = UInt8(onTime2result & 0x00FF)
            
            
            let offTimeData = Mode2OffTime
            
            let negativeOffTime: Int16 = Int16(offTimeData)
            let negativeOffTimeUInt16 = UInt16.init(bitPattern: negativeOffTime)
            
            let negativeOffTimeUInt1 = UInt8(negativeOffTimeUInt16 >> 8)
            let negativeOffTimeUInt2 = UInt8(negativeOffTimeUInt16 & 0x00FF)
            
            if (onTime2minutes == offTime2minutes) {
                alertMessage = "ON/OFF 시간을 다르게 설정해주세요."
                showingAlert = true
                return
            }
            
            // Mode 2라서 207 &+ 2
            let CHECKSUM = 207 &+ 2 &+ onTimeData &+ negativeOffTimeUInt1 &+ negativeOffTimeUInt2 &+ onTime2upperByte &+ onTime2lowerByte &+ offTime2upperByte &+ offTime2lowerByte
            print(CHECKSUM)
            let packet: [UInt8] = [207, 2, 0, 0, onTimeData, negativeOffTimeUInt1, negativeOffTimeUInt2,onTime2upperByte, onTime2lowerByte, offTime2upperByte, offTime2lowerByte, CHECKSUM, 13, 10]
            
            print(packet)
            sendData()
            bluetoothManager.sendBytesToDevice(packet)
            alertMessage = "데이터가 성공적으로 전송되었습니다."
            showingAlert = true
            
            UserDefaults.standard.set(Mode2OnTime, forKey: "Mode2 OnTime")
            UserDefaults.standard.set(Mode2OffTime, forKey: "Mode2 OffTime")
            UserDefaults.standard.set(Mode2OnTime2, forKey: "Mode2 OnTime2")
            UserDefaults.standard.set(Mode2OffTime2, forKey: "Mode2 OffTime2")
            UserDefaults.standard.set("모드 2, 일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐", forKey: "selectedMode")
            self.presentationMode.wrappedValue.dismiss()
            
        } else if (Mode2OnTime < 0 && Mode2OffTime < 0) {
            let onTimeData = Mode2OnTime
            
            let negativeOnTime: Int16 = Int16(onTimeData)
            let negativeOnTimeUInt16 = UInt16.init(bitPattern: negativeOnTime)
            
            let negativeOnTimeUInt1 = UInt8(negativeOnTimeUInt16 >> 8)
            let negativeOnTimeUInt2 = UInt8(negativeOnTimeUInt16 & 0x00FF)
            
            
            // let offTimeData2 = offTime2
            let offTime2minutes = dateToMinutes(date: Mode2OffTime2)
            let offTime2result: UInt16 = UInt16(offTime2minutes)
            let offTime2upperByte = UInt8(offTime2result >> 8)
            let offTime2lowerByte = UInt8(offTime2result & 0x00FF)
            
            
            // let onTimeData2 = onTime2
            let onTime2minutes = dateToMinutes(date: Mode2OnTime2)
            let onTime2result: UInt16 = UInt16(onTime2minutes)
            let onTime2upperByte = UInt8(onTime2result >> 8)
            let onTime2lowerByte = UInt8(onTime2result & 0x00FF)
            
            let offTimeData = Mode2OffTime
            
            let negativeOffTime: Int16 = Int16(offTimeData)
            let negativeOffTimeUInt16 = UInt16.init(bitPattern: negativeOffTime)
            
            let negativeOffTimeUInt1 = UInt8(negativeOffTimeUInt16 >> 8)
            let negativeOffTimeUInt2 = UInt8(negativeOffTimeUInt16 & 0x00FF)
            
            if (onTime2minutes == offTime2minutes) {
                alertMessage = "ON/OFF 시간을 다르게 설정해주세요."
                showingAlert = true
                return
            }
            
            let CHECKSUM = 207 &+ 2 &+ negativeOnTimeUInt1 &+ negativeOnTimeUInt2 &+ negativeOffTimeUInt1 &+ negativeOffTimeUInt2 &+ onTime2upperByte &+ onTime2lowerByte &+ offTime2upperByte &+ offTime2lowerByte
            print(CHECKSUM)
            let packet: [UInt8] = [207, 2, 0, negativeOnTimeUInt1, negativeOnTimeUInt2,negativeOffTimeUInt1, negativeOffTimeUInt2,onTime2upperByte, onTime2lowerByte, offTime2upperByte, offTime2lowerByte, CHECKSUM, 13, 10]
            
            print(packet)
            sendData()
            bluetoothManager.sendBytesToDevice(packet)
            // Change Label Text expression "success" for waiting
            // serialMessageLabel.text = "waiting msg from peripheral"
            alertMessage = "데이터가 성공적으로 전송되었습니다."
            showingAlert = true
            
            UserDefaults.standard.set(Mode2OnTime, forKey: "Mode2 OnTime")
            UserDefaults.standard.set(Mode2OffTime, forKey: "Mode2 OffTime")
            UserDefaults.standard.set(Mode2OnTime2, forKey: "Mode2 OnTime2")
            UserDefaults.standard.set(Mode2OffTime2, forKey: "Mode2 OffTime2")
            UserDefaults.standard.set("모드 2, 일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐", forKey: "selectedMode")
            self.presentationMode.wrappedValue.dismiss()
            
        } else if (Mode2OnTime >= 0 && Mode2OffTime >= 0) {
            let onTimeData = UInt8(Mode2OnTime)
            
            
            let offTime2minutes = dateToMinutes(date: Mode2OffTime2)
            let offTime2result: UInt16 = UInt16(offTime2minutes)
            let offTime2upperByte = UInt8(offTime2result >> 8)
            let offTime2lowerByte = UInt8(offTime2result & 0x00FF)
            
            
            
            let onTime2minutes = dateToMinutes(date: Mode2OnTime2)
            let onTime2result: UInt16 = UInt16(onTime2minutes)
            let onTime2upperByte = UInt8(onTime2result >> 8)
            let onTime2lowerByte = UInt8(onTime2result & 0x00FF)
            
            if (onTime2minutes == offTime2minutes) {
                alertMessage = "ON/OFF 시간을 다르게 설정해주세요."
                showingAlert = true
                return
            }
            
            let offTimeData = UInt8(Mode2OffTime)
            
            
            let CHECKSUM = 207 &+ 2 &+ onTimeData &+ offTimeData &+ onTime2upperByte &+ onTime2lowerByte &+ offTime2upperByte &+ offTime2lowerByte
            print(CHECKSUM)
            let packet: [UInt8] = [207, 2, 0, 0, onTimeData, 0, offTimeData, onTime2upperByte, onTime2lowerByte, offTime2upperByte, offTime2lowerByte, CHECKSUM, 13, 10]
            
            print(packet)
            sendData()
            bluetoothManager.sendBytesToDevice(packet)
            alertMessage = "데이터가 성공적으로 전송되었습니다."
            showingAlert = true
            
            UserDefaults.standard.set(Mode2OnTime, forKey: "Mode2 OnTime")
            UserDefaults.standard.set(Mode2OffTime, forKey: "Mode2 OffTime")
            UserDefaults.standard.set(Mode2OnTime2, forKey: "Mode2 OnTime2")
            UserDefaults.standard.set(Mode2OffTime2, forKey: "Mode2 OffTime2")
            UserDefaults.standard.set("모드 2, 일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐", forKey: "selectedMode")
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func dateToMinutes(date: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return hour * 60 + minute
    }
    
    func convertMinutesToDate(minutes: Int) -> Date {
        let hours = minutes / 60
        let minutes = minutes % 60
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        dateComponents.minute = minutes
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents) ?? Date()
        return date
    }
        
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}
//
//  ModeSettingView2.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import Foundation

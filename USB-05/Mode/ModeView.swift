//
//  ModeView.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import CoreBluetooth

struct ModeView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    
    let allModeNames = ["모드 1", "모드 2", "모드 3", "모드 4", "모드 5", "모드 6"]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    Color.urielBlack.ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            VStack {
                                Text("모드 선택")
                                    .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                    .foregroundColor(.textLight)
                                    .padding()
                                
                                // 모드 1
                                NavigationLink(destination: ModeSettingView(bluetoothManager: bluetoothManager, OnTime: bluetoothManager.OnTime, OffTime: bluetoothManager.OffTime)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 1")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("일몰 켜짐, 일출 꺼짐")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("일몰")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("일출")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                        }
                                    }
                                }
                                
                                // 모드 2
                                NavigationLink(destination: ModeSettingView2(bluetoothManager: bluetoothManager, Mode2OnTime: bluetoothManager.Mode2OnTime, Mode2OffTime: bluetoothManager.Mode2OffTime)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 2")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("일몰")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("밤 중")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("새벽")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("일출")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(
                                                        EdgeInsets(top: 14, leading: 23, bottom: 14, trailing: 23.67)
                                                    )
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                            
                                            // Spacer()
                                        }
                                    }
                                }
                                
                                
                                // 모드 3
                                NavigationLink(destination: ModeSettingView3(bluetoothManager: bluetoothManager, Mode3OnTime: bluetoothManager.Mode3OnTime)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 3")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("일몰 켜짐, 밤중 꺼짐")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("일몰")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("밤 중")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("일출")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                            
                                            // Spacer()
                                        }
                                    }
                                }
                                
                                
                                // 모드 4
                                NavigationLink(destination: ModeSettingView4(bluetoothManager: bluetoothManager, Mode4OffTime: bluetoothManager.Mode4OffTime)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 4")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("새벽 켜짐, 일출 꺼짐")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("일몰")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("새벽")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("일출")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                            
                                            // Spacer()
                                        }
                                    }
                                }
                                
                                
                                // 모드 5
                                NavigationLink(destination: ModeSettingView5(bluetoothManager: bluetoothManager)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 5")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("설정 시간 켜짐, 설정 시간 꺼짐, 1회 반복")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    // .frame(width: 213, height: 40)
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                            
                                            // Spacer()
                                        }
                                    }
                                }
                                
                                
                                // 모드 6
                                NavigationLink(destination: ModeSettingView6(bluetoothManager: bluetoothManager)) {
                                    VStack(spacing: 20) {
                                        HStack(spacing: 50) {
                                            VStack (alignment: .leading) {
                                                HStack {
                                                    Text("모드 6")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                                Text("설정 시간 켜짐, 설정 시간 꺼짐, 2회 반복")
                                                    .font(Font.custom("Pretendard", size: 13).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding(EdgeInsets(top:6, leading:0, bottom: 0, trailing: 0))
                                                
                                                HStack(alignment: .top, spacing: 4) {
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                    }
                                                    .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                    .cornerRadius(8)
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                .cornerRadius(12)
                                                .padding(.top, 20)
                                                .padding(.bottom, 8)
                                                
                                                HStack(spacing: 2) {
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(
                                                        EdgeInsets(top: 14, leading: 23, bottom: 14, trailing: 23.67)
                                                    )
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                    HStack(spacing: 0) {
                                                        Text("ON")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color(red: 0.98, green: 0.99, blue: 1))
                                                    .cornerRadius(8)
                                                    VStack(spacing: 0) {
                                                        Text("OFF")
                                                            .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                            .lineSpacing(12)
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.50)
                                                    }
                                                    .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                                    .frame(height: 40)
                                                    .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                    .cornerRadius(8)
                                                }
                                                .padding(6)
                                                .frame(maxWidth: .infinity)
                                                .background(.black)
                                                .cornerRadius(12)
                                                
                                            }
                                            .padding(20)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                            .cornerRadius(24)
                                            .padding()
                                            .padding(.top, -20)
                                            
                                            // Spacer()
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

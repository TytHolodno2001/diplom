import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12


Rectangle{
    id: main_rec

    property int smallWidth: Param.tableSmallWidth
    property int bigWidth: Param.tableBigWidth
    property int headHeight: Param.tableHeadHeight
    property int cellHeight: Param.tableCellHeight
    property int margin: Param.margin24
    property string fontFamily: Param.textFontFamily
    property int fontPointSize: Param.textItemComp
    property color accentColor: Param.accentСolor1
    property color fontColor: darkTheme?Param.dtextColor1:Param.ltextColor1
    property color borderColor: darkTheme?Param.delemThirdColor:Param.lelemThirdColor
    property string statePar: "bad"
    property string title
    property var tableCell
    signal close();
    onTableCellChanged: {
        listModel.append(tableCell)
    }
    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2
        height: Param.tableHeight
        visible: true
        radius: Param.elemRadius
        Rectangle {
            id:title
            width: headHeight + smallWidth*2
            height: headHeight
            anchors.left: parent.left

            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: main_rec.title
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: fontPointSize
                color:  Param.accentСolor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }
        }

        Rectangle {
            id:onlyError
            width: Param.tableButtonWidth/2
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: borderColor
            border.width: Param.sizeFrame
visible:statePar=="ok"?false:true
            Text {
                text: "ошибки"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                id:err_ma
                property bool active: false
                anchors.fill: parent
                hoverEnabled : true

                // при наведении
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //при клике
                onPressed:
                {
                    parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                    parent.border.color = Param.accentСolor1}
                onReleased:{
                    themeChange.connect(function(){
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    })
                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                   parent.border.color = active?Param.accentСolor1:borderColor

                }
                onClicked: {
                    all_ma.active = false
                    active = true
                                        let errorComp = [];
                                        for(let i = 0; i < tableCell.length; i++){
                                            if(tableCell[i].par2!=tableCell[i].par3){
                                                errorComp.push(tableCell[i])
                                            }

                                        }
                                        listModel.clear()
                                        listModel.append(errorComp)
                                        onlyError.border.color = Param.accentСolor1
                                        all.border.color = borderColor
                }
            }
        }

        Rectangle {
            id:all
            width: Param.tableButtonWidth/2
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight + margin + onlyError.width
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: Param.accentСolor1
            border.width: Param.sizeFrame
visible:statePar=="ok"?false:true
            Text {
                text: "все"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                id: all_ma
                 property bool active: false
                anchors.fill: parent
                hoverEnabled : true

                // при наведении
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //при клике
                onPressed:
                {
                    parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                    parent.border.color = Param.accentСolor1}
                onReleased:{
                    themeChange.connect(function(){
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    })
                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                   parent.border.color = active?Param.accentСolor1:borderColor

                }
                onClicked: {
                    err_ma.active = false
                    active = true
                                        listModel.clear()
                                        listModel.append(tableCell)
                                        all.border.color = Param.accentСolor1
                                        onlyError.border.color = borderColor
                }
            }
        }

        Rectangle {
            id:cross
            width: headHeight
            height: headHeight
            anchors.right: parent.right
            anchors.top: parent.top
            color: parent.color
            radius: Param.elemRadius
            Image {
                id: cross_img
                source: darkTheme?Param.iconCrossDark:Param.iconCrossLight
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            //закрыть окно
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main_rec.close()
                }
            }
        }


        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: headHeight
            width: headHeight+smallWidth*2
            height: Param.tableHeight - headHeight
            clip: true
            color: parent.color
            radius: Param.elemRadius

            ListModel {
                id: listModel

            }

            Component {
                id:listDelegate
                Rectangle {
                    height: cellHeight
                    width: headHeight+smallWidth*2 - margin*2
                    color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: headHeight
                        height: cellHeight
                        //отсутпы
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: par1
                            font.pointSize: fontPointSize
                            color: fontColor
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: smallWidth
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: par2
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                            font.pointSize: fontPointSize
                            color: par2 == "план"?fontColor:(par2 == par3? fontColor:Param.accentСolor2)
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: smallWidth
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight+smallWidth
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: par3
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                            font.pointSize: fontPointSize
                            color: par2 == "план"?fontColor:(par2 == par3? fontColor:Param.accentСolor2)
                        }
                    }
                }
            }
            ListView {
                anchors.fill: parent
                model: listModel
                delegate: listDelegate
            }

                    }
        }
        DropShadow {
            anchors.fill: table_info
            horizontalOffset: Param.horizOffset
            verticalOffset: Param.verticOffset
            radius: Param.mainRadius
            samples: Param.mainSamples
            color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
            source: table_info
        }
    }

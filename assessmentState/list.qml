import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12


Rectangle{
    id: main_rec
    property int elemWidth: Param.listWidth
    property int elemHeight: Param.listHeight
    property int titleHeight: Param.listTitleHeight

    property int margin: Param.margin24
    property string fontFamily: Param.textFontFamily
    property int fontPointSize: Param.textItemComp
    property color accentColor: Param.accentСolor1
    property color fontColor: darkTheme?Param.dtextColor1:Param.ltextColor1

    property string title: "Liza"

    // параметры в список
    property var itemComp

    signal close();

        onItemCompChanged: {
            listModel.append(itemComp)
        }

    Rectangle {
        id:content
        width: elemWidth
        height: elemHeight
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        radius: Param.elemRadius
        Rectangle {
            id:table_info
            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
            width: elemWidth
            height: titleHeight
            visible: true
            radius: Param.elemRadius
            Rectangle {
                id:title
                width: elemWidth - titleHeight
                height: titleHeight
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
                id:cross
                width: titleHeight
                height: titleHeight
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

            //сам список
            Rectangle {
                id: listPar
                anchors.top: parent.top
                anchors.topMargin: titleHeight
                width: elemWidth
                height: elemHeight - titleHeight
                clip: true
                color: parent.color
                radius: Param.elemRadius

                ListModel {
                    id: listModel

                    Component.onCompleted: {
                    }
                }

                Component {
                    id:listDelegate
                    Rectangle {
                        height: 20
                        width: elemWidth - margin*2
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        Text {
                            width: parent.width/2
                            text: number + ":"
                            font.family: Param.textFontFamily
                            font.pointSize: Param.textButtonSize
                            font.bold: true
                            color: statePar=="bad"?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                        }
                        Text {
                            width: parent.width/2
                            leftPadding: parent.width/2
                            text: value
                            font.family: Param.textFontFamily
                            font.pointSize: Param.textButtonSize
                            color: darkTheme?Param.dtextColor1:Param.ltextColor1
                        }
                    }
                }

                ListView {
                    anchors.margins: margin
                    anchors.fill: parent
                    model: listModel
                    delegate: listDelegate
                }

            }
        }
    }
    DropShadow {
        anchors.fill: content
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: content
    }
}


import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Rectangle{
    id: info_rect
    signal close();
    property string state_text
    property string text
    property string title_text

    property int margin: Param.margin24
    property int smallMargin: Param.margin16
    property int elemWidth: Param.itemCompWidth - Param.margin24
    property int elemHeight: Param.itemCompElemHeight
    Rectangle {
        id: info
        width: Param.itemCompWidth
        height: Param.itemCompHeight
        radius: Param.elemRadius
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor

        Rectangle {
            id:title
            width: elemWidth - elemHeight - margin
            height: Param.itemCompItemHeight
            anchors.left: parent.left
            anchors.leftMargin: margin
            anchors.top: parent.top
            anchors.topMargin: margin
            color: parent.color

            Text {
                text: info_rect.title_text
                font.family: Param.textFontFamily
                font.pointSize: Param.textItemComp

                color: Param.accentСolor1
                anchors.fill: parent
            }
        }

        Rectangle {
            id:cross
            width: elemHeight
            height: elemHeight
            anchors.right: parent.right
            anchors.rightMargin: margin
            anchors.top: parent.top
            anchors.topMargin: margin
            color: parent.color

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
                    info_rect.close()
                    }
            }
        }

        Rectangle {
            id:status_title
            width: elemWidth/3
            height: elemHeight
            anchors.left: parent.left
            anchors.leftMargin: margin
            anchors.top: parent.top
            anchors.topMargin: margin + smallMargin + elemHeight
            color: parent.color

            Text {
                text: "Состояние: "
                font.bold: true
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme?Param.dtextColor1:Param.ltextColor1
                anchors.fill: parent
            }
        }

        Rectangle {
            id:status
            width: elemWidth/3*2 - margin
            height: elemHeight
            anchors.left: parent.left
            anchors.leftMargin: elemWidth/3 + margin*2
            anchors.top: parent.top
            anchors.topMargin: margin + smallMargin + elemHeight
            color: parent.color

            Text {
                text: info_rect.state_text
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme?Param.dtextColor1:Param.ltextColor1
                anchors.fill: parent
            }
        }



        Rectangle {
            id: descript_title
            width: elemWidth
            height: elemHeight
            anchors.left: parent.left
            anchors.leftMargin: margin
            anchors.top: parent.top
            anchors.topMargin: margin+ smallMargin*2 + elemHeight*2
           color: parent.color

            Text {
                text: "Информация:"
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme?Param.dtextColor1:Param.ltextColor1
                anchors.fill: parent
                font.bold: true
            }
        }



        Rectangle {
            id: descript
            clip: true
            color: parent.color
            width: elemWidth
            height: parent.height - elemHeight *3 - margin*2 - smallMargin*3

            anchors.left: parent.left
            anchors.leftMargin: margin
            anchors.top: parent.top
            anchors.topMargin: margin + smallMargin*3 + elemHeight*3


            Text {
                id: content
                width: elemWidth
                wrapMode: Text.Wrap
                text: info_rect.text
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme?Param.dtextColor1:Param.ltextColor1
                y: -vbar.position * height
            }

            ScrollBar {
                id: vbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: descript.height / content.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }


    }


    DropShadow {
        anchors.fill: info
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: info
    }
}



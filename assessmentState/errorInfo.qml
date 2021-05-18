import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Rectangle{
    id: info_rect
    property string desc_error
    property string title_error
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
        border.width:  Param.sizeFrame
        border.color: Param.accentСolor2
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
                text: info_rect.title_error
                font.family: Param.textFontFamily
                font.pointSize: Param.textItemComp

                color: Param.accentСolor2
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
                    info_rect.visible = false
                    }
            }
        }
        Rectangle{
            width: elemWidth -  margin
            height: Param.itemCompHeight - Param.itemCompItemHeight - margin
            anchors.left: parent.left
            anchors.leftMargin: margin
            anchors.top: parent.top
            anchors.topMargin: elemHeight + margin*2
            color: parent.color
            Text {
                text: info_rect.desc_error
                font.family: Param.textFontFamily
                font.pointSize: Param.textItemComp
                color: darkTheme?Param.dtextColor1:Param.ltextColor1
                wrapMode: Text.Wrap
                anchors.fill: parent
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

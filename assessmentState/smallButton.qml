import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Item {
    property string itemText: "Текст"
    property string itemTextOnClick: "Текст"
    property string click: "no"
    signal onClick();
    onClickChanged: {
        if(click == "no"){
            smallButton.border.width = 0
        }
    }
    Rectangle {
        id:smallButton
        width: Param.buttonSmallWidth
        height: Param.buttonSmallHeight
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        radius: Param.elemRadius

        Text{
            width: parent.width - parent.height
            height: parent.height
            anchors.left: parent.left;
            anchors.leftMargin:  Param.margin32
            text: click == "yes"?itemTextOnClick:itemText
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textButtonSize
            color: darkTheme?Param.dtextColor1:Param.ltextColor1
        }


        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled : true

            // при наведении
            onEntered:{
                smallButton.border.width = Param.sizeFrame
                smallButton.border.color = Param.accentСolor3
            }
            onExited:{
                smallButton.border.width = click == "yes"? Param.sizeFrame: 0
                smallButton.border.color = Param.accentСolor1
            }

            //при клике
            onPressed:{

                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
            }
            onReleased:{
                themeChange.connect(function(){

                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                })
                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
            }

            //после клика
            onClicked:
            {
                if(click == "no") {
                    smallButton.border.width = Param.sizeFrame
                    smallButton.border.color = Param.accentСolor1
                    click = "yes"
                }
                else {
                    smallButton.border.width = 0
                    click = "no"
                }
                onClick()
            }
        }


        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 2
            height: parent.height - 4
            color: parent.color
            radius: Param.elemRadius


            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: click =="yes" ? Param.iconMinus : (darkTheme?Param.iconPlusDark:Param.iconPlusLight)
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

    }

    //тени
    DropShadow {
        anchors.fill: smallButton
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: smallButton
    }
}


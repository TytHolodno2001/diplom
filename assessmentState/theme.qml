import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Item {
    signal onClick();

    Rectangle {
        id:theme

        width: Param.buttonThemeSize
        height: Param.buttonThemeSize
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        radius: Param.elemRadius

        MouseArea {
            id:mouseAreaTheme
            anchors.fill: parent
            hoverEnabled : true

            // при наведении
            onEntered:{
                theme.border.width = Param.sizeFrame
                theme.border.color = Param.accentСolor3
            }
            onExited:{
                theme.border.width = 0
            }

            //после клика
            onClicked:
            {
                onClick()
            }
        }


        Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: darkTheme ? Param.iconThemeDark : Param.iconThemeLight
            rotation: 0
        }
    }

    //тени
    DropShadow {
        anchors.fill: theme
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: theme
    }
}


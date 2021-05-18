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


    property int widthAll
     property int heightAll
    property string title
    property var itemComp
    signal close();
    onItemCompChanged: {
        listModel.append(itemComp)
    }

    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: widthAll
        height: heightAll
        visible: true
        radius: Param.elemRadius

        //первая строка - заголовка
        Rectangle {
            id:title
            width: widthAll - Param.tableButtonWidth*2 - headHeight
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
            width: Param.tableButtonWidth
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: borderColor
            border.width: Param.sizeFrame

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
                    for(let i = 0; i < itemComp.length; i++){
                        if((itemComp[i].error=="есть ошибки")||itemComp[i].error=="ошибки"){
                            errorComp.push(itemComp[i])
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
            width: Param.tableButtonWidth
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight + margin + onlyError.width
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: Param.accentСolor1
            border.width:Param.sizeFrame

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
                    listModel.append(itemComp)
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

        //номер изделия, дата и время
                //сам список
        Rectangle {
            id: listPar
            anchors.top: parent.top
            anchors.topMargin: headHeight
            anchors.left: parent.left
            anchors.leftMargin: margin
            width: widthAll - margin*2
            height: table_info.height - (headHeight )
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
                    height: Param.tableButtonHeight
                    width:  widthAll - margin*2
                    color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    Rectangle {
                        height: parent.height
                        width: Param.tableHeadHeight
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: Param.sizeFrame
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        Text {
                            text: number
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color: darkTheme?Param.dtextColor1:Param.ltextColor1
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }

                    }
                    Rectangle {
                        height: parent.height
                        width: (parent.width - Param.tableHeadHeight)/3
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                         border.width: Param.sizeFrame
                        anchors.left: parent.left
                        anchors.leftMargin:  Param.tableHeadHeight
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: date
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  error=="есть ошибки"?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    }
                    Rectangle {
                        height: parent.height
                        width: (parent.width - Param.tableHeadHeight)/3
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                         border.width: Param.sizeFrame
                        anchors.left: parent.left
                        anchors.leftMargin:  Param.tableCellHeight + (parent.width - Param.tableHeadHeight)/3
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: time
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  error=="есть ошибки"?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    } Rectangle {
                        height: parent.height
                        width: (parent.width - Param.tableHeadHeight)/3
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                         border.width: Param.sizeFrame
                        anchors.left: parent.left
                        anchors.leftMargin:  Param.tableCellHeight + (parent.width - Param.tableHeadHeight)/3*2
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: error
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  error=="есть ошибки"?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
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

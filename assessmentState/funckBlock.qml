import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Rectangle{
    id: dragRect
    width: Param.fBWidth
    height: Param.fBHeight
    radius: Param.elemRadius

    property color item: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
    property color back: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
    property color menu: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
    property color text: darkTheme?Param.dtextColor1:Param.ltextColor1
    property string fontFamily: Param.textFontFamily
    property int menuWidth: Param.fBWidth
    property int menuHeight: Param.fBHeight
    property int itemHeight: Param.buttonSmallHeight
    property int itemMargin: Param.margin32
    property int itemWidth: Param.buttonSmallWidth
    property int menuRadius: Param.elemRadius
    property int menuPointSize: Param.textButtonSize
    property string click: "no"
    property string createBlock:  "no"

    property bool visStrelka: true

    //текст на объекте
    property string itemText

    //иконка объекта
    property string icon

    property int dragMinX: 0
    property int dragMaxX: 0
    property int dragMinY: 0
    property int dragMaxY: 0

    property bool selectItemVis: true

    // для добавления в меню дургих пунктов
    property var itemComp
    property var itemComp1

    property string itemCompText
    property string itemComp1Text

    property int allHeight:selectItemVis? (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin : (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin

    signal positionChange(double x, double y, string itemText)
    signal menuClose()


    z:3
    Drag.active:dragArea.drag.active
    MouseArea {
        id: dragArea
        z:4
        height: parent.height
        width:parent.width - parent.height
        drag {
            target: parent
            minimumY: dragMinY
            minimumX: dragMinX
            maximumX: dragMaxX
            maximumY: dragMaxY
        }

        onPositionChanged:  {
            positionChange(dragRect.x, dragRect.y, dragRect.itemText)
        }
    }
    Rectangle {
        id: menu
        width: dragRect.menuWidth
        height: dragRect.menuHeight
        color: dragRect.menu
        radius: dragRect.menuRadius
        Drag.active:dragArea.drag.active
        z:2
        MouseArea {

            anchors.fill: parent
            hoverEnabled : true

            // при наведении
            onEntered:{
                parent.border.width = Param.sizeFrame
                parent.border.color = Param.accentСolor3
            }
            onExited:{
                parent.border.width = 0
            }

            //при клике
            onPressed:
            {
                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                strelka.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                parent.border.width = Param.sizeFrame
                parent.border.color = Param.accentСolor1}
            onReleased:{
                themeChange.connect(function(){
                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    strelka.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                })
                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                strelka.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                parent.border.width = 0
            }
        }

        Text {
            width: parent.width - dragRect.menuHeight
            height: parent.height
            text: itemText

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: dragRect.fontFamily
            font.pointSize: 18 / 1.5
            color: dragRect.text
            anchors.left: parent.left
            anchors.leftMargin: dragRect.menuHeight - 40
        }

        Rectangle {
            property bool vis
            color: parent.color
            y: parent.y + 2
            width: dragRect.menuHeight - 2
            height: dragRect.menuHeight - 4
            radius: dragRect.menuRadius
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.Center
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: icon
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: strelka
            property bool vis
            color: parent.color
            y: parent.y + 2
            width: dragRect.menuHeight - 2
            height: dragRect.menuHeight - 4
            radius: dragRect.menuRadius
            anchors.right: parent.right
            anchors.rightMargin: 2
            visible: visStrelka

            Image {
                id: arrow_img
                anchors.verticalCenter: parent.verticalCenter
                source: darkTheme?Param.iconArrowBigWhite:Param.iconArrowBigBlack
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 270
            }
            vis: false
            PropertyAnimation { id: animation_item_open; target: itemMenu; property: "height"; to: allHeight ; duration:600 }
            PropertyAnimation { id: animation_item_open_up; target: itemMenu; property: "y"; to: menu.y - (allHeight) ; duration:600 }
            PropertyAnimation { id: animation_item_close; target: itemMenu; property: "height"; to: 0 ; duration:600 }
            PropertyAnimation { id: animation_item_close_up; target: itemMenu; property: "y"; to: menu.y + menuHeight ; duration:600 }
            PropertyAnimation { id: arrow_img_rotate; target: arrow_img; property: "rotation"; to: arrow_img.rotation + 180; duration: 600 }

            Timer {
                id:timer
                onTriggered: {itemMenu.visible = false
                }
            }

            MouseArea {
                id: strelka_area
                property bool openDown
                property bool openFirst: true
                anchors.fill: parent
                onClicked: {
                    if (openFirst) {
                        listItem.append(itemComp)
                        openFirst = !openFirst}

                    if (strelka.vis == false) {
                        itemMenu.visible = true
                        if(dragRect.y < scene.height/2){
                            animation_item_open.running = true
                            dragRect.dragMaxY -= allHeight
                            openDown = true
                        }
                        else {
                            animation_item_open.running = true
                            animation_item_open_up.running = true
                            dragRect.dragMinY += allHeight
                            openDown = false
                        }
                        arrow_img_rotate.running = true
                        strelka.vis = true
                    }
                    else {
                        menuClose()
                        if(openDown){
                            animation_item_close.running = true
                            dragRect.dragMaxY += allHeight
                        }
                        else {
                            animation_item_close.running = true
                            animation_item_close_up.running = true
                            dragRect.dragMinY -= allHeight
                        }

                        timer.interval = 600
                        timer.running = true
                        timer.repeat = false

                        arrow_img_rotate.running = true

                        strelka.vis = false
                    }

                }
                onPressed: strelka.color  = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                onReleased:{
                    themeChange.connect(function(){
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    })
                    strelka.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                }
            }
        }
    }
    DropShadow {
        anchors.fill: menu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: menu
    }


    Rectangle {
        id:itemMenu
        y: dragRect.menuHeight
        width: dragRect.itemWidth + dragRect.itemMargin + dragRect.itemMargin
        height: 0
        clip: true
        color: dragRect.back
        radius: dragRect.menuRadius
        visible: false
        //меню переключателя
        Rectangle {
            id: item1
            width:dragRect.itemWidth
            height: dragRect.itemHeight
            color: dragRect.back
            anchors.right: parent.right
            anchors.rightMargin: dragRect.itemMargin
            anchors.top: parent.top
            anchors.topMargin: dragRect.itemMargin
            radius: dragRect.menuRadius
            z:1
            visible:selectItemVis
            property bool left_block_vis: true

            PropertyAnimation { id: animation_left_block_open; target: left_block; property: "width"; to: Param.fBSelectBigWidth; duration: 200 }
            PropertyAnimation { id: animation_left_block_close; target: left_block; property: "width"; to: Param.fBSelectSmallWidth; duration: 200 }
            PropertyAnimation { id: animation_right_block_open; target: right_block; property: "width"; to: Param.fBSelectBigWidth; duration: 200 }
            PropertyAnimation { id: animation_right_block_close; target: right_block; property: "width"; to: Param.fBSelectSmallWidth; duration: 200 }

            Rectangle {
                id: left_block
                y: 0
                width: Param.fBSelectBigWidth
                height: dragRect.itemHeight
                color: dragRect.item
                anchors.left: Param.fBSelectBigWidth
                anchors.leftMargin: 0
                radius: dragRect.menuRadius

                Text {
                    anchors.fill: parent
                    text: itemCompText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: dragRect.fontFamily
                    font.pointSize: dragRect.menuPointSize
                    color: dragRect.text
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(item1.left_block_vis) {
                            //                            закрытие левого блока
                            listItem.clear()
                            listItem.append(itemComp1)
                            menuClose()
                            itemMenu.height = selectItemVis? (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin : (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
                            if(!strelka_area.openDown){
                                itemMenu.y = -itemMenu.height
                            }
                            animation_left_block_close.running = true
                            animation_right_block_open.running = true
                            item1.left_block_vis = false
                        }
                        else {
                            //                            закрытие правого блока
                            listItem.clear()
                            listItem.append(itemComp)
                            menuClose()
                            itemMenu.height = selectItemVis? (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin : (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
                            if(!strelka_area.openDown){
                                itemMenu.y =- itemMenu.height
                            }
                            animation_left_block_open.running = true
                            animation_right_block_close.running = true
                            item1.left_block_vis = true
                        }
                    }
                    hoverEnabled : true

                    // при наведении
                    onEntered:{
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor3
                    }
                    onExited:{
                        parent.border.width = 0
                    }

                    //при клике
                    onPressed:
                    {
                        parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor1}
                    onReleased:{
                        themeChange.connect(function(){
                            parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        })
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        parent.border.width = 0
                    }

                }

            }
            Rectangle {
                id:right_block
                y: 0
                width: Param.fBSelectSmallWidth
                height: dragRect.itemHeight
                color: dragRect.item
                anchors.right: parent.right
                anchors.rightMargin: 0
                radius: dragRect.menuRadius

                Text {
                    anchors.fill: parent
                    text: itemComp1Text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: dragRect.fontFamily
                    font.pointSize: dragRect.menuPointSize
                    color: dragRect.text
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(item1.left_block_vis) {
                            //закрытие левого блока
                            listItem.clear()
                            listItem.append(itemComp1)
                            menuClose()

                            itemMenu.height = selectItemVis? (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin : (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
                            if(!strelka_area.openDown){
                                itemMenu.y = -itemMenu.height
                            }
                            animation_left_block_close.running = true
                            animation_right_block_open.running = true
                            item1.left_block_vis = false
                        }
                        else {
                            //закрытие правого блока
                            listItem.clear()
                            listItem.append(itemComp)
                            menuClose()
                            itemMenu.height = selectItemVis? (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin : (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
                            if(!strelka_area.openDown){
                                itemMenu.y = -itemMenu.height
                            }
                            animation_left_block_open.running = true
                            animation_right_block_close.running = true
                            item1.left_block_vis = true
                        }
                    }
                    hoverEnabled : true

                    // при наведении
                    onEntered:{
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor3
                    }
                    onExited:{
                        parent.border.width = 0
                    }

                    //при клике
                    onPressed:
                    {
                        parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor1}
                    onReleased:{
                        themeChange.connect(function(){
                            parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        })
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        parent.border.width = 0
                    }
                }
            }
            DropShadow {
                anchors.fill: left_block
                horizontalOffset: Param.horizOffset
                verticalOffset: Param.verticOffset
                radius: Param.mainRadius
                samples: Param.mainSamples
                color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                source: left_block
            }
            DropShadow {
                anchors.fill: right_block
                horizontalOffset: Param.horizOffset
                verticalOffset: Param.verticOffset
                radius: Param.mainRadius
                samples: Param.mainSamples
                color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                source: right_block
            }

        }
        Rectangle{
            z:0
            anchors.top: parent.top
            anchors.topMargin: selectItemVis?dragRect.itemHeight + dragRect.itemMargin : 0
            width: dragRect.itemWidth + dragRect.itemMargin + dragRect.itemMargin
            height: (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
            color: parent.color
            radius: dragRect.menuRadius

            ListModel {
                id:listItem
            }

            Component {
                id:delItem
                Rectangle {

                    width: dragRect.itemWidth
                    height: dragRect.itemHeight
                    anchors.right: itemMenu.right
                    anchors.rightMargin: dragRect.itemMargin
                    radius: dragRect.menuRadius
                    color: dragRect.item
                    Rectangle {
                        id:itemOfMenu
                        width: dragRect.itemWidth
                        height: dragRect.itemHeight
                        color: dragRect.item

                        radius: dragRect.menuRadius
                        border.width: Param.sizeFrame
                        border.color: statePar == "ok"?Param.accentСolor1:Param.accentСolor2

                        Text{
                            width: parent.width - parent.height
                            height: parent.height
                            anchors.left: parent.left;
                            anchors.leftMargin:  Param.margin32
                            text: name
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            font.pointSize: Param.textButtonSize
                            color: darkTheme?Param.dtextColor1:Param.ltextColor1
                        }

                        Rectangle {

                            anchors.right: parent.right
                            anchors.rightMargin: 2
                            anchors.verticalCenter: parent.verticalCenter
                            width: dragRect.itemHeight - 2
                            height: dragRect.itemHeight - 4
                            color: parent.color
                            radius: dragRect.menuRadius


                        }

                        MouseArea {

                            property bool create: false
                            anchors.fill: parent
                            hoverEnabled : true

                            // при наведении
                            onEntered:{
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor3
                            }
                            onExited:{
                                parent.border.width = Param.sizeFrame
                                parent.border.color = statePar == "ok"?Param.accentСolor1:Param.accentСolor2
                            }

                            //при клике
                            onPressed:
                            {
                                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor2}
                            onReleased:{
                                themeChange.connect(function(){
                                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                                })
                                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                                parent.border.color = statePar == "ok"?Param.accentСolor1:Param.accentСolor2

                            }

                            onClicked:{
                                // ТУТ JSON
                                if(!create) {
                                    let selectHeight = selectItemVis? dragRect.itemHeight + dragRect.itemMargin: 0

                                    if(type == "table"){
                                        let component = Qt.createComponent("table.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(dragRect)
                                            childRec.statePar = statePar
                                            let rows = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                rows.push({number: elem.number, tnp: elem.tnp, tkp: elem.tkp, tnr: elem.tnr, tkr: elem.tkr, mode: elem.mode})
                                            }
                                            childRec.tableCell = rows

                                            childRec.title = name
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.tableWidth)
                                                //слева
                                            {
                                                childRec.x = -dragRect.itemMargin - /*ширина элемента*/ Param.tableWidth
                                            }
                                            else
                                                //справа
                                            {
                                                childRec.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.tableHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.tableHeight
                                                }
                                                else{
                                                    //влазит
                                                    childRec.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.tableHeight> scene.height) {
                                                    //не влазит
                                                    childRec.y = Param.fBHeight - /*высота элемента*/ Param.tableHeight
                                                }
                                                else{
                                                    childRec.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "table2"){

                                        let component = Qt.createComponent("table2.qml");
                                         console.log(component.status)
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(dragRect)
childRec.statePar = statePar
                                            let rows = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                rows.push({par1: elem.par1, par2: elem.par2, par3: elem.par3})
                                            }
                                            childRec.tableCell = rows

                                            childRec.title = name
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.tableSWidth)
                                                //слева
                                            {
                                                childRec.x = -dragRect.itemMargin - /*ширина элемента*/ Param.tableSWidth
                                            }
                                            else
                                                //справа
                                            {
                                                childRec.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.tableHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.tableHeight
                                                }
                                                else{
                                                    //влазит
                                                    childRec.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.tableHeight> scene.height) {
                                                    //не влазит
                                                    childRec.y = Param.fBHeight - /*высота элемента*/ Param.tableHeight
                                                }
                                                else{
                                                    childRec.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "list"){
                                        let component = Qt.createComponent("list.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(dragRect)

                                            let items = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                items.push({number: elem.number, value: elem.value, statePar: elem.statePar})
                                            }
                                            childRec.itemComp = items
                                            childRec.title = name
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.listWidth)
                                                //слева
                                            {
                                                childRec.x = -dragRect.itemMargin - /*ширина элемента*/ Param.listWidth
                                            }
                                            else
                                                //справа
                                            {
                                                childRec.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //открывается напротив пункта или выше

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.listHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.listHeight
                                                }
                                                else{
                                                    //влазит
                                                    childRec.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.listHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = Param.fBHeight - /*высота элемента*/ Param.listHeight
                                                }
                                                else{
                                                    childRec.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }


                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "items"){
                                        let component = Qt.createComponent("items.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(dragRect)

                                            let items = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                if (elem.type == "table") items.push({name: elem.name, type: elem.type, statePar: elem.state, info: elem.info})
                                                else items.push({name: elem.name, type: elem.type, statePar: elem.state, info: elem.inform})
                                            }

                                            childRec.itemComp = items
                                            childRec.title = name
                                            //открывается справа или слева
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.itemsWidth)
                                                //слева
                                            {
                                                childRec.x = -dragRect.itemMargin - /*ширина элемента*/ Param.itemsWidth
                                            }
                                            else
                                                //справа
                                            {
                                                childRec.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //открывается напротив пункта или выше

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.itemsHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.itemsHeight
                                                }
                                                else{
                                                    //влазит
                                                    childRec.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.itemsHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = Param.fBHeight - /*высота элемента*/ Param.itemsHeight
                                                }
                                                else{
                                                    childRec.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "table3"){
                                        let component = Qt.createComponent("table3.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(dragRect)

childRec.statePar = statePar
                                            let rows = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)

                                                rows.push({param: elem.param, value: elem.value, min: elem.min, max: elem.max})
                                            }
                                            childRec.itemComp = rows

                                            childRec.title = name

                                            //открывается справа или слева
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.tableMediumWidth)
                                                //слева
                                            {
                                                childRec.x = -dragRect.itemMargin - /*ширина элемента*/ Param.tableMediumWidth
                                            }
                                            else
                                                //справа
                                            {
                                                childRec.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //открывается напротив пункта или выше

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    //влазит
                                                    childRec.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    childRec.y = Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    childRec.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "expressHelp") {
                                        let component = Qt.createComponent("expressHelpBAPD.qml");
                                        if (component.status === Component.Ready) {
                                            var child= component.createObject(dragRect);
childRec.statePar = statePar
                                            let tableInfo = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                tableInfo.push({param: elem.mode, bstp: elem.bstp, betp: elem.betp, bstr: elem.bstr, betr: elem.betr})
                                            }
                                            child.itemComp = tableInfo
                                            create = true

                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.tableMediumWidth)
                                                //слева
                                            {
                                                child.x = -dragRect.itemMargin - /*ширина элемента*/ Param.tableMediumWidth
                                            }
                                            else
                                                //справа
                                            {
                                                child.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //открывается напротив пункта или выше

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    child.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    //влазит
                                                    child.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    child.y = Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    child.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            child.close.connect(function(){
                                                child.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "expressHelpPPO") {

                                        let component = Qt.createComponent("expressHelpPPO.qml");
                                        if (component.status === Component.Ready) {
                                            var child= component.createObject(dragRect);
                                            //открывается справа или слева
                                            if(dragRect.x > scene.width - (dragRect.itemMargin + Param.fBWidth) - /*ширина элемента*/Param.tableMediumWidth)
                                                //слева
                                            {
                                                child.x = -dragRect.itemMargin - /*ширина элемента*/ Param.tableMediumWidth
                                            }
                                            else
                                                //справа
                                            {
                                                child.x = dragRect.itemMargin + Param.fBWidth
                                            }

                                            //открывается напротив пункта или выше

                                            //список открывается вниз
                                            if(strelka_area.openDown){
                                                if(dragRect.y + selectHeight + Param.fBHeight + dragRect.itemHeight*(number -1) + dragRect.itemMargin * (number) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    child.y = dragRect.itemHeight*(listItem.count)+ dragRect.itemMargin * (listItem.count + 1) + selectHeight + Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    //влазит
                                                    child.y = Param.fBHeight + dragRect.itemHeight*(number - 1)+ dragRect.itemMargin * (number) + selectHeight
                                                }
                                            }
                                            //cписок открывается наверх
                                            else {
                                                if(dragRect.y - dragRect.itemHeight*(listItem.count - number) - dragRect.itemMargin * ((listItem.count - number)+1) + /*высота элемента*/ Param.tableMediumHeight > scene.height) {
                                                    //не влазит
                                                    child.y = Param.fBHeight - /*высота элемента*/ Param.tableMediumHeight
                                                }
                                                else{
                                                    child.y =  - dragRect.itemHeight*(listItem.count - number + 1) -dragRect.itemMargin * ((listItem.count - number +1))
                                                }

                                            }

                                            child.mode = infoPar.mode

                                            child.tn = infoPar.tn
                                            child.tk = infoPar.tk
                                            child.basi = infoPar.BASI
                                            child.bapd = infoPar.BAPD
                                            child.si = infoPar.SI
                                            child.mn = infoPar.MN
                                            child.title = name
                                            child.numberProduct = infoPar.number
                                            child.dateProduct = infoPar.date
                                            child.timeProduct= infoPar.time

                                            create = true

                                            menuClose.connect(function(){
                                                child.destroy()
                                                create = false
                                            })
                                            child.close.connect(function(){
                                                child.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                }
                            }
                        }
                    }

                    DropShadow {
                        anchors.fill: itemOfMenu
                        horizontalOffset: Param.horizOffset
                        verticalOffset: Param.verticOffset
                        radius: Param.mainRadius
                        samples: Param.mainSamples
                        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                        source: itemOfMenu
                    }

                }

            }

            ListView {
                anchors.margins: dragRect.itemMargin
                anchors.fill: parent
                spacing: dragRect.itemMargin
                model: listItem
                delegate: delItem
            }
        }
    }
    DropShadow {
        anchors.fill: itemMenu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: itemMenu
    }
}

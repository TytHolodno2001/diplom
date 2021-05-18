import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Window {
    id: mainWindow
    width: 1920
    height: 1000
    visible: true
    color: darkTheme? Param.dbgColor:Param.lbgColor
    minimumHeight: Param.margin80*3 + Param.margin48*3 + menu.height + menu2.height + menu_DB.height
    minimumWidth: Param.margin80*2 + Param.margin48*4 + Param.fBWidth + menu.width + Param.tableWidth + Param.itemsWidth
    property bool darkTheme: true


    // Перемещение связи за квадратом
    function onPositionChange(x,y,itemText){

        for(let i = 0; i < connectFunckBlock.count; i++){
            if(connectFunckBlock.get(i).firstNode.itemText  === itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x1 = firstNode.x + firstNode.width/2
                connect.y1 = firstNode.y + firstNode.height/2
            }
            else if(connectFunckBlock.get(i).secondNode.itemText === itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x2 = secondNode.x + secondNode.width/2
                connect.y2 = secondNode.y + secondNode.height/2

            }
        }
    }

    // функция для кнопок - в параметры передаются настраевымые значения
    function createFunckBlock(name_eng, name_ru, icon, itemComp) {
        //динамическое создание объекта
        let component = Qt.createComponent("funckBlock.qml");
        if (component.status === Component.Ready) {
            let childRec = component.createObject(scene);
            childRec.x =  Param.margin48;
            childRec.y =  Param.margin48;
            childRec.dragMinX =  Param.margin48
            childRec.dragMaxX =  scene.width -  Param.margin48 - childRec.width
            childRec.dragMinY =  Param.margin48
            childRec.dragMaxY =  scene.height -  Param.margin48 - childRec.height
            childRec.itemText = name_ru
            childRec.icon = icon

            if (itemComp === 0){
                let componentError = Qt.createComponent("errorInfo.qml");
                if (componentError.status === Component.Ready) {
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "В файле отсутсвует информация для " + name_ru
                    child.title_error = "ОШИБКА"

                }
                childRec.visStrelka = false
            }
            else if (itemComp === 1){
                let componentError = Qt.createComponent("errorInfo.qml");
                if (componentError.status === Component.Ready) {
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "Файл с компонентами для " + name_ru + " содержит некорректные данные"
                    child.title_error = "ОШИБКА"

                }
                childRec.visStrelka = false
            }
            else{
                if(itemComp.select == true){
                    childRec.itemComp = itemComp.item
                    childRec.itemComp1 = itemComp.item1
                    childRec.selectItemVis = true
                    childRec.itemComp1Text = itemComp.itemText1
                    childRec.itemCompText = itemComp.itemText
                }
                else {
                    childRec.itemComp = itemComp.item
                    childRec.selectItemVis = false
                }
            }

            childRec.positionChange.connect(onPositionChange)

            scene.widthChange.connect(function(){
                childRec.dragMinX =  Param.margin48
                childRec.dragMaxX =  scene.width -  Param.margin48 - childRec.width
            })
            scene.heightChange.connect(function(){
                childRec.dragMinY =  Param.margin48
                childRec.dragMaxY =  scene.height -  Param.margin48 - childRec.height
            })

            let coun = funckBlocks.count


            //про связи
            let connects = JSON.parse(readTextFile("onboardEquipment.json"))
            if(connects == "") {
                let componentError = Qt.createComponent("errorInfo.qml");
                if (componentError.status === Component.Ready) {
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "Отсутсвует файл с информацией о связях"
                    child.title_error = "ОШИБКА"
                }
            }
            else if(connects.connect==undefined){
                let componentError = Qt.createComponent("errorInfo.qml");
                if (componentError.status === Component.Ready) {
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "В файле отсутсвует информация о связях"
                    child.title_error = "ОШИБКА"
                }
            }
            else if(connects.connect.length<1){
                let componentError = Qt.createComponent("errorInfo.qml");
                if (componentError.status === Component.Ready) {
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "В файле отсутсвует информация о связях"
                    child.title_error = "ОШИБКА"
                }
            }
            else {
                for( var i = 0; i < coun; i++ ) {
                    for( var j = 0; j < connects.connect.length; j++ ) {
                        let elem  = connects.connect[j]
                        if((elem.from == name_ru && elem.to == funckBlocks.get(i).data.itemText)|| (elem.from == funckBlocks.get(i).data.itemText && elem.to == name_ru)){
                            if(elem.state == "1") {
                                //в connect  можно добавить данные о связи между блоками
                                let componentLine = Qt.createComponent("line.qml");
                                if (componentLine.status === Component.Ready) {
                                    let childline = componentLine.createObject(scene);
                                    childline.x1 = childRec.x + childRec.width/2;
                                    childline.y1 = childRec.y + childRec.height/2;
                                    childline.x2 = funckBlocks.get(i).data.x + funckBlocks.get(i).data.width/2;
                                    childline.y2 = funckBlocks.get(i).data.y + funckBlocks.get(i).data.height/2;


                                    childline.statConnect = true

                                    if(funckBlocks.get(i).data.visible == false) childline.visible = false
                                    else childline.visible = true
                                    connectFunckBlock.append({firstNode: childRec, secondNode: funckBlocks.get(i).data, connect:childline })}
                            }
                            else if(elem.state == "2"){
                                //в connect  можно добавить данные о связи между блоками
                                let componentLine = Qt.createComponent("line.qml");
                                if (componentLine.status === Component.Ready) {
                                    let childline = componentLine.createObject(scene);
                                    childline.x1 = childRec.x + childRec.width/2;
                                    childline.y1 = childRec.y + childRec.height/2;
                                    childline.x2 = funckBlocks.get(i).data.x + funckBlocks.get(i).data.width/2;
                                    childline.y2 = funckBlocks.get(i).data.y + funckBlocks.get(i).data.height/2;
                                    if(funckBlocks.get(i).data.visible == false) childline.visible = false
                                    else childline.visible = true

                                    childline.statConnect = false
                                    connectFunckBlock.append({firstNode: childRec, secondNode: funckBlocks.get(i).data, connect:childline })}

                            }
                            break;
                        }
                    }
                }
            }



            funckBlocks.append({id:name_eng,data:childRec})
        }
    }

    // поиск по блокам и связям
    function find(model, criteria) {
        for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return model.get(i)
        return null
    }

    //функция для скрытия связи
    function visConnectNO(itemText){
        for(let i = 0; i < connectFunckBlock.count; i++){
            let firstNode = connectFunckBlock.get(i).firstNode
            let secondNode = connectFunckBlock.get(i).secondNode
            let connect = connectFunckBlock.get(i).connect
            if((firstNode.itemText === itemText )|| secondNode.itemText === itemText){
                connect.visible = false
            }
        }
    }

    //функция для отоброжения связи
    function visConnect(itemText){
        for(let i = 0; i < connectFunckBlock.count; i++){
            let firstNode = connectFunckBlock.get(i).firstNode
            let secondNode = connectFunckBlock.get(i).secondNode
            let connect = connectFunckBlock.get(i).connect
            if((firstNode.itemText === itemText && secondNode.visible === true)|| (secondNode.itemText === itemText && firstNode.visible === true)){
                connect.visible = true
            }
        }
    }

    //функция для чтения файлов
    function readTextFile(file)    {
        let rawFile = new XMLHttpRequest();
        let allText = ""
        rawFile.open("GET", file, false);
        rawFile.onreadystatechange = function ()
        {
            if(rawFile.readyState === 4)
            {
                if(rawFile.status === 200 || rawFile.status === 0)
                {
                    allText = rawFile.responseText;

                }
            }
        }
        rawFile.send(null);
        return allText
    }

    //функция создание компонентов для функционального блока
    function createItemComp(st) {
        if (st === undefined){
            return 0
        }
        else if (st.length < 1 || st.length >2){
            return 1
        }
        else{
            let item = []
            let item1 = []
            if(st.length === 1/*string[0].includes('!')*/){
                if(st[0].info.length<1){
                    return 1
                }
                else {
                    for (let i = 0; i < st[0].info.length; i++){
                        let elem = st[0].info[i]
                        item.push({number: elem.number, name: elem.name, type: elem.type, statePar: elem.state, infoPar: elem.info})
                    }
                    return {select: false, item:item}}
            }
            else {
                // let selectItem = string[0].split('-')
                if(st[0].info.length<1||st[1].info.length<1){
                    return 1
                }
                else{
                    for (let i = 0; i < st[0].info.length; i++){
                        let elem = st[0].info[i]
                        let info = elem.info

                        item.push({number: elem.number, name: elem.name, type: elem.type, statePar: elem.state, infoPar: info})

                    }

                    for (let j = 0; j < st[1].info.length; j++){
                        let elem = st[1].info[j]
                        item1.push({number: elem.number, name: elem.name, type: elem.type, statePar: elem.state, infoPar: elem.info})
                    }

                    return {select: true, item:item, item1:item1, itemText: st[0].mode, itemText1: st[1].mode}
                }
            }
        }
    }

    // тут хранятся созданные блоки
    ListModel {
        id: funckBlocks

    }

    // тут хранятся связи между ними
    ListModel {
        id: connectFunckBlock

    }

    //заголовок
    Rectangle{
        x: Param.margin80
        y: 0
        height: Param.margin80*2 + Param.margin48
        width: Param.buttonBigWidth
        color: mainWindow.color

        Text {
            width: parent.width
            height: parent.height
            anchors.left: parent.left;
            anchors.leftMargin: 0
            text: "Оценка работоспособности БА"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textTitleSize
            color: darkTheme? Param.accentСolor1:Param.ltextColor1
        }
    }

    signal themeChange()
    //кнопка для смены цвета темы
    Rectangle{
        id: theme
        x: mainWindow.width - Param.buttonThemeSize - Param.margin80
        y: Param.margin80
        height: Param.buttonThemeSize
        width: Param.buttonThemeSize
        color: mainWindow.color
        Component.onCompleted: {
            let component = Qt.createComponent("theme.qml");
            if (component.status === Component.Ready) {
                let childRec = component.createObject(theme)
                childRec.onClick.connect(function(){
                    darkTheme = !darkTheme
                    themeChange()

                })
            }


        }
    }

    //сцена для отоброжения объектов
    Rectangle {
        id: scene
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        width: parent.width - Param.margin48 - Param.margin80*2- Param.buttonBigWidth
        height: parent.height - Param.margin48 - Param.margin80*3
        y: Param.margin80*2 + Param.margin48
        x: Param.margin48 + Param.margin80 + Param.buttonBigWidth
        radius: Param.elemRadius
        z: -1
        clip: true
        signal widthChange()

        onWidthChanged: {
            widthChange()
        }

        signal heightChange()

        onHeightChanged: {
            heightChange()
        }
        DropArea {
            id: dropArea
            anchors.fill: parent
        }
    }

    //тени
    DropShadow {
        anchors.fill: scene
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: scene
    }

    //меню для отоброжения и скрытия объектов
    Rectangle {
        id: menu
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        width: Param.buttonBigWidth
        height: Param.buttonSmallHeight*4 + Param.margin32 + Param.margin24*3 + Param.buttonSmallHeight
        y: Param.margin80*2 + Param.margin48
        x: Param.margin80
        radius: Param.elemRadius
        z: -1

        property string createBlockPPU:  "no"
        property string createBlockPPO:  "no"
        property string createBlockBASI:  "no"
        property string createBlockBAPD:  "no"

        property var buttonPPU
        property var buttonPPO
        property var buttonBASI
        property var buttonBAPD

        Rectangle{
            width: Param.buttonSmallWidth
            height: Param.buttonSmallHeight
            color: parent.color

            anchors.leftMargin: Param.margin32
            anchors.left: parent.left
            Text{
                width: parent.width
                height: parent.height

                text: "Текущие данные"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme? Param.accentСolor1:Param.ltextColor1
            }
        }


        Component.onCompleted: {


            let component = Qt.createComponent("smallButton.qml");
            if (component.status === Component.Ready) {

                let childRec = component.createObject(menu)
                childRec.x = parent.x + Param.margin32
                childRec.y = parent.y  +Param.buttonSmallHeight
                childRec.itemText = "Отобразить ППУ"
                childRec.itemTextOnClick = "Скрыть ППУ"
                buttonPPU = childRec
                let childRec1 = component.createObject(menu)
                childRec1.x = parent.x + Param.margin32
                childRec1.y = parent.y  +Param.margin24 +Param.buttonSmallHeight+Param.buttonSmallHeight
                childRec1.itemText = "Отобразить БАСИ"
                childRec1.itemTextOnClick = "Скрыть БАСИ"
                buttonBASI= childRec1


                let childRec2 = component.createObject(menu)
                childRec2.x = parent.x + Param.margin32
                childRec2.y = parent.y  +Param.margin24*2 +Param.buttonSmallHeight*2+Param.buttonSmallHeight
                childRec2.itemText = "Отобразить БАПД"
                childRec2.itemTextOnClick = "Скрыть БАПД"
                buttonBAPD= childRec2


                let childRec3 = component.createObject(menu)
                childRec3.x = parent.x + Param.margin32
                childRec3.y = parent.y  +Param.margin24*3 +Param.buttonSmallHeight*3+Param.buttonSmallHeight
                childRec3.itemText = "Отобразить ППО"
                childRec3.itemTextOnClick = "Скрыть ППО"
                buttonPPO= childRec3



                //параметры БА

                if (readTextFile("onboardEquipment.json") == ""){
                    let componentError = Qt.createComponent("errorInfo.qml");
                    let child = componentError.createObject(mainWindow);
                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                    child.desc_error = "Отсутсвует файл с информацией"
                    child.title_error = "ОШИБКА"
                    childRec.onClick.connect(function(){
                        child = componentError.createObject(mainWindow);
                                            child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                            child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                            child.desc_error = "Отсутсвует файл с информацией"
                                            child.title_error = "ОШИБКА"
                    })
                    childRec1.onClick.connect(function(){
                        child = componentError.createObject(mainWindow);
                                            child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                            child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                            child.desc_error = "Отсутсвует файл с информацией"
                                            child.title_error = "ОШИБКА"
                    })
                    childRec2.onClick.connect(function(){
                        child = componentError.createObject(mainWindow);
                                            child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                            child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                            child.desc_error = "Отсутсвует файл с информацией"
                                            child.title_error = "ОШИБКА"
                    })
                    childRec3.onClick.connect(function(){
                        child = componentError.createObject(mainWindow);
                                            child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                            child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                            child.desc_error = "Отсутсвует файл с информацией"
                                            child.title_error = "ОШИБКА"
                    })


                }
                else {
                    let file = JSON.parse(readTextFile("onboardEquipment.json"))

                    let itemCompPPU = createItemComp(file.BA.PPU)

                    childRec.onClick.connect(function(){
                        if(menu_DB.bapd != null) {
                            menu_DB.createBlockBAPD = "no"
                            menu_DB.bapdLeft = false
                            menu_DB.buttonBapdDB.click = "no"
                            menu_DB.bapd.destroy()
                        }
                        if(menu_DB.basi != null) {
                            menu_DB.createBlockBASI = "no"
                            menu_DB.basiLeft = false
                            menu_DB.buttonBasiDB.click = "no"
                            menu_DB.basi.destroy()
                        }
                        if(createBlockPPU === "no") {
                            createFunckBlock("PPU", "ППУ", Param.iconPPUDark, itemCompPPU)
                            createBlockPPU = "yes"
                        }
                        else if(createBlockPPU === "yes"){
                            let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                            PPU.data.visible = false
                            visConnectNO("ППУ")
                            createBlockPPU = "no-vis"
                        }
                        else {
                            let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                            PPU.data.visible = true
                            visConnect("ППУ")
                            createBlockPPU = "yes"
                        }
                        if(menu2.visibleConnect === false){
                            visConnectNO("ППУ")
                        }
                    }
                    )
                    //параметры БА
                    let itemCompBASI = createItemComp(file.BA.BASI)

                    childRec1.onClick.connect(function(){
                        if(menu_DB.bapd != null) {
                            menu_DB.createBlockBAPD = "no"
                            menu_DB.bapdLeft = false
                            menu_DB.buttonBapdDB.click = "no"
                            menu_DB.bapd.destroy()
                        }
                        if(menu_DB.basi != null) {
                            menu_DB.createBlockBASI = "no"
                            menu_DB.basiLeft = false
                            menu_DB.buttonBasiDB.click = "no"
                            menu_DB.basi.destroy()
                        }
                        if(createBlockBASI === "no") {
                            createFunckBlock("BASI", "БАСИ", Param.iconBASIDark, itemCompBASI)
                            createBlockBASI = "yes"
                        }
                        else if(createBlockBASI === "yes"){
                            let PPU = find(funckBlocks, function(item) { return item.id === "BASI" })
                            PPU.data.visible = false
                            visConnectNO("БАСИ")
                            createBlockBASI = "no-vis"
                        }
                        else {
                            let PPU = find(funckBlocks, function(item) { return item.id === "BASI" })
                            PPU.data.visible = true
                            visConnect("БАСИ")
                            createBlockBASI = "yes"
                        }
                        if(menu2.visibleConnect === false){
                            visConnectNO("БАСИ")
                        }
                    }
                    )
                    //параметры БА
                    let itemCompBAPD = createItemComp(file.BA.BAPD)

                    childRec2.onClick.connect(function(){
                        if(menu_DB.bapd != null) {
                            menu_DB.createBlockBAPD = "no"
                            menu_DB.bapdLeft = false
                            menu_DB.buttonBapdDB.click = "no"
                            menu_DB.bapd.destroy()
                        }
                        if(menu_DB.basi != null) {
                            menu_DB.createBlockBASI = "no"
                            menu_DB.basiLeft = false
                            menu_DB.buttonBasiDB.click = "no"
                            menu_DB.basi.destroy()
                        }
                        if(createBlockBAPD === "no") {
                            createFunckBlock("BAPD", "БАПД", Param.iconBAPDDark , itemCompBAPD)
                            createBlockBAPD = "yes"
                        }
                        else if(createBlockBAPD === "yes"){
                            let PPU = find(funckBlocks, function(item) { return item.id === "BAPD" })
                            PPU.data.visible = false
                            visConnectNO("БАПД")
                            createBlockBAPD = "no-vis"
                        }
                        else {
                            let PPU = find(funckBlocks, function(item) { return item.id === "BAPD" })
                            PPU.data.visible = true
                            visConnect("БАПД")
                            createBlockBAPD = "yes"
                        }
                        if(menu2.visibleConnect === false){
                            visConnectNO("БАПД")
                        }
                    }
                    )
                    let itemCompPPO = createItemComp(file.BA.PPO)
                    childRec3.onClick.connect(function(){
                        if(menu_DB.bapd != null) {
                            menu_DB.createBlockBAPD = "no"
                            menu_DB.bapdLeft = false
                            menu_DB.buttonBapdDB.click = "no"
                            menu_DB.bapd.destroy()
                        }
                        if(menu_DB.basi != null) {
                            menu_DB.createBlockBASI = "no"
                            menu_DB.basiLeft = false
                            menu_DB.buttonBasiDB.click = "no"
                            menu_DB.basi.destroy()
                        }
                        if(createBlockPPO === "no") {
                            createFunckBlock("PPO", "ППО", Param.iconPPODark, itemCompPPO)
                            createBlockPPO = "yes"
                        }
                        else if(createBlockPPO === "yes"){
                            let PPU = find(funckBlocks, function(item) { return item.id === "PPO" })
                            PPU.data.visible = false
                            visConnectNO("ППО")
                            createBlockPPO= "no-vis"
                        }
                        else {
                            let PPU = find(funckBlocks, function(item) { return item.id === "PPO" })
                            PPU.data.visible = true
                            visConnect("ППО")
                            createBlockPPO = "yes"
                        }
                        if(menu2.visibleConnect === false){
                            visConnectNO("ППО")
                        }
                    }
                    )
                }



            }
        }
    }

    //тени
    DropShadow {
        anchors.fill: menu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: menu
    }


    //меню для отоброжения и скрытия объектов из БД
    Rectangle {
        id: menu_DB
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        width: Param.buttonBigWidth
        height: Param.buttonSmallHeight*2+ Param.margin32 + Param.margin24 + Param.buttonSmallHeight
        y: Param.margin80*2 + Param.margin48 + Param.margin48 +  Param.buttonSmallHeight*4 + Param.margin32 + Param.margin24*3 + Param.buttonSmallHeight
        x: Param.margin80
        radius: Param.elemRadius
        z: -1
        property string createBlockBASI:  "no"
        property string createBlockBAPD:  "no"

        property bool basiLeft: false
        property bool bapdLeft: false

        property var basi
        property var bapd

        property var buttonBapdDB
        property var buttonBasiDB

        Rectangle{
            width: Param.buttonSmallWidth
            height: Param.buttonSmallHeight
            color: parent.color

            anchors.leftMargin: Param.margin32
            anchors.left: parent.left
            Text{
                width: parent.width
                height: parent.height

                text: "Данные из БД"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: Param.textFontFamily
                font.pointSize: Param.textButtonSize
                color: darkTheme? Param.accentСolor1:Param.ltextColor1
            }

        }
        Component.onCompleted: {
            let component = Qt.createComponent("smallButton.qml");
            if (component.status === Component.Ready) {

                let childRec = component.createObject(menu_DB)

                childRec.x = parent.x + Param.margin32
                childRec.y = parent.y  +Param.buttonSmallHeight
                childRec.itemText = "Данные по БАПД"
                childRec.itemTextOnClick = "Данные по БАПД"
                buttonBapdDB = childRec
                childRec.onClick.connect(function(){


                    if(createBlockBAPD === "no") {

                        //скрыть все функциональные блоки
                        for(let j = 0; j < funckBlocks.count; j++) {
                            funckBlocks.get(j).data.visible = false

                        }
                        //скрыть все связи
                        for(let i = 0; i < connectFunckBlock.count; i++){
                            connectFunckBlock.get(i).connect.visible = false
                        }
                        //поменять надписи на кнопках
                        if(menu.buttonPPU != null) {
                            if (menu.createBlockPPU!="no" ) menu.createBlockPPU = "no-vis"
                            menu.buttonPPU.click = "no"
                        }
                        if(menu.buttonPPO != null) {
                            if (menu.createBlockPPO!="no" )menu.createBlockPPO = "no-vis"
                            menu.buttonPPO.click = "no"
                        }
                        if(menu.buttonBAPD != null) {
                            if (menu.createBlockBAPD!="no" )menu.createBlockBAPD = "no-vis"
                            menu.buttonBAPD.click = "no"
                        }
                        if(menu.buttonBASI != null) {
                            if (menu.createBlockBASI!="no" )menu.createBlockBASI = "no-vis"
                            menu.buttonBASI.click = "no"
                        }

                        if (readTextFile("onboardEquipment.json") == "") {
                            let componentError = Qt.createComponent("errorInfo.qml");
                            if (componentError.status === Component.Ready) {
                                let child = componentError.createObject(mainWindow);
                                child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                child.desc_error = "Файл с данными для БД отсутствует"
                                child.title_error = "ОШИБКА"
                            }
                        }
                        else{
                            let file = JSON.parse(readTextFile("onboardEquipment.json"))
                            if (file.BD == undefined){
                                let componentError = Qt.createComponent("errorInfo.qml");
                                if (componentError.status === Component.Ready) {
                                    let child = componentError.createObject(mainWindow);
                                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                    child.desc_error = "Файл с данными для БД содержит некорректные данные"
                                    child.title_error = "ОШИБКА"

                                }
                            }
                            else if (file.BD.BAPD == undefined){
                                let componentError = Qt.createComponent("errorInfo.qml");
                                if (componentError.status === Component.Ready) {
                                    let child = componentError.createObject(mainWindow);
                                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                    child.desc_error = "Файл с данными для БАППД содержит некорректные данные"
                                    child.title_error = "ОШИБКА"

                                }
                            }
                            else{
                                let component2 = Qt.createComponent("DB.qml");
                                if (component2.status === Component.Ready) {
                                    let childRec2 = component2.createObject(scene)
                                    if(!basiLeft){
                                        childRec2.x = Param.margin32
                                        bapdLeft = true}
                                    else{
                                        childRec2.x = Param.margin32*2+(scene.width - Param.margin32*3)/2
                                    }
                                    childRec2.y = Param.margin32

                                    childRec2.widthAll = (scene.width - Param.margin32*3)/2
                                    childRec2.heightAll = scene.height - Param.margin32*2
                                    childRec2.title = "БАПД"

                                    let item = []
                                    for (let i = 0; i < file.BD.BAPD.length; i++){
                                        let elem = file.BD.BAPD[i]

                                        item.push({number: elem.number, date: elem.date, time: elem.time, error: elem.error})

                                    }

                                    childRec2.itemComp = item
                                    childRec2.close.connect(function(){
                                        childRec2.destroy()
                                        createBlockBAPD = "no"
                                        bapdLeft = false
                                        childRec.click = "no"
                                    })
                                    bapd = childRec2
                                }
                                createBlockBAPD = "yes"
                            }
                        }
                    }
                    else if(createBlockBAPD === "yes"){
                        bapd.destroy()
                        createBlockBAPD = "no"
                        bapdLeft = false
                    }

                }
                )


                let childRec1 = component.createObject(menu_DB)
                childRec1.x = parent.x + Param.margin32
                childRec1.y = parent.y  +Param.margin24 +Param.buttonSmallHeight+Param.buttonSmallHeight
                childRec1.itemText = "Данные по БАСИ"
                childRec1.itemTextOnClick = "Данные по БАСИ"
buttonBasiDB = childRec1
                //параметры БА
                //                    let itemCompBASI = createItemComp(file.BA.BASI)

                childRec1.onClick.connect(function(){
                    if(createBlockBASI=== "no") {
                        //скрыть все функциональные блоки
                        for(let j = 0; j < funckBlocks.count; j++) {
                            funckBlocks.get(j).data.visible = false

                        }
                        //скрыть все связи
                        for(let i = 0; i < connectFunckBlock.count; i++){
                            connectFunckBlock.get(i).connect.visible = false
                        }
                        //поменять надписи на кнопках
                        //поменять надписи на кнопках
                        if(menu.buttonPPU != null) {
                            if (menu.createBlockPPU!="no" ) menu.createBlockPPU = "no-vis"
                            menu.buttonPPU.click = "no"
                        }
                        if(menu.buttonPPO != null) {
                            if (menu.createBlockPPO!="no" )menu.createBlockPPO = "no-vis"
                            menu.buttonPPO.click = "no"
                        }
                        if(menu.buttonBAPD != null) {
                            if (menu.createBlockBAPD!="no" )menu.createBlockBAPD = "no-vis"
                            menu.buttonBAPD.click = "no"
                        }
                        if(menu.buttonBASI != null) {
                            if (menu.createBlockBASI!="no" )menu.createBlockBASI = "no-vis"
                            menu.buttonBASI.click = "no"
                        }


                        if (readTextFile("onboardEquipment.json") == "") {
                            let componentError = Qt.createComponent("errorInfo.qml");
                            if (componentError.status === Component.Ready) {
                                let child = componentError.createObject(mainWindow);
                                child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                child.desc_error = "Файл с данными для БД отсутствует"
                                child.title_error = "ОШИБКА"
                            }
                        }
                        else{

                            let file = JSON.parse(readTextFile("onboardEquipment.json"))
                            if (file.BD == undefined){
                                let componentError = Qt.createComponent("errorInfo.qml");
                                if (componentError.status === Component.Ready) {
                                    let child = componentError.createObject(mainWindow);
                                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                    child.desc_error = "Файл с данными для БД содержит некорректные данные"
                                    child.title_error = "ОШИБКА"

                                }
                            }
                            else if (file.BD.BAPD == undefined){
                                let componentError = Qt.createComponent("errorInfo.qml");
                                if (componentError.status === Component.Ready) {
                                    let child = componentError.createObject(mainWindow);
                                    child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                    child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                    child.desc_error = "Файл с данными для БАППД содержит некорректные данные"
                                    child.title_error = "ОШИБКА"

                                }
                            }
                            else{
                                let component2 = Qt.createComponent("DB.qml");
                                if (component2.status === Component.Ready) {
                                    let childRec2 = component2.createObject(scene)
                                    if(!bapdLeft){
                                        childRec2.x = Param.margin32
                                        basiLeft = true}
                                    else{
                                        childRec2.x = Param.margin32*2+(scene.width - Param.margin32*3)/2

                                    }

                                    childRec2.y = Param.margin32

                                    childRec2.widthAll = (scene.width - Param.margin32*3)/2
                                    childRec2.heightAll = scene.height - Param.margin32*2
                                    childRec2.title = "БАСИ"

                                    let item = []
                                    for (let i = 0; i < file.BD.BASI.length; i++){
                                        let elem = file.BD.BASI[i]

                                        item.push({number: elem.number, date: elem.date, time: elem.time, error: elem.error})

                                    }

                                    childRec2.itemComp = item
                                    childRec2.close.connect(function(){
                                        childRec2.destroy()
                                        createBlockBASI = "no"
                                        basiLeft = false
                                        childRec1.click = "no"
                                        childRec1.border.width = 0
                                    })
                                    basi = childRec2
                                }
                                createBlockBASI = "yes"
                            }
                        }
                    }
                    else if(createBlockBASI === "yes"){

                        basi.destroy()
                        createBlockBASI = "no"
                        basiLeft = false
                    }

                }
                )
            }
        }
    }

    //тени
    DropShadow {
        anchors.fill: menu_DB
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: menu_DB
    }

    //меню для отоброжения связей и расположения
    Rectangle {
        id: menu2
        color: mainWindow.color
        width: Param.buttonBigWidth
        height: Param.margin32 + Param.buttonBigHeight*2
        y: mainWindow.height - Param.margin32 - Param.margin80 - Param.buttonBigHeight*2
        x: Param.margin80
        radius: Param.elemRadius
        z: -1
        property bool visibleConnect: true
        Component.onCompleted: {
            let component = Qt.createComponent("bigButton.qml");
            if (component.status === Component.Ready) {
                // отоброжение связей
                let childRec4 = component.createObject(menu2)
                childRec4.x = parent.x
                childRec4.y = parent.y
                childRec4.itemText = "Показать связи"
                childRec4.itemTextOnClick = "Скрыть связи"

                childRec4.onClick.connect(function(){
                    if(menu2.visibleConnect){
                        menu2.visibleConnect = false

                        let visCon = true
                        if(connectFunckBlock.count < 1){
                            visCon = false

                        }
                        for(let j = 0; j < funckBlocks.count; j++) {
                            if(funckBlocks.get(j).data.visible == true) {
                                visCon = true
                                break
                            }
                            else visCon = false
                        }

                        if(!visCon) {
                            let componentError = Qt.createComponent("errorInfo.qml");
                            if (componentError.status === Component.Ready) {
                                let child = componentError.createObject(mainWindow);
                                child.x = mainWindow.width/2 - Param.itemCompWidth/2
                                child.y = mainWindow.height/2 - Param.itemCompHeight/2
                                child.desc_error = "В данный момент связи отсутствуют"
                                child.title_error = "ПРЕДУПРЕЖДЕНИЕ"
                            }


                        }

                        for(let i = 0; i < connectFunckBlock.count; i++){
                            connectFunckBlock.get(i).connect.visible = false
                        }
                    }
                    else{
                        for(let i = 0; i < connectFunckBlock.count; i++){

                            let firstNode = connectFunckBlock.get(i).firstNode
                            let secondNode = connectFunckBlock.get(i).secondNode
                            let connect = connectFunckBlock.get(i).connect

                            if(firstNode.visible && secondNode.visible){
                                connect.x1 = firstNode.x + firstNode.width/2
                                connect.y1 = firstNode.y + firstNode.height/2
                                connect.x2 = secondNode.x + firstNode.width/2
                                connect.y2 = secondNode.y + firstNode.height/2
                                connectFunckBlock.get(i).connect.visible = true}

                        }
                        menu2.visibleConnect = true
                    }
                })


                // упорядочить связи
                let childRec5 = component.createObject(menu2)
                childRec5.x = parent.x
                childRec5.y = parent.y + Param.margin32 + Param.buttonBigHeight
                childRec5.itemText = "Упорядочить"
                childRec5.itemTextOnClick = "Упорядочить"
                childRec5.onClick.connect(function(){
                    //readTextFile("file:/pract_project/task2-1/text.txt");
                    let visFB = true

                    if(funckBlocks.count < 1){
                        visFB = false
                    }
                    else {
                        for(let i = 0; i < funckBlocks.count; i++) {
                            if(funckBlocks.get(i).data.visible == true) {
                                visFB = true
                                break
                            }
                            else visFB = false
                        }
                    }

                    if(!visFB){
                        let componentError = Qt.createComponent("errorInfo.qml");
                        if (componentError.status === Component.Ready) {
                            let child = componentError.createObject(mainWindow);
                            child.x = mainWindow.width/2 - Param.itemCompWidth/2
                            child.y = mainWindow.height/2 - Param.itemCompHeight/2
                            child.desc_error = "В данный момент бортовая аппаратура не отображается"
                            child.title_error = "ПРЕДУПРЕЖДЕНИЕ"
                        }
                    }
                    else {
                        let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                        if(PPU !== null) {
                            PPU.data.x = Param.margin48
                            PPU.data.y = PPU.data.dragMaxY
                        }

                        let PPO = find(funckBlocks, function(item) { return item.id === "PPO" })
                        if(PPO !== null) {
                            PPO.data.x = scene.width - Param.margin48 - PPO.data.width
                            PPO.data.y = PPO.data.dragMaxY
                        }

                        let BASI = find(funckBlocks, function(item) { return item.id === "BASI" })
                        if(BASI !== null) {
                            BASI.data.x = scene.width/2 - Param.margin48/2 - BASI.data.width
                            BASI.data.y = BASI.data.dragMinY
                        }

                        let BAPD = find(funckBlocks, function(item) { return item.id === "BAPD" })
                        if(BAPD!== null) {
                            BAPD.data.x = scene.width/2 + Param.margin48/2
                            BAPD.data.y = BAPD.data.dragMinY
                        }

                        for(let i = 0; i < connectFunckBlock.count; i++){
                            let firstNode = connectFunckBlock.get(i).firstNode
                            let secondNode = connectFunckBlock.get(i).secondNode
                            let connect = connectFunckBlock.get(i).connect

                            connect.x1 = firstNode.x + firstNode.width/2
                            connect.y1 = firstNode.y + firstNode.height/2
                            connect.x2 = secondNode.x + firstNode.width/2
                            connect.y2 = secondNode.y + firstNode.height/2

                        }
                    }
                }
                )

            }
        }
    }
}

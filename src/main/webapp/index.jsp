<html>
	<body>
<SCRIPT LANGUAGE="JavaScript">
		// *******************************************************************************
		// This is the script for the game's windows.
		// *******************************************************************************
		<!-- Begin
		function openAbout() {
		msg1=window.open("","msg1","height=200,width=250,left=200,top=200");
		msg1.document.write("<html><title>About Minesweeper</title>");
		msg1.document.write("<body bgcolor='white' onblur=window.close()>");
		msg1.document.write("<center><img src='winmineicon.gif'>");
		msg1.document.write("<p><font face='Arial' size=2><b>Minesweeper</b>");
		msg1.document.write("<p></font><font face='Arial' size=-1>");
		msg1.document.write("by P. Occil<br>JavaScript Version (c) 2000 by P. ");
		msg1.document.write("Occil<p><form>");
		msg1.document.write("<input type='button' width=50 value='OK'");
		msg1.document.write(" onclick='window.close();'>");
		msg1.document.write("</form></font></center>");
		msg1.document.write("</body></html>");
		
		}
		
		function openHelp() {
		msg2=window.open("","msg2","height=600,width=450,left=0,top=0, scrollbars=yes");
		msg2.document.write("<html><title>Minesweeper Help</title>");
		msg2.document.write("<body bgcolor='white' onblur=window.close()>");
		msg2.document.write("<center><img src='winmineicon.gif'>");
		msg2.document.write("<p><font face='Arial' size=2><b>Minesweeper Help");
		msg2.document.write("</b><p></font><font face='Arial' size=-1>");
		msg2.document.write('</center>');
		msg2.document.write("<p><p><b>The object of Minesweeper</"
		 +"b><p>The object of Minesweeper is to find all "
		 +"the mines as quickly as possible without uncoverin"
		 +"g any of them.<p><p><b>To play Minesweeper</b> "
		 +"<ol> <li> On the <b>Game</b> menu, click <b>New<"
		 +"/b>.</li> <li> To start the timer, click any squ"
		 +"are on the playing field.</li> </ol><i>Notes</i>"
		 +"<ul> <li>The game area consists of the playing"
		 +" field, a mine counter, and a timer.<li>You can "
		 +"uncover a square by clicking it. If you uncover a "
		 +"mine, you lose the game. <li>If a number appears "
		 +"on a square, it indicates how many mines are in th"
		 +"e eight squares that surround the numbered one. <"
		 +"li>To mark a square you suspect contains a mine, h"
		 +"old CTRL and click on it.</ul> <p><p> <b>Strateg"
		 +"ies and tips</b> <ul> <li>If you are uncertain a"
		 +"bout a square, hold CTRL and click on it twice to "
		 +"mark it with a question mark (?). Later, you can e"
		 +"ither mark the square as a mine or uncover it by r"
		 +"ight-clicking again once or twice. <li>Look for c"
		 +"ommon patterns in numbers, which often indicate a "
		 +"corresponding pattern of mines. For example, the p"
		 +"attern 2-3-2 at the edge of a group of uncovered s"
		 +"quares indicates a row of three mines next to the "
		 +"three numbers.</ul></body></html>");
		}
		
		// End -->
		</script>
		<SCRIPT language="JavaScript">
		// *******************************************************************************
		// This is the script for controlling the menus in the game.
		// *******************************************************************************
		var isNav,isIE
		var coll = ""
		var styleObj = ""
		if (navigator.appName == "Netscape") {
			isNav = true
			currWidth = innerWidth
			currHeight = innerHeight
			window.captureEvents(Event.RESIZE)
			window.onresize = handleResize
		} else {
			isIE = true
			coll = "all."
			styleObj = ".style"
		}
		
		function handleResize() {
			if ((innerWidth != currWidth) || (innerHeight != currHeight)) {
				location.reload()
				return false
			}
		}
		
		// Set Style Variables
		var navColor = "#BBBBBB"
		var navLightColor = "#EDEDED"
		var navDarkColor = "#AAAAAA"
		var menuColor = "#BBBBBB"
		var itemOnColor = "#888888"
		var itemOffColor = "#BBBBBB"
		var fontOnColor = "#000000"
		var fontOffColor = "#AAAAAA"
		var fontFace = "ms sans serif"
		var fontSize = "6pt"
		var semi = ";"
		var numberTopLevelMenus = 2
		
		
		var menu1 =	{
				Name: "Game", nwidth: 35, mwidth: 60,
				item1: { itext: "New", url: "javascript:location.reload();",  parent: 0 },
				item2: { itext: "Custom...", url: "javascript:location.reload();",  parent: 0 },
				item3: { itext: "Exit", url: "javascript:window.close();", isParent: 0 }
				}
		
		var menu2 =	{
				Name: "Help", nwidth: 22, mwidth: 120,
				item1: { itext: "Help", url: "javascript:openHelp();", isParent: 0 },
				item2: { itext: "About Minesweeper", url: "javascript:openAbout();", isParent: 0 }
				}
		
		//Set Misc Variables
		var done = 0
		var currMenuArray
		var currItemArray
		var currMenu
		var currItem
		var allNavs = new Array()
		var navCoords = new Array()
		var navState = 0
		var allMenus = new Array()
		var iCount
		var ciCount
		var childCount = 0
		var activeItem
		var nsGo = 0
		var diagOn
			
			var newWind
			
		
		var preloadArrow = new Image();
		preloadArrow.src = "/arrow.gif";
		
		//Mouse Over Nav Buttons
		function navUp() {
			if (navState) {
				if (navState != this) {
					for (var i = 1; i <= numberTopLevelMenus; i++) {
						allNavs[i].off()
					}
				}
				this.down()
			} else {
				if (isNav) {
					this.bgColor = navLightColor
				} else {
					this.style.borderBottomColor = navDarkColor
					this.style.borderRightColor = navDarkColor
					this.style.borderTopColor = navLightColor
					this.style.borderLeftColor = navLightColor
					this.style.padding = 0
				}
			}
		}
		
		//Turn Off Nav Buttons
		function navOff() {
			this.menu.reveal(1)
			if (isNav) {
				this.bgColor = navColor
			} else {
				this.style.borderBottomColor = navColor
				this.style.borderRightColor = navColor
				this.style.borderTopColor = navColor
				this.style.borderLeftColor = navColor
				this.style.padding = 0
			}
		}
		
		//Mouse Out Nav Buttons when menu is on
		function navOut() {
			if (!navState) {
				if (isNav) {
					this.bgColor = navColor
				} else {
					this.style.borderBottomColor = navColor
					this.style.borderRightColor = navColor
					this.style.borderTopColor = navColor
					this.style.borderLeftColor = navColor
					this.style.padding = 0
				}
			}
		}
		
		//Mouse Over Nav Button when navState is On
		function navDown() {
			this.menu.reveal()
			closeNewWind()
			if (isNav) {
				navState = allNavs[this.navNumber]
				allNavs[this.navNumber].bgColor = navDarkColor
			} else {
				navState = this
				this.style.borderBottomColor = navLightColor
				this.style.borderRightColor = navLightColor
				this.style.borderTopColor = navDarkColor
				this.style.borderLeftColor = navDarkColor
				this.style.paddingTop = 1
				this.style.paddingLeft = 1
			}
		}
		
		//Mouse Down Nav Buttons
		function navClick(which) {
			if (!navState) {
				if (isNav) {
					closeNewWind()
					allNavs[which].menu.reveal()
					navState = allNavs[which]
					allNavs[which].bgColor = navDarkColor
					window.captureEvents(Event.MOUSEDOWN)
					window.onmousedown = clearnavState
		
				} else {
					closeNewWind()
					this.menu.reveal()
					navState = this
					this.style.borderBottomColor = navLightColor
					this.style.borderRightColor = navLightColor
					this.style.borderTopColor = navDarkColor
					this.style.borderLeftColor = navDarkColor
					this.style.paddingTop = 1
					this.style.paddingLeft = 1
					document.onmousedown = doNothing
					document.onmousemove = doNothing
					document.onmouseup = releaseIt
				}
			}
			return false
		}
		
		//Do Nothing Release 
		function releaseIt(evt) {
			document.onmousedown = clearnavState
			document.onmouseup = "default"
			document.onmousemove = "default"
		}
		
		//Ignore further mousedowns
		function doNothing(evt) {
			return false
		}
		
		//Ignore further mousedowns
		function doNothing2(evt) {
			return false
		}
		
		//Hide All Menus and Return All Nav Buttons to Normal
		function clearnavState(evt) {
			var e = new Object()
			if (isNav) {
				window.releaseEvents(Event.MOUSEDOWN)
				var aM = navState.menu
				aM.right = aM.left + aM.width
				aM.bottom = aM.top + aM.clip.bottom - 3
				e.x = evt.pageX; e.y = evt.pageY
			} else {
				e.x = event.clientX; e.y = event.clientY
				document.onmousedown = "default"
			}
			for (var i = 1; i <= numberTopLevelMenus; i++) {
				if (((e.x > allNavs[i].x) && (e.x < allNavs[i].r)) && ((e.y > allNavs[i].y) && (e.y < allNavs[i].b))) {
					navState = 0
					allNavs[i].menu.reveal(1)
					allNavs[i].up()
					continue
				}
				allNavs[i].off()
			}
			navState = 0
		}
		
		function hiLight() {
			if (isNav) {
				this.item.bgColor = itemOnColor
				activeItem = this.item
				this.captureEvents(Event.MOUSEUP)
				this.onmouseup = goUrl
				if (this.item.hasChild) {
					if (this.item.container.childOn) {
						this.item.container.child.reveal(1)
					}
					this.item.child.reveal()
					this.item.container.childOn = 1
					this.item.container.child = this.item.child
				} else if (this.item.container.childOn) {
					this.item.container.child.reveal(1)
				}		
			} else {
				this.style.backgroundColor = itemOnColor
				if (this.hasChild) {
					if (this.container.childOn) {
						this.container.child.reveal(1)
					}
					this.child.reveal()
					this.container.childOn = 1
					this.container.child = this.child
				} else if (this.container.childOn) {
					this.container.child.reveal(1)
				}
			}		
		}
		
		function unLight() {
			if (isNav) {
				this.item.bgColor = itemOffColor
				this.releaseEvents(Event.MOUSEUP)
			} else {
				this.style.backgroundColor = itemOffColor
			}
		}
		
		function goUrl() {
			if (isNav) {
				if (this.item.url.length) {
					window.location= this.item.url
				}
			} else {
				if (this.url.length) {
					window.location= this.url
				}
			}
		}
		
		function revealIt(state) {
			if (state) {
				if (isNav) {
					this.visibility = "hidden"
					if (this.childOn) {
						this.child.visibility = "hidden"
					}
				} else {
					this.style.visibility = "hidden"
					if (this.childOn) {
						this.child.style.visibility = "hidden"
					}
				}
			} else {
				if (isNav) {
					this.visibility = "visible"
				} else {
					this.style.visibility = "visible"
				}
			}
		
		}
		
		function makeNav(w) {
			this.up = navUp
			this.down = navDown
			this.click = navClick
			this.off = navOff
			this.out = navOut
			this.onmouseover = navUp
			this.onmousedown = navClick
			this.onmouseout = navOut
			if (isNav) {
				this.left = this.x = navX
				this.top = this.y = navY
				this.r = this.x + this.document.width
				this.b = this.y + 24
				this.bgColor = navColor
				this.visibility = "visible"
				this.clip.left = -3
				this.clip.top = -2
				this.clip.bottom = 22
				this.clip.right += 3
			} else {
				this.style.borderStyle = "solid"
				this.style.borderWidth = 2
				this.style.borderColor = navColor
				this.style.pixelLeft = this.x = navX
				this.style.pixelTop = this.y = navY
				this.r = this.x + w
				this.b = this.y + 24
				this.style.backgroundColor = navColor
				this.style.visibility = "visible"
				this.up()
				this.out()
			}
			navX += (w + 10)
		}
		
		function makeItem(count) {
			if (isNav) {
				this.bgColor = itemOffColor
				this.visibility = "inherit"
				this.clip.left = -2
				this.clip.top = -2
				this.clip.right = currMenu.width - 3
				this.clip.bottom += 2
				this.container = this.parentLayer
				this.left = 2
				this.top = (count == 1) ? 2 : this.prev.top + this.prev.document.height + 4
			} else {
				this.style.cursor = "default"
				this.style.color = ((this.url || this.hasChild) && this.url.indexOf("nofileError") == -1) ? fontOnColor : fontOffColor
				this.style.backgroundColor = itemOffColor
				this.style.fontFamily = fontFace
				this.style.fontSize = fontSize
				this.style.padding = 2
				this.container = this.offsetParent
				this.onmousedown = goUrl
				this.onmouseover = hiLight
				this.onmouseout = unLight
			}
		}
		
		function makeMenu(isChild) {
			this.reveal = revealIt
			if (isNav) {
				this.bgColor = navDarkColor
				this.visibility = "hidden"
				this.top = (isChild) ? this.Parent.container.nav.b + this.Parent.top : this.nav.b + 2
				this.left = (isChild) ? this.Parent.container.nav.x + this.Parent.container.width : this.nav.x
				this.clip.left = -3
				this.clip.top = -3
				this.clip.right = currMenuArray.mwidth + 3
				this.clip.bottom = this.lastItem.top + this.lastItem.document.height + 5
			} else {
				this.style.backgroundColor = itemOffColor
				this.style.visibility = "hidden"
				this.style.top = (isChild) ? (this.Parent.container.nav.b + this.Parent.offsetTop) : this.nav.b
				this.style.left = (isChild) ? (this.Parent.container.nav.x + this.Parent.container.width -2) : this.nav.x
				this.style.borderStyle = "solid"
				this.style.borderWidth = 2
				this.style.borderTopColor = "#EDEDED"
				this.style.borderLeftColor = "#EDEDED"
				this.style.borderRightColor = "#AAAAAA"
				this.style.borderBottomColor = "#AAAAAA"
			}
		}
		
		function makeLayer(n,w,wrapper) {
			if (isNav) {
				eval("n = new Layer(w," + wrapper + ")")
			} else {
				divHTML = "<DIV ID=" + n + " STYLE=\"position:absolute \; width:" + w + "\"></DIV>"
				document.body.insertAdjacentHTML("BeforeEnd",divHTML)
			}
			return eval(n)
		}
		
		function Navs() {
			for (var i = 1; i <= numberTopLevelMenus; i++) {
				currMenuArray = eval("menu" + i)
				currNav = currMenuArray.Name
				currNav = makeLayer(currMenuArray.Name,currMenuArray.nwidth,"window")
				allNavs[i] = currNav
				var imgString = "<IMG SRC=\"\menu" + i + ".gif\" border=0 width=" + currMenuArray.nwidth + " height=14>"
				if (isNav) {
					imgString = "<A HREF=\"javascript: void doNothing2()\" onclick=\"navClick(" + i + ")\">" + imgString + "</A>"
					currNav.document.write(imgString)
					currNav.document.close()
				} else {
					currNav.innerHTML = imgString
				}
				currNav.make = makeNav
				currNav.make(currMenuArray.nwidth)
				currNav.navNumber = i
			}
		}
		
		function NSMenus() {
			for (i = 1; i <= numberTopLevelMenus; i++) {
				currMenuArray = eval("menu" + i)
				currMenu = currMenuArray.Name + "menu"
				currMenu = makeLayer(currMenuArray.Name + "menu", currMenuArray.mwidth,"window")
				allMenus[i] = currMenu
				currMenu.width = currMenuArray.mwidth
				currMenu.make = makeMenu
				currMenu.nav = allNavs[i]
				allNavs[i].menu = currMenu
				iCount = 1
				while (currMenuArray["item" +iCount]) {
					previous = (iCount > 1) ? currItem : null
					currItemArray = eval(currMenuArray["item" + iCount])
					arrowString = (currItemArray.isParent) ? "<IMG SRC=\"/arrow.gif\" width=14 height=14 border=0 align=right>" : ""
					currItemName = currMenuArray.Name + "Item" + iCount
					currItem = makeLayer(currItemName,currMenuArray.mwidth,"currMenu")
					currItem.url = currItemArray.url
					currItem.text = "\ \;\ \;\ \;" + currItemArray.itext
					currItem.html = "<SPAN ID=" + currItemName + ">" + arrowString + currItem.text + "</SPAN>"
					var fColor = ((currItemArray.url || currItemArray.isParent) && currItemArray.url.indexOf("nofileError") == -1) ? fontOnColor : fontOffColor
					currItem.html = "<FONT FACE=\"tahoma,arial,helvetica\" SIZE=2 COLOR=\"" + fColor + "\">" + currItem.html + "</FONT>"
					currItem.document.open()
					currItem.document.write(currItem.html)
					currItem.document.close()
					currItem.hasChild = currItemArray.isParent
					currItem.prev = previous
					currItem.make = makeItem
					currItem.make(iCount)
					currItem.cover = makeLayer(currItemName + "cover",currMenuArray.mwidth,"currMenu")
					currItem.cover.item = currItem
					currItem.cover.visibility = "inherit"
					currItem.cover.top = currItem.top
					currItem.cover.left = currItem.left 
					currItem.cover.clip.left = currItem.clip.left
					currItem.cover.clip.top = currItem.clip.top 
					currItem.cover.clip.right = currItem.clip.right
					currItem.cover.clip.bottom  = currItem.clip.bottom
					currItem.cover.onmouseover = hiLight
					currItem.cover.onmouseout = unLight
					if (currItem.hasChild) {
						childCount++
						currItem.child = NSChild(childCount,i)
					}
					iCount++
				}
				childCount = 0
				currMenu.lastItem = currItem
				currMenu.make()
			}			
		}
		
		function NSChild(cNumber,mNumber) {
			childMenuArray = eval("menu" + mNumber + "" + cNumber)
			childMenu = makeLayer(childMenuArray.Name,childMenuArray.mwidth,"window")
			childMenu.make = makeMenu
			ciCount = 1
			while (childMenuArray["item" + ciCount]) {
				cprevious = (ciCount > 1) ? childItem : null
				childItemArray = eval(childMenuArray["item" + ciCount])
				childItemName = childMenuArray.Name + "Item" + ciCount
				childItem = makeLayer(childItemName,childMenuArray.mwidth,"childMenu")
				childItem.url = childItemArray.url
				childItem.text = "\ \;\ \;\ \;" + childItemArray.itext
				childItem.html = "<SPAN ID=" + childItemName + ">" + childItem.text + "</SPAN>"
				var cfColor = (childItemArray.url && childItemArray.url.indexOf("nofileError") == -1) ? fontOnColor : fontOffColor
				childItem.html = "<FONT FACE=\"tahoma,arial,helvetica\" SIZE=2 COLOR=\"" + cfColor + "\">" + childItem.html + "</FONT>"
				childItem.document.open()
				childItem.document.write(childItem.html)
				childItem.document.close()
				childItem.prev = cprevious
				childItem.make = makeItem
				childItem.make(ciCount)
					childItem.cover = makeLayer(childItemName + "cover",childMenuArray.mwidth,"childMenu")
					childItem.cover.item = childItem
					childItem.cover.visibility = "inherit"
					childItem.cover.top = childItem.top
					childItem.cover.left = childItem.left 
					childItem.cover.clip.left = childItem.clip.left
					childItem.cover.clip.top = childItem.clip.top 
					childItem.cover.clip.right = childItem.clip.right
					childItem.cover.clip.bottom  = childItem.clip.bottom
					childItem.cover.onmouseover = hiLight
					childItem.cover.onmouseout = unLight
				ciCount++
			}
			childMenu.Parent = currItem
			childMenu.lastItem = childItem
			childMenu.make(1)
			return childMenu
		}
		
		function IEMenus() {
			for (i = 1; i <= numberTopLevelMenus; i++) {
				currMenuArray = eval("menu" + i)
				currMenu = currMenuArray.Name + "menu"
				currMenu = makeLayer(currMenuArray.Name + "menu",currMenuArray.mwidth)
				allMenus[i] = currMenu
				currMenu.width = currMenuArray.mwidth
				currMenu.make = makeMenu
				currMenu.nav = allNavs[i]
				allNavs[i].menu = currMenu
				iCount = 1
				var itemHTML = ""
				while (currMenuArray["item" + iCount]) {
					currItemArray = eval(currMenuArray["item" + iCount])
					arrowString = (currItemArray.isParent) ? "<IMG SRC=\"/arrow.gif\" width=14 height=14 align=right>" : ""
					currItemName = currMenuArray.Name + "Item" + iCount
					itemString = "<SPAN ID=\"" + currItemName + "\" STYLE=\"width:" + currMenuArray.mwidth + "\">" + arrowString + "\ \;\ \;\ \;" + currItemArray.itext + "</SPAN><BR>"
					itemHTML += itemString
					iCount++
				}
				currMenu.innerHTML += itemHTML
				allItems = currMenu.children.tags("SPAN")
				for (it = 0; it < allItems.length; it++) {
					currItemArray = eval(currMenuArray["item" + (it + 1)])
					currItem = eval(currMenuArray.Name + "Item" + (it + 1))
					currItem.url = currItemArray.url
					currItem.hasChild = currItemArray.isParent
					currItem.make = makeItem
					currItem.make()
					if (currItem.hasChild) {
						childCount++
						currItem.child = IEChild(i,childCount)
					}
				}
				currMenu.make()	
				childCount = 0
			}
		}
		
		function IEChild(mNumber,cNumber) {
			childMenuArray = eval("menu" + mNumber + "" + cNumber)
			childMenu = makeLayer(childMenuArray.Name,childMenuArray.mwidth)
			childMenu.make = makeMenu
			ciCount = 1
			var childItemHTML = ""
			while (childMenuArray["item" + ciCount]) {
				childItemArray = eval(childMenuArray["item" + ciCount])
				childItemName = childMenuArray.Name + "Item" + ciCount
				childItemString = "<SPAN ID=\"" + childItemName + "\" STYLE=\"width:" + childMenuArray.mwidth + "\">" + "\ \;\ \;" + childItemArray.itext + "</SPAN><BR>"
				childItemHTML += childItemString
				ciCount++
			}
			childMenu.innerHTML = childItemHTML
			allchildItems = childMenu.children.tags("SPAN")
			for (ci = 0; ci < allchildItems.length; ci++) {
				childItemArray = eval(childMenuArray["item" + (ci + 1)])
				childItem = eval(childMenuArray.Name + "Item" + (ci + 1))
				childItem.url = childItemArray.url
				childItem.make = makeItem
				childItem.make()
			}
			childMenu.Parent = currItem
			childMenu.make(1)
			return childMenu
		}
		
		
		function makeNewWindow(theURL,winName,features) {
			if (isNav) {
				features += ",screenX=100,screenY=75"
			} else {
				features += ",left=100,top=75"
			}
			newWind = window.open(theURL,winName,features)
			if (newWind != null && newWind.opener == null) {
				newWind.opener = self
			}
		
		}
		
		
		function closeNewWind()	{
			if (newWind && !newWind.closed)	{
				newWind.close()
			}
		}
			
		var pLeft = 5;
		var pTop = 5;
		var navX;
		var navY;
		function init() {
			marker = eval("document.images.markerImg");
			if (isIE) {
				myParent = marker.offsetParent;
				while (myParent) {
					pLeft += myParent.offsetLeft - 1; //myParent.offsetLeft;
					pTop += myParent.offsetTop - 1; //myParent.offsetTop;
					myParent = myParent.offsetParent;
				}
			}
			navX = (isNav) ? marker.x : pLeft
			navY = (isNav) ? marker.y : pTop
			window.focus()
			Navs()
			if (isNav) { NSMenus() } else { IEMenus() }
		}
		
		//-->
		</SCRIPT>
		</HEAD>
		<BODY onKeyDown="javascript:keyDown();" onKeyUp="javascript:keyUp();" onload="init()">
		<SCRIPT LANGUAGE="JavaScript">
		// *******************************************************************************
		// This is the script for the start of the game.
		// *******************************************************************************
		
		<!-- Begin
		
		dir = "";
		// Global Variables
		var mines = [];
		var shown = [];
		var gridx, gridy, maxmines;
		gridx = window.prompt("Please enter a width.","8");
		gridxverify();
		
		function gridxaccept(){
		gridy = window.prompt("Please enter a height.","8");
		gridyverify();
		}
		
		function gridyaccept(){
		maxmines = window.prompt("Please enter the number of mines you want.","10");
		maxminesverify();
		}
		
		// Checking variables before applying them.
		function gridxverify(){
		if (gridx > 50){
		alert("That width is too big. Please enter a new width.");
		gridxreenter();
		}
		else if (gridx < 8){
		alert("That width is too small. Please enter a new width.");
		gridxreenter();
		}
		else gridxaccept();
		}
		
		function gridyverify(){
		if (gridy > 50){
		alert("That height is too big. Please enter a new height.");
		gridyreenter();
		}
		else if (gridy < 8){
		alert("That height is too small. Please enter a new height.");
		gridyreenter();
		}
		else gridyaccept();
		}
		
		function maxminesverify(){
		if (maxmines > 500){
		alert("That number is too big. Please enter a new number of mines.");
		maxminesreenter();
		}
		else if (maxmines < 10){
		alert("That number is too small. Please enter a new number of mines.");
		maxminesreenter();
		}
		else accepted();
		}
		// Functions for reentering key variables, if necessary.
		function gridxreenter(){
		gridx = window.prompt("Please enter a width.","8");
		gridxverify();
		}
		function gridyreenter(){
		gridy = window.prompt("Please enter a height.","8");
		gridyverify();
		}
		function maxminesreenter(){
		maxmines = window.prompt("Please enter the number of mines you want.","10");
		maxminesverify();
		}
		
		
		
		function accepted(){
		var squaresleft, flagsleft;
		var elapsedtime;
		var playing;
		var placeflag;
		var clicked;
		}
		
		// Measurements for different elements of the
		// Minesweeper board.
		var gridSq = gridx * 16;
		var grid8 = gridSq - 128;
		var grid16 = gridx - 8
		var grid32 = grid16 * 8
		var grid64 = grid16 * 16
		var topBarWidth = 8 + grid64;
		var menuBarWidth = 86 + grid64;
		var wideWidth = gridx * 16;
		var highHeight = gridy * 16;
		var cplLeft = 6 + grid32;
		var cplRight = 4 + grid32;
		var totalWidth = gridSq + 32;
		var tW6 = totalWidth - 6;
		var ww2 = wideWidth + 2;
		
		// Assigning names to number images
		num=new Array(10);
		
		for (var i=0;i<10;i++) {
		  num[i]=new Image()
		  num[i].src=i+".gif"
		  }
		
		function keyDown(e) {
		if(document.layers)
		placeflag = (e.modifiers & Event.CONTROL_MASK) > 0;
		else
		placeflag = window.event.ctrlKey;
		setStatus();
		}
		function keyUp(e) {
		placeflag = false;
		setStatus();
		}
		
		
		function newgame() {
		// reset state arrays. mines holds the position of each mine. shown keeps
		// track of the image shown at each grid location
		var y;
		for(y = 0; y < gridy; ++y)
		{
		mines[y] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
		shown[y] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		}
		
		// Place the mines, making sure positions are unique
		var m;
		for(m = 0; m < maxmines; ++m) {
		var x,y;
		do {
		x = Math.floor(Math.random() * gridx);
		y = Math.floor(Math.random() * gridy);
		} while(mines[y][x]);
		mines[y][x] = true;
		}
		
		// initialize game variables
		squaresleft = gridy * gridx;
		flagsleft = maxmines;
		elapsedtime = 0;
		playing = true;
		clicked = false
		placeflag = false;
		
		// insert the grid into the document
		buildgrid();
		
		// Set up keypress handlers
		if (document.layers)
		window.captureEvents(Event.KEYDOWN | Event.KEYUP);
		window.onKeyDown = keyDown;
		window.onKeyUp = keyUp;
		
		// start the clock
		setInterval("ticker()", 1000);
		}
		
		// clock tick handler
		function ticker() {
		if (playing) {
		if (clicked) {
		elapsedtime++;
		setStatus();
		   }
		  }
		}
		
		// Refreshing control panel
		function setStatus() {
		document.images.elapse3.src=num[elapsedtime-(Math.floor(elapsedtime/10))*10].src;
		document.images.elapse2.src=num[Math.floor((elapsedtime-(Math.floor(elapsedtime/100))*100)/10)].src;
		document.images.elapse1.src=num[Math.floor(elapsedtime/100)].src;
		document.images.flag3.src=num[flagsleft-(Math.floor(flagsleft/10))*10].src;
		document.images.flag2.src=num[Math.floor((flagsleft-(Math.floor(flagsleft/100))*100)/10)].src;
		document.images.flag1.src=num[Math.floor(flagsleft/100)].src;
		
		}
		
		// *******************************************************************************
		// This is the function to build the game's grid.
		// *******************************************************************************
		function buildgrid() {
		document.write("<!-- Window --><DIV align=center> "
		 +"<!-- Top Bar --> <table width="
		 + totalWidth
		 +" border=0 cells"
		 +"pacing=0 cellpadding=0> <tr bgcolor=#bbbbbb heigh"
		 +"t=1> <td width=1 bgcolor=#bbbbbb></td><td width"
		 +"=1 bgcolor=#bbbbbb></td> <td width=1 bgcolor=#bbb"
		 +"bbb></td><td width="
		 + tW6
		 +" bgcolor=#bbbbbb></td> <t"
		 +"d width=1 bgcolor=#bbbbbb></td> <td width=1 bgcol"
		 +"or=#bbbbbb></td> <td width=1 bgcolor=#000000></td"
		 +"></tr><tr height=1><td width=1 bgcolor=#bbbb"
		 +"bb></td><td width=1 bgcolor=#ffffff></td><td w"
		 +"idth=1 bgcolor=#ffffff></td><td bgcolor=#ffffff>"
		 +"</td><td width=1 bgcolor=#ffffff></td><td widt"
		 +"h=1 bgcolor=#888888></td><td width=1 bgcolor=#00"
		 +"0000></td></tr><tr height=1><td width=1 bgco"
		 +"lor=#bbbbbb></td><td width=1 bgcolor=#ffffff></t"
		 +"d><td width=1 bgcolor=#bbbbbb></td><td bgcolor"
		 +"=#bbbbbb></td><td width=1 bgcolor=#bbbbbb></td> "
		 +"<td width=1 bgcolor=#888888></td><td width=1 bg"
		 +"color=#000000></td></tr></table><!-- Title -->"
		 +"<table border=0 cellspacing=0 cellpadding=0><t"
		 +"r height=18><td width=1 bgcolor=#bbbbbb></td><"
		 +"td width=1 bgcolor=#ffffff></td><td width=1 bgco"
		 +"lor=#bbbbbb></td><td bgcolor=#000088><img src='t"
		 +"itle.gif'><img src='a.gif' height=1 width="
		 + topBarWidth
		 +" name="
		 +"'titleBarEmptySpace'></td><td><img src='buttons."
		 +"gif'></td><td width=1 bgcolor=#bbbbbb></td><td"
		 +" width=1 bgcolor=#888888></td><td width=1 bgcolo"
		 +"r=#000000></td></tr></table><!-- Menu Bar --> "
		 +"<table border=0 cellspacing=0 cellpadding=0> <tr"
		 +" height=20 bgcolor=#bbbbbb> <td width=1 bgcolor=#"
		 +"bbbbbb></td> <td>"
		 +"<img src='c.gif' width=1 height=20>"
		 +"<img src='a.gif' NAME='markerImg' width=35 height=18>"
		 +"<img src='a.gif' width=34 height=18>"
		 +"</td><td> <"
		 +"img src='a.gif' height=1 width="
		 + menuBarWidth
		 +" name='menuBarEmp"
		 +"tySpace'></td> <td width=1 bgcolor=#bbbbbb></td> "
		 +"<td width=1 bgcolor=#888888></td> <td width=1 bg"
		 +"color=#000000></td> </tr></table> <!-- Mine Fiel"
		 +"d --> <table border=0 cellspacing=0 cellpadding=0"
		 +"> <tr height=11 width=160> <td width=1 bgcolor=#"
		 +"bbbbbb></td> <td width=1 bgcolor=#ffffff></td> <"
		 +"td width=1 bgcolor=#bbbbbb></td> <td><img src='tl"
		 +".gif'></td> <td><img src='header.gif' width="
		 + ww2
		 +" height=11></td> <td><img src='tr.gif'></td><td><"
		 +"img src='right.gif' width=5 height=11></td> </tr>"
		 +"</table><table width="
		 + totalWidth
		 +" border=0 cellspacing=0 cellpadd"
		 +"ing=0> <tr height=33> <td width=1 bgcolor=#bbbbb"
		 +"b></td> <td width=1 bgcolor=#ffffff></td> <td wi"
		 +"dth=1 bgcolor=#bbbbbb></td> <td><img src='cplleft"
		 +".gif' height=33 width=11></td> <td> <!-- Control"
		 +" Panel --> <table width="
		 + ww2
		 +" border=0 cellspacing="
		 +"0 cellpadding=0><tr height=4 width="
		 + ww2
		 +"><td bgcolor=#bbbbbb"
		 +"></td></tr></table> <table width="
		 + ww2
		 +" border=0 cel"
		 +"lspacing=0 cellpadding=0><tr height=26><td "
		 +"width=5 bgcolor=#bbbbbb></td><td><!-- Mines Remai"
		 +"ning --> <table width=41 border=0 cellspacing=0 c"
		 +"ellpadding=0><tr bgcolor=#888888><td></td><td>"
		 +"</td><td></td> <td></td><td></td><td></td> <td><"
		 +"/td><td></td> <td width=1 bgcolor=#bbbbbb></td></"
		 +"tr> <tr bgcolor=#000000> <td width=1 bgcolor=#88"
		 +"8888></td> <td></td><td></td> <td></td><td></td>"
		 +"<td></td><td></td><td></td> <td width=1 bgcolor"
		 +"=#ffffff></td></tr> <tr bgcolor=#000000> <td wid"
		 +"th=1 bgcolor=#888888></td> <td width=1 bgcolor=#0"
		 +"00000></td> <td><img src='0.gif' name='flag1'></t"
		 +"d><td width=2></td><td><img src='1.gif' name='"
		 +"flag2'></td><td width=2></td><td><img src='0.g"
		 +"if' name='flag3'></td><td width=1></td> <td wid"
		 +"th=1 bgcolor=#ffffff></td></tr> <tr bgcolor=#0000"
		 +"00> <td width=1 bgcolor=#888888></td> <td></td><"
		 +"td></td> <td></td><td></td><td></td> <td></td><t"
		 +"d></td> <td width=1 bgcolor=#ffffff></td></tr> <"
		 +"tr bgcolor=#ffffff> <td width=1 bgcolor=#bbbbbb><"
		 +"/td> <td></td><td></td> <td></td><td></td><td></"
		 +"td> <td></td><td></td> <td></td></tr><"
		 +"tr bgcolor=#bbbbbb> <td width=1 bgcolor=#bbbbbb><"
		 +"/td> <td></td><td></td> <td></td><td></td><td></"
		 +"td> <td></td><td></td> <td></td></tr></table><!--"
		 +" End Mines Remaini"
		 +"ng --> </td> <td bgcolor=#bbbbbb><img height=1 "
		 +"src='a.gif' width=" + cplLeft + "name='cplLeft'>"
		 +"<td><img src='btnsmile.gif' name='condition' onmo"
		 +"usedown='document.images.condition.s"
		 +'rc="btnsmil2.gif"'
		 +";' onmouseu"
		 +"p='document.images.condition.s"
		 +'rc="btnsmile.gif";location.reload();'
		 +";'></td> <td width=4 bgcolor=#bbbbbb>"
		 +"<img height=1 src='a.gif'"
		 +" width=" + cplRight + ">"
		 +"</td> <td> <!-- Elapsed Time --> <table width=4"
		 +"1 border=0 cellspacing=0 cellpadding=0> <tr bgcol"
		 +"or=#888888> <td></td><td></td><td></td> <td></td"
		 +"><td></td><td></td><td></td><td></td> <td width"
		 +"=1 bgcolor=#bbbbbb></td></tr> <tr bgcolor=#000000"
		 +"> <td width=1 bgcolor=#888888></td> <td></td><td"
		 +"></td> <td></td><td></td><td></td> <td></td><td>"
		 +"</td> <td width=1 bgcolor=#ffffff></td></tr> <tr"
		 +" bgcolor=#000000> <td width=1 bgcolor=#888888></t"
		 +"d> <td width=1 bgcolor=#000000></td> <td><img sr"
		 +"c='0.gif' name='elapse1'></td> <td width=2></td> "
		 +"<td><img src='0.gif' name='elapse2'></td> <td wi"
		 +"dth=2></td> <td><img src='0.gif' name='elapse3'><"
		 +"/td> <td width=1></td> <td width=1 bgcolor=#ffff"
		 +"ff></td></tr> <tr bgcolor=#000000> <td width=1 b"
		 +"gcolor=#888888></td> <td></td><td></td> <td></td"
		 +"><td></td><td></td> <td></td><td></td> <td width"
		 +"=1 bgcolor=#ffffff></td></tr> <tr bgcolor=#ffffff"
		 +"> <td width=1 bgcolor=#bbbbbb></td> <td></td><td"
		 +"></td> <td></td><td></td><td></td> <td></td><td>"
		 +"</td> <td></td></tr> <"
		 +"tr bgcolor=#bbbbbb> <td width=1 bgcolor=#bbbbbb><"
		 +"/td> <td></td><td></td> <td></td><td></td><td></"
		 +"td> <td></td><td></td> <td></td></tr> "
		 +"</table> <!-- End Elapsed Time --> </td> <td "
		 +"width=7 bgcolor=#bbbbbb></td></tr></table><table "
		 +"width=" 
		 + ww2
		 +" border=0 cellspacing=0 cellpadding=0> "
		 +"<tr height=3><td bgcolor=#bbbbbb></td></tr></table"
		 +"> <!-- End Control Panel --> </td> <td><img src"
		 +"='cplright.gif' height=33 width=11></td> <td><img"
		 +" src='right.gif' height=33 width=5></td> </tr></t"
		 +"able><!-- Separator --> <table border=0 cells"
		 +"pacing=0 cellpadding=0> <tr height=11 width="
		 + totalWidth
		 +"> "
		 +"<td width=1 bgcolor=#bbbbbb></td> <td width=1 bg"
		 +"color=#ffffff></td> <td width=1 bgcolor=#bbbbbb><"
		 +"/td> <td><img src='ml.gif'></td><td><img src='"
		 +"separatr.gif' width="
		 + wideWidth
		 +" height=11></td><td><img"
		 +" src='mr.gif'></td><td><img src='right.gif' width"
		 +"=5></td></tr></table> <!-- Mine Field --> <table"
		 +" width="
		 + totalWidth
		 +" border=0 cellspacing=0 cellpadding=0> "
		 +"<tr height="
		 + highHeight
		 +"> <td width=1 bgcolor=#bbbbbb></td>"
		 +" <td width=1 bgcolor=#ffffff></td> <td width=1 b"
		 +"gcolor=#bbbbbb></td> <td><img src='fielside.gif' "
		 +"width=12 height="
		 + highHeight
		 +"></td> <td> <!-- Game Field -"
		 +"->");
		var s = "";
		var x, y;
		for(y = 0; y < gridy; ++y) {
		for(x = 0; x < gridx; ++x) {
		s = s + '<a href="javascript:gridclick(' + y + ',' + x +');">' +
		'<img src="' + dir + 'sqt0.gif" name="grd'+y+'_'+x+'" border=0></a>'
		}
		s = s + "<br>";
		}
		document.write(s);
		document.write('<!-- End Game Field --></td><td'
		 +' valign=right><img src="fielside.gif" width=12 heig'
		 +'ht='
		 + highHeight
		 +'></td> <td valign=right><img src="right.gif'
		 +'" width=5 height='
		 + highHeight
		 +'></td></tr></table><!-- En'
		 +'d Mine Field --><!-- Footer --><table width='
		 + totalWidth
		 +' border=0 cellspacing=0 cellpadding=0><tr heigh'
		 +'t=12> <td width=1 bgcolor=#bbbbbb></td> <td widt'
		 +'h=1 bgcolor=#ffffff></td> <td width=1 bgcolor=#bb'
		 +'bbbb></td> <td><img src="bl.gif"></td> <td><img '
		 +'src="footer.gif" width='
		 + wideWidth
		 +' height=12></td> <td><i'
		 +'mg src="br.gif"></td> <td><img src="right.gif" he'
		 +'ight=12></td></tr></table><!-- Bottom --> <ta'
		 +'ble width='
		 + totalWidth
		 +' border=0 cellspacing=0 cellpadding=0'
		 +'> <tr bgcolor=#bbbbbb height=1> <td width=1 bgco'
		 +'lor=#bbbbbb></td><td width=1 bgcolor=#ffffff></t'
		 +'d> <td width=1 bgcolor=#bbbbbb></td><td width='
		 + tW6
		 +' bgcolor=#bbbbbb></td><td width=1 bgcolor=#bbb'
		 +'bbb></td> <td width=1 bgcolor=#888888></td> <td '
		 +'width=1 bgcolor=#000000></td> </tr> <tr height=1'
		 +'> <td width=1 bgcolor=#bbbbbb></td> <td width=1 '
		 +'bgcolor=#888888></td> <td width=1 bgcolor=#888888'
		 +'></td> <td bgcolor=#888888></td> <td width=1 bgc'
		 +'olor=#888888></td> <td width=1 bgcolor=#888888></'
		 +'td> <td width=1 bgcolor=#000000></td> </tr> <tr'
		 +' height=1> <td width=1 bgcolor=#000000></td> <td'
		 +' width=1 bgcolor=#000000></td> <td width=1 bgcolo'
		 +'r=#000000></td> <td bgcolor=#000000></td> <td wi'
		 +'dth=1 bgcolor=#000000></td> <td width=1 bgcolor=#'
		 +'000000></td> <td width=1 bgcolor=#000000></td> <'
		 +'/tr></table> </div>');
		}
		
		
		// *******************************************************************************
		// These are functions that run during the game.
		// *******************************************************************************
		// Function to calculate the number of mines adjacent to a grid location
		function surrounding(y,x) {
		var count = 0;
		if (y > 0 && x > 0 && mines[y-1][x-1]) count++;
		if (y > 0 && mines[y-1][x]) count++;
		if (y > 0 && x < gridx-1 && mines[y-1][x+1]) count++;
		if (x > 0 && mines[y][x-1]) count++;
		if (x < gridx-1 && mines[y][x+1]) count++;
		if (y < gridy-1 && x > 0 && mines[y+1][x-1]) count++;
		if (y < gridy-1 && mines[y+1][x]) count++;
		if (y < gridy-1 && x < gridx-1 && mines[y+1][x+1]) count++;
		return count;
		}
		
		// Recursive function to 'roll back' the grid when user clicks on a tile
		// with no surrounding mines
		function rollback(y,x) {
		if (y >= 0 && y < gridy && x >=0 && x < gridx) {
		if (shown[y][x] != 3) {
		var c = surrounding(y,x);
		shown[y][x] = 3;
		squaresleft--;
		document.images["grd"+y+"_"+x].src = dir + "sq"+c+".gif";
		if (c == 0) {
		rollback(y-1,x-1);
		rollback(y-1,x);
		rollback(y-1,x+1);
		rollback(y,x-1);
		rollback(y,x+1);
		rollback(y+1,x-1);
		rollback(y+1,x);
		rollback(y+1,x+1);
				 }
			  }
		   }
		}
		
		// Function called when player steps on a mine. All mine locations are uncovered
		function dead() {
		var y, x;
		for(y = 0; y < gridy; ++y) {
		for(x = 0; x < gridx; ++x) {
		if (mines[y][x]) {
		if (shown[y][x] != 1) {
		document.images["grd"+y+"_"+x].src = dir + "mine.gif";
		   }
		}
		else if (shown[y][x] == 1) {
		document.images["grd"+y+"_"+x].src = dir + "nomine.gif";
			  }
		   }
		}
		document.images.condition.src = dir + "btndead.gif";
		playing = false;
		clicked = false;
		}
		
		// handler called whenever the grid is clicked
		function gridclick(y, x) {
		if (playing) {
		clicked = true;
		if (placeflag) {
		if (shown[y][x] < 3) {
		var s = shown[y][x];
		var change = true;
		if (s == 1) {
		flagsleft++;
		squaresleft++;
		}
		if (flagsleft == 0 && s == 0) {
		change = false;
		}
		else {
		if (s == 2) s = 0;
		else s++;
		if (s == 1) {
		flagsleft--;
		squaresleft--;
		   }
		}
		if (change) {
		shown[y][x] = s;
		document.images["grd"+y+"_"+x].src = dir + "sqt"+s+".gif";
		setStatus();
		}
		if (squaresleft == 0) {
		document.images.condition.src = dir + "btncool.gif";
		playing = false;
			  }
		   }
		}
		
		// check not flagged as a mine
		else if (shown[y][x] != 1) {
		if (mines[y][x]) {
		document.images["grd"+y+"_"+x].src = dir + "minered.gif";
		dead();
		}
		else  {
		rollback(y,x);
				 }
			  }
		   }
		}
		
		// Start the game
		newgame();
		// End -->
		</script>
		</BODY>
		</html>
		
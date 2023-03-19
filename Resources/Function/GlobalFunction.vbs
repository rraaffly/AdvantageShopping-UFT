Dim browserName, browserUrl

Dim isPath: isPath = Environment.Value("PROJECT_PATH")
Dim isPathObj: isPathObj = isPath + "\Object Repository\"
Dim isPathFunction: isPathFunction = isPath + "\Function\"
Dim isPathDataTable: isPathDataTable = isPath + "\Resources\DataTable\"

browserName = DataTable.Value("BROWSER_NAME", dtGlobalSheet)
browserUrl  = DataTable.Value("PROJECT_URL", dtGlobalSheet)


Sub doOpenBrowser(browserName, browserUrl)
	Call doCloseBrowser(browserName)
	SystemUtil.Run browserName, browserUrl, "", "", 3
End Sub

Sub doCloseBrowser(browserName)
	SystemUtil.CloseProcessByName browserName + ".exe"
End Sub

Sub doImportDataTable(ByVal fileName, ByVal sheetName)
	pathGlobalData = getDataTable("GlobalData")
	pathTestData = getDataTable(fileName)
	
	Call DataTable.ImportSheet(pathGlobalData, "GlobalData", dtGlobalSheet)
	Call DataTable.ImportSheet(pathTestData, sheetName, dtLocalSheet)
End Sub

Function getDataTable(ByVal fileName)
	Dim path: path = isPathDataTable + fileName + ".xlsx"
	Set FSO = CreateObject("Scripting.FileSystemObject")
	If Not FSO.FileExists(path) Then
		Reporter.ReportEvent micFail, "File Data Table Is Not Found. Please Check Your Path!", path
		Call ExitTest()
	End If
	getDataTable = path
End Function

Function doRunTest()
	If CInt(Environment("ActionIteration")) = CInt(DataTable.LocalSheet.GetRowCount()) Then '== 4
		If Trim(DataTable.Value("RUN", dtLocalSheet)) = "" Then
			MsgBox "Ngga Running"
			Call ExitActionIteration()
			Exit Function
		Else
			MsgBox "Running"
		End If
	End If
End Function

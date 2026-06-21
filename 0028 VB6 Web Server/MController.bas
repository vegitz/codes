Attribute VB_Name = "MController"
Option Explicit


Function HandleHttpRequest(ByVal raw_request As String) As String
    Dim request                             As CHttpRequest
    
    ' decode the web request
    Set request = DecodeRequest(raw_request)
    
    ' for now we just the serialized version of this request object
    HandleHttpRequest = request.repr
    
End Function



Private Function DecodeRequest(ByVal raw_request As String) As CHttpRequest
    Dim lines()                             As String
    Dim lineindex                           As Integer
    Dim parts()                             As String
    Dim partindex                           As Integer
    Dim indexpeg                            As Integer
    
    
    Dim temp()                              As String
    Dim metaKey                             As String
    Dim metaValue                           As String
    
    
    
    Dim bodyLine                            As String
    Dim bodyParts()                         As String
    
    
    Dim request                             As New CHttpRequest
    
    
    
    lines = Split(raw_request, vbCrLf)
    ' 1st line contains METHOD, PATH?PARAMS & PROTOCOL
    parts = Split(lines(0), Space(1))
    request.Method = Trim(parts(0))
    
    ' separate params from path
    temp = Split(parts(1), "?")
    request.Path = Trim(temp(0))
    
    If UBound(temp) > 0 Then
        ' is there anything that follows the Path?
        Set request.params = ParamsToDict(temp(1))
    End If
    
    
    temp = Split(parts(2), "/")
    request.Protocol = Trim(temp(0))
    request.ProtocolVersion = Trim(temp(1))
    
    
    ' 2nd line contains only the HOST
    parts = Split(lines(1), ":")
    request.Host = Trim(parts(1))
    
    ' track last line, in case the method is POST
    indexpeg = 0
    
    ' the rest, we'll just store as "meta"
    For lineindex = 2 To UBound(lines)
        indexpeg = lineindex
        If Trim(lines(lineindex)) = "" Then
            Exit For
        Else
            temp = Split(lines(lineindex), ":")
            metaKey = Trim(temp(0))
            metaValue = Trim(temp(1))
            request.Meta.Item(metaKey) = metaValue
        End If
    Next
    
    ' if this is a POST method, the next lines will be the body
    For lineindex = indexpeg To UBound(lines)
        bodyLine = Trim(lines(lineindex))
        If bodyLine = "" Then
            DoEvents
        Else
            Set request.PostBody = ParamsToDict(bodyLine)
        End If
        
        indexpeg = indexpeg + 1
    Next
    
    Set DecodeRequest = request
End Function

Private Function ParamsToDict(ByVal params As String, _
Optional ByVal separator As String = "&") As Scripting.Dictionary
    Dim dctParams                           As New Scripting.Dictionary
    
    Dim paramList()                         As String
    Dim paramIndex                          As Integer
    Dim paramKvPair()                       As String
    Dim paramKey                            As String
    Dim paramValue                          As String
    
    
    paramList = Split(params, "&")
    For paramIndex = LBound(paramList) To UBound(paramList)
        If InStr(1, paramList(paramIndex), "=") Then
            ' valid url param
            paramKvPair = Split(paramList(paramIndex), "=", 2)
            paramKey = Trim(paramKvPair(0))
            paramValue = Trim(paramKvPair(1))
        Else
            ' empty param?
            paramKey = Trim(paramList(paramIndex))
            paramValue = ""
        End If
        
        dctParams.Item(paramKey) = paramValue
    Next
    
    Set ParamsToDict = dctParams
End Function


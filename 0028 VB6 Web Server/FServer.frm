VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form FServer 
   Caption         =   "Simple Web Server in VB6"
   ClientHeight    =   4290
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   8310
   LinkTopic       =   "Form1"
   ScaleHeight     =   4290
   ScaleWidth      =   8310
   StartUpPosition =   3  'Windows Default
   Begin MSWinsockLib.Winsock sckServer 
      Index           =   0
      Left            =   600
      Top             =   600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      LocalPort       =   80
   End
End
Attribute VB_Name = "FServer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private mlngSocketIndex                     As Long


Private Sub Form_Load()
    ListenForConnection
End Sub

Private Sub ListenForConnection(Optional ByVal portnum As Integer = 80)
    With Me.sckServer(0)
        ' ensure the connection is closed before we (re)open and listen
        If .State <> sckClosed Then .Close
        
        ' set the port where we'll listen to
        .LocalPort = portnum
        ' start waiting for connection
        .Listen
    End With
    
    mlngSocketIndex = 0
End Sub

Private Sub sckServer_Close(Index As Integer)
    Me.sckServer(Index).Close
End Sub

Private Sub sckServer_ConnectionRequest(Index As Integer, ByVal requestID As Long)
    'accept a client that wants to connec to our server
    
    
    If Index = 0 Then
        mlngSocketIndex = mlngSocketIndex + 1
        
        Load Me.sckServer(mlngSocketIndex)
        
        Debug.Print Now, "Accepting " & requestID & " on socket " & mlngSocketIndex
        With Me.sckServer(mlngSocketIndex)
            .Accept requestID
        End With
    End If
End Sub

Private Sub sckServer_DataArrival(Index As Integer, ByVal bytesTotal As Long)
    Dim arrstrData()                        As Byte
    Dim strPlainText                        As String
    Dim response                            As String
    
    
    Me.sckServer(Index).GetData arrstrData, vbByte

    strPlainText = StrConv(arrstrData, vbUnicode)
    Debug.Print vbCrLf & "BEGIN: Data Arrived"
    Debug.Print strPlainText
    Debug.Print "END: Data Arrived" & vbCrLf
    
    response = MController.HandleHttpRequest(strPlainText)
    Me.sckServer(Index).SendData response
End Sub

Private Sub sckServer_Error(Index As Integer, ByVal Number As Integer, _
Description As String, ByVal Scode As Long, ByVal Source As String, _
ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
    Debug.Print Now, Source, Description
End Sub

Private Sub sckServer_SendComplete(Index As Integer)
    Me.sckServer(Index).Close
End Sub

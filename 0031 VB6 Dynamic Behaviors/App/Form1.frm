VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Search"
   ClientHeight    =   5295
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   7050
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5295
   ScaleWidth      =   7050
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox lstResult 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Consolas"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   240
      TabIndex        =   2
      Top             =   3480
      Width           =   6615
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search!"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   2040
      TabIndex        =   1
      Top             =   2640
      Width           =   2775
   End
   Begin VB.TextBox txtSearchTerm 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Consolas"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   1920
      Width           =   6255
   End
   Begin VB.Frame fraSelEngine 
      Caption         =   " Search Engine "
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   240
      TabIndex        =   5
      Top             =   240
      Width           =   6495
      Begin VB.OptionButton optGing 
         Caption         =   "Ging"
         BeginProperty Font 
            Name            =   "Consolas"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   3720
         TabIndex        =   4
         Top             =   600
         Width           =   2175
      End
      Begin VB.OptionButton optBoogle 
         Caption         =   "Boogle"
         BeginProperty Font 
            Name            =   "Consolas"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   600
         TabIndex        =   3
         Top             =   600
         Value           =   -1  'True
         Width           =   2175
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' https://coffeewithdennis.com/blog/
Option Explicit

Private mstrEngineClass                     As String
Private mstrSearchMethod                    As String

Private Sub SetEngine(ByVal EngineClass As String, _
ByVal SearchMethod As String)
    mstrEngineClass = EngineClass
    mstrSearchMethod = SearchMethod
End Sub

Private Sub Form_Load()
    ' set default search engine
    SetEngine "SearchEngines.Boogle", "search"
    ' NOTE: These parameters can be from an INI file
    ' to make this app fully dynamic & configurable
End Sub

Private Sub optBoogle_Click()
    SetEngine "SearchEngines.Boogle", "search"
End Sub

Private Sub optGing_Click()
    SetEngine "SearchEngines.Ging", "do_search"
End Sub

Private Sub cmdSearch_Click()
    Dim objEngine                           As Object
    Dim colResult                           As Collection
    Dim varItem                             As Variant
    
    
    ' instantiate the search engine dynamically
    Set objEngine = CreateObject(mstrEngineClass)
    
    ' call the method and get result
    Set colResult = CallByName(objEngine, mstrSearchMethod, _
        VbMethod, Me.txtSearchTerm.Text)
    
    ' display result
    Me.lstResult.Clear
    For Each varItem In colResult
        Me.lstResult.AddItem (varItem)
    Next
End Sub



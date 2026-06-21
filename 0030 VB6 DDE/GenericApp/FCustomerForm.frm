VERSION 5.00
Begin VB.Form FCustomerForm 
   Caption         =   "Get Customer"
   ClientHeight    =   3090
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   9270
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   9270
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdRolodex 
      Caption         =   "Open Rolodex"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   360
      TabIndex        =   1
      Top             =   1560
      Width           =   5535
   End
   Begin VB.TextBox txtCustomerName 
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
      Top             =   480
      Width           =   8775
   End
End
Attribute VB_Name = "FCustomerForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdRolodex_Click()
    Shell "..\rolodex\rolodexapp.exe", vbNormalFocus
    
    With Me.txtCustomerName
        .LinkTopic = "rolodexapp|rolodexform"
        .LinkItem = "selectedentry"
        
        .LinkMode = vbLinkNone
        .LinkMode = vbLinkAutomatic
    End With
End Sub

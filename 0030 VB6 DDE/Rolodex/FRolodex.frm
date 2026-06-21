VERSION 5.00
Begin VB.Form FRolodex 
   Caption         =   "Rolodex"
   ClientHeight    =   5505
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   5910
   LinkMode        =   1  'Source
   LinkTopic       =   "RolodexForm"
   ScaleHeight     =   5505
   ScaleWidth      =   5910
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox AddressBook 
      BeginProperty Font 
         Name            =   "Consolas"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3885
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   4455
   End
   Begin VB.TextBox SelectedEntry 
      BackColor       =   &H00C0FFFF&
      BeginProperty Font 
         Name            =   "Consolas"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   360
      Locked          =   -1  'True
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   120
      Width           =   4575
   End
End
Attribute VB_Name = "FRolodex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub AddressBook_Click()
    With Me.AddressBook
        Me.SelectedEntry.Text = .List(.ListIndex)
    End With
End Sub

Private Sub Form_Load()
    create_addressbook
End Sub

Private Sub create_addressbook()

    With Me.AddressBook
        .Clear
        .AddItem "John Lenox - Liversea, Ocean Drive"
        .AddItem "Paul Corny - Corned Beef, Canned Drive"
        .AddItem "George Winston - Marlboro Country, Morris Drive"
        .AddItem "Ringo Sun - Galaxy Road, Milky Drive"
        
        .ListIndex = 0
    End With
End Sub

Private Sub Form_Resize()
    If Me.WindowState = 1 Then Exit Sub
    
    With Me.SelectedEntry
        .Move 0, 0, Me.ScaleWidth
        Me.AddressBook.Move 0, .Top + .Height, Me.ScaleWidth, Me.ScaleHeight - .Height
    End With
End Sub

Private Sub SelectedEntry_GotFocus()
    Me.AddressBook.SetFocus
End Sub

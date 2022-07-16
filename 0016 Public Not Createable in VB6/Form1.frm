VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3120
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6960
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   6960
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'
' name          : Project1.Form1
' module        : Form
'
' This is a client app using the Acme library
'

' define a module-level browser object
Private browser                 As New Acme.WebBrowser

Private Sub Form_Load()
    ' test the default engine
    search "dog", Nothing
    
    ' test our custom engine
    search "dog", New CustomSearchEngine
    
    End
End Sub

Private Sub search(ByVal text As String, ByVal engine As iSearchEngine)
    '
    ' wrapper function to perform the search
    ' and print the results
    '
    If Not (engine Is Nothing) Then
        ' if an engine was provided, use it
        Set browser.search_engine = engine
    End If
    
    ' print header
    Debug.Print ""
    Debug.Print String(40, "=")
    Debug.Print "Query String: " & text
    Debug.Print "Search Engine: " & TypeName(browser.search_engine)
    Debug.Print ""
    
    ' print the result
    Debug.Print "Search Result(s):"
    Debug.Print browser.search(text)
    
    ' print footer
    Debug.Print String(40, "-")
End Sub


VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   2865
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   7395
   LinkTopic       =   "Form1"
   ScaleHeight     =   2865
   ScaleWidth      =   7395
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Option Explicit

Private Sub Form_Load()
    message = "this is a secret message"
    key = "youcanuseaverylongpassphrasewithorwithoutnumbers"
    
    Debug.Print "Original:", message
    
    encrypted = encrypt(message, key)
    Debug.Print "Encrypted:", encrypted
    
    decrypted = decrypt(encrypted, key)
    Debug.Print "Decrypted:", decrypted
End Sub






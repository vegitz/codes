Attribute VB_Name = "MCryptModule"
'
'===============================================================
'
' __module__        = MCryptModule.BAS
' __language__      = Visual Basci 6.0
' __author__        = Dennis C. Meneses
' __date__          = July 2, 2022
' __site__          = https://coffeewithdennis.com/blog/
' __git__           = https://github.com/vegitz/codes
'
'---------------------------------------------------------------
'
' !!! --- DO NOT USE IN PRODUCTION ENVIRONMENT --- !!!
'
' This is mostly intended for demo, but can also be used on
' personal projects and when security is not required.
'
' The routines are pure VB6 and no external libraries are  needed
' to make them work.
' To make it easier, the functions are all inside this basic module
' so you can just add this to any VB6 project and use it simply.
'
'---------------------------------------------------------------
'


Function encrypt(ByVal plain_text As String, ByVal key As String) As String
    '
    ' This function converts plain text to something unintelligible
    ' with the intent of making known the content hard.
    '
    
    ' store the key length since we'll use it determine the index
    ' and loop back to base index when it reaches the last one
    '
    key_length = Len(key)
    
    '
    ' reserve a location for storing encrypted values
    '
    ReDim result(Len(plain_text))
    
    '
    ' iterate over the plain text and also the key
    '
    For plaintext_index = 1 To Len(plain_text)
        ' get one character at a time from the plain text
        plain_char = Mid(plain_text, plaintext_index, 1)
        ' get the ascii code of that character
        plain_code = Asc(plain_char)
        
        ' determin the index mathematically (which is better than doing IF..THEN
        key_index = CInt((plaintext_index - 1) Mod key_length) + 1
        ' get the key at that location
        key_char = Mid(key, key_index, 1)
        ' convert this key character to ascii code
        key_code = Asc(key_char)
        
        ' transform the plain character to something else (by performing XOR operation)
        secret_code = plain_code Xor key_code
        ' convert to HEX to make the characters printable
        secret_char = byte2hex(secret_code)
        
        ' append the hex value to our buffer
        result(plaintext_index) = secret_char
    Next
    
    ' return the array as string by combining them
    encrypt = Join(result, "")
End Function


Function decrypt(ByVal encrypted_text As String, ByVal key As String) As String
    '
    ' this reverse the encrypt-ion process to bring back plain text
    '
    
    ' get the length of key for determining index with loopback
    key_length = Len(key)
    
    ' since we stored one character as two-characters, we'll only need half its width
    half_length = Len(encrypted_text) / 2
    
    ' reserve a buffer to hold the un-hexed value
    ReDim buffer(half_length - 1)
    
    ' initialize the buffer index which we'll increment inside the loop
    buffer_index = -1
    
    ' iterate over the encrypted (double-char) value
    ' note that "step 2" directive which means it'll skip 2 chars instead of 1
    For enc_index = 1 To Len(encrypted_text) Step 2
        ' get 2 characters at a time (to get the hex value)
        enc_char = Mid(encrypted_text, enc_index, 2)
        ' convert this hex back to regular ascii code
        enc_code = hex2byte(enc_char)
        
        ' increment the index for our buffer
        buffer_index = buffer_index + 1
        
        ' store the ascii value to our buffer
        buffer(buffer_index) = enc_code
    Next
    
    
    ' create another buffer for the decrypted result
    ReDim result(UBound(buffer))
    
    ' iterate over the un-hexed values
    For buffer_index = LBound(buffer) To UBound(buffer)
        ' get one ascii code at a time
        secret_code = buffer(buffer_index)
        
        ' determine the corresponding key index (location)
        key_index = CInt((buffer_index) Mod key_length) + 1
        
        ' get the key character
        key_char = Mid(key, key_index, 1)
        
        ' conver the character to ascii
        key_code = Asc(key_char)
        
        ' decrypt the value (using XOR)
        plain_code = secret_code Xor key_code
        
        ' convert the ascii code to character
        plain_char = Chr(plain_code)
        
        ' store the decrypted character in our results buffer
        result(buffer_index) = plain_char
    Next
    
    ' combine the buffer index to string
    decrypt = Join(result, "")
End Function


Function byte2hex(ByVal code As Byte) As String
    '
    ' converts a byte value to hex representation so we can produce
    ' consistent-width value (by padding zero)
    '
    byte2hex = leftpad(Hex(code), "0", 2)
End Function

Function hex2byte(ByVal code As String) As Byte
    '
    ' this one converts the hex code back to ascii (or byte)
    '
    hex2byte = CDec("&H" & code)
End Function



Function leftpad(ByVal value As String, ByVal padchar As String, ByVal totalwidth As Integer) As String
    '
    ' we use this custom function to pad zeroes and you might ask, why not use FORMAT?
    ' well, FORMAT only works with numbers, so if the value is hex "B", then that won't work
    '
    leftpad = Right(String(totalwidth, padchar) & value, totalwidth)
End Function

Function rightpad(ByVal value As String, ByVal padchar As String, ByVal totalwidth As Integer) As String
    '
    ' same as the left but places the zeroes on the right of the value
    '
    rightpad = Left(value & String(totalwidth, padchar), totalwidth)
End Function


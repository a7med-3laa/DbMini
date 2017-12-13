INCLUDE Irvine32.inc
.data
str1 byte  "ahmedFile.txt", 0
str2 byte  "data gwa file", 0
fileHandle handle ?
BUFFER_SIZE = 1000
buffer byte 101 dup(0)


.code


makeFile proc
mov edx, offset str1
INVOKE CreateFile,
edx, GENERIC_WRITE, DO_NOT_SHARE, NULL,
CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax
mov eax, fileHandle
mov edx, OFFSET str2
mov ecx, sizeof str2
call WriteToFile
mov eax, fileHandle
INVOKE CloseHandle, eax
ret
makefile endp

AppendTxtFile proc
mov edx, offset str1
INVOKE CreateFile,
edx, GENERIC_READ, DO_NOT_SHARE, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax
ret
AppendTxtFile endp

readFile2 proc str12 : PTR BYTE
mov edx, offset str1
INVOKE CreateFile,
edx, GENERIC_READ, DO_NOT_SHARE, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax
mov edx, str12
mov ecx, 100
call ReadFromFile

mov buffer[eax], 0
mov ebx, eax
mov eax, offset buffer
mov eax, fileHandle
INVOKE CloseHandle, eax
mov eax, ebx
ret
readFile2 endP

enroll2 proc ID : ptr Byte, Namee : ptr Byte, IDSize : Dword, NameSize : Dword, buf: ptr Byte
cld
mov esi,  ID
mov edi, offset buffer
mov ecx, IDSize
rep movsb

mov al, ','
mov [edi], al
inc edi

mov esi, Namee
mov ecx, NameSize

rep movsb
mov eax,IDSize
add eax, NameSize
add eax,1
mov esi ,offset buffer
mov edi , buf
mov ecx,eax
rep movsb



ret
enroll2 endP



DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
mov eax, 1; Return true to caller. 
ret 
DllMain ENDP
END DllMain

END main
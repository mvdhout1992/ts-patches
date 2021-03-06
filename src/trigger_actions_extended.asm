%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern UsedSpawnsArray

sstring str_Hard, "Difficulty: Hard"
sstring str_Medium, "Difficulty: Medium"
sstring str_Easy, "Difficulty: Easy"


; 0x40 = first parameter, 0x24 = second parameter, 0x28, third parameter, 0x2C = fourth parameter, 0x30 = fifth parameter
; the trigger action type should be 0 (as set map INI) for the extended triggers added, determines how the rest of the
; INI line is read for the rest of the trigger
; [Actions] 01000000=1,7,1,01000005,0,0,0,0,A
; [Actions] TRIGGER_ACTION_ID=AMOUNT_OF_ACTIONS,TRIGGER_ACTION_ID,TRIGGER_ACTION_TYPE,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,WAYPOINT_LETTER(?)
@LJMP 0x006198C7, _Trigger_Action_Extend_Change_House

_Trigger_Action_Extend_Change_House:
    mov eax, ecx
    call Spawn_Index50_To_House_Pointer

    cmp eax, -1 ; no house associated with spawn, skip changing house
    jz .Ret_Function

    cmp eax, 0
    jnz .Ret ; HouseClass pointer associated with spawn location, return this pointer

    ; normal code
    call 0x004C4730 ; House_Pointer_From_HouseType_Index

.Ret:
    jmp 0x006198CC

.Ret_Function:
    mov al, 1
    jmp 0x006198E3


; input eax = Spawn index with value 50 for Spawn1, 51 for Spawn2 etc
; output HouseClass pointer associated with that spawn, 0 if not a valid index or -1 if no HouseClass is associated with spawn location
Spawn_Index50_To_House_Pointer:
    push edi
    push edx

    cmp eax, 50
    jl  .Return_Zero
    cmp eax, 60
    jg  .Return_Zero

    sub eax, 50

    mov eax, [UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Ret

    mov edi, [HouseClassArray_Vector]
    mov eax, [edi+eax*4]

    jmp .Ret

.Return_Zero:
    mov eax, 0

.Ret:
    pop edx
    pop edi
    retn

; New actions
    
hack 0x0061913B ; Extend trigger action jump table
    cmp edx, 105
    jz .Give_Credits_Action
    cmp edx, 106
    jz .Enable_ShortGame_Action
    cmp edx, 107
    jz .Disable_ShortGame_Action
    cmp edx, 108
    jz .Print_Difficulty_Action
	cmp edx, 109
	jz .Blow_Up_House_Action
    
    cmp edx, 68h
    ja 0x0061A9C5 ; default
    jmp 0x00619141 ; use original switch jump table
    
; New actions below

; ********************
; *** Give credits ***
; ********************
.Give_Credits_Action:
    mov eax, [esi+40h] ; first parameter
    
    cmp eax, 50
    jl .Get_House_Pointer ; give credits to a regular house instead of a SpawnX house
    
    call Spawn_Index50_To_House_Pointer
    
    cmp eax, -1 ; no house associated with spawn location
    jz .Out

    cmp eax, 0
    jnz .Give_Credits
    
.Get_House_Pointer:    
    call 0x004C4730 ; House_Pointer_From_HouseType_Index
    
.Give_Credits:
    ; At this point we should have the house pointer in EAX
    mov ebx, [esi+24h] ; second parameter, number of credits to give
    mov ecx, [eax+1A4h] ; move current number of credits to ecx
    add ecx, ebx
    mov [eax+1A4h], ecx
    
.Out:
    jmp 0x0061A9C5 ; default
    
; **********************************
; *** Enable / disable ShortGame ***
; **********************************
.Enable_ShortGame_Action:
    mov byte [ShortGame], 1
    jmp 0x0061A9C5 ; default

.Disable_ShortGame_Action:
    mov byte [ShortGame], 0
    jmp 0x0061A9C5

; ******************************
; *** Print Difficulty Level ***
; ******************************
    
    ; arg: pointer to message
%macro Print_Message 1
    ; Calculate message duration
    mov eax, [Rules]
    fld qword [eax+0C68h]   ; Message duration in minutes
    fmul qword [0x006CB1B8] ; Frames Per Minute
    call Get_Message_Delay_Or_Duration ; Float to int

    ; Push arguments
    push eax                ; Message delay/duration
    push 4046h              ; Very likely TextPrintType
    mov ecx, MessageListClass_this
    push 4
    lea edx, [%1]
    push edx
    push 0
    push 0
    call MessageListClass__Add_Message
%endmacro
   
.Print_Difficulty_Action:
    mov eax, dword [SelectedDifficulty]

    cmp eax, 2
    je .Print_Hard
    
    cmp eax, 1
    je .Print_Medium
    
    Print_Message str_Easy
    jmp 0x0061A9C5
    
.Print_Medium:
    Print_Message str_Medium
    jmp 0x0061A9C5
    
.Print_Hard:
    Print_Message str_Hard
    jmp 0x0061A9C5
    
; ******************************
; ***      Blow Up House     ***
; ******************************

.Blow_Up_House_Action:
    mov eax, [esi+40h] ; first parameter
    
    cmp eax, 50
    jl .Get_House_Pointer_Blow_Up_House ; not a spawn house, find the regular house
    
    call Spawn_Index50_To_House_Pointer
    
    cmp eax, -1 ; no house associated with spawn location
    jz .Out2

    cmp eax, 0
    jnz .Blow_Up
    
.Get_House_Pointer_Blow_Up_House:    
    call 0x004C4730 ; House_Pointer_From_HouseType_Index
    
.Blow_Up:
    ; We should have the house pointer in EAX
	push eax
	mov ecx, eax
	call HouseClass__Blowup_All
	pop ecx
    call HouseClass__MPlayer_Defeated

.Out2:
    jmp 0x0061A9C5 ; default

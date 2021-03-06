; ..\LIB\PENWIN32.LIB PROTOTYPES
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

AddInksetInterval PROTO :DWORD,:DWORD
AddPenDataHRC PROTO :DWORD,:DWORD
AddPenInputHRC PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
AddPointsPenData PROTO :DWORD,:DWORD,:DWORD,:DWORD
AddWordsHWL PROTO :DWORD,:DWORD,:DWORD
BoundingRectFromPoints PROTO :DWORD,:DWORD,:DWORD
CharacterToSymbol PROTO :DWORD,:DWORD,:DWORD
CompressPenData PROTO :DWORD,:DWORD,:DWORD
ConfigHREC PROTO :DWORD,:DWORD,:DWORD,:DWORD
CorrectWriting PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CreateCompatibleHRC PROTO :DWORD,:DWORD
CreateHWL PROTO :DWORD,:DWORD,:DWORD,:DWORD
CreateInkset PROTO :DWORD
CreateInksetHRCRESULT PROTO :DWORD,:DWORD,:DWORD
CreatePenDataEx PROTO :DWORD,:DWORD,:DWORD,:DWORD
CreatePenDataHRC PROTO :DWORD
CreatePenDataRegion PROTO :DWORD,:DWORD
DPtoTP PROTO :DWORD,:DWORD
DestroyHRC PROTO :DWORD
DestroyHRCRESULT PROTO :DWORD
DestroyHWL PROTO :DWORD
DestroyInkset PROTO :DWORD
DestroyPenData PROTO :DWORD
DoDefaultPenInput PROTO :DWORD,:DWORD
DrawPenDataEx PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DuplicatePenData PROTO :DWORD,:DWORD
EnableGestureSetHRC PROTO :DWORD,:DWORD,:DWORD
EnableSystemDictionaryHRC PROTO :DWORD,:DWORD
EndPenInputHRC PROTO :DWORD
ExtractPenDataPoints PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ExtractPenDataStrokes PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetAlphabetHRC PROTO :DWORD,:DWORD,:DWORD
GetAlphabetPriorityHRC PROTO :DWORD,:DWORD,:DWORD
GetAlternateWordsHRCRESULT PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetBoxMappingHRCRESULT PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetBoxResultsHRC PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetGuideHRC PROTO :DWORD,:DWORD,:DWORD
GetHRECFromHRC PROTO :DWORD
GetHotspotsHRCRESULT PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetInksetInterval PROTO :DWORD,:DWORD,:DWORD
GetInksetIntervalCount PROTO :DWORD
GetInternationalHRC PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetMaxResultsHRC PROTO :DWORD
GetPenAppFlags PROTO
GetPenAsyncState PROTO :DWORD
GetPenDataAttributes PROTO :DWORD,:DWORD,:DWORD
GetPenDataInfo PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetPenInput PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetPenMiscInfo PROTO :DWORD,:DWORD
GetPointsFromPenData PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetResultsHRC PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetStrokeAttributes PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetStrokeTableAttributes PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetSymbolCountHRCRESULT PROTO :DWORD
GetSymbolsHRCRESULT PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetVersionPenWin PROTO
GetWordlistCoercionHRC PROTO :DWORD
GetWordlistHRC PROTO :DWORD,:DWORD
HitTestPenData PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
InsertPenData PROTO :DWORD,:DWORD,:DWORD
InsertPenDataPoints PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
InsertPenDataStroke PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
InstallRecognizer PROTO :DWORD
IsPenEvent PROTO :DWORD,:DWORD
MetricScalePenData PROTO :DWORD,:DWORD
OffsetPenData PROTO :DWORD,:DWORD,:DWORD
PeekPenInput PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
PenDataFromBuffer PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
PenDataToBuffer PROTO :DWORD,:DWORD,:DWORD,:DWORD
ProcessHRC PROTO :DWORD,:DWORD
ReadHWL PROTO :DWORD,:DWORD
RedisplayPenData PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
RemovePenDataStrokes PROTO :DWORD,:DWORD,:DWORD
ResizePenData PROTO :DWORD,:DWORD
SetAlphabetHRC PROTO :DWORD,:DWORD,:DWORD
SetAlphabetPriorityHRC PROTO :DWORD,:DWORD,:DWORD
SetBoxAlphabetHRC PROTO :DWORD,:DWORD,:DWORD
SetGuideHRC PROTO :DWORD,:DWORD,:DWORD
SetInternationalHRC PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetMaxResultsHRC PROTO :DWORD,:DWORD
SetPenAppFlags PROTO :DWORD,:DWORD
SetPenMiscInfo PROTO :DWORD,:DWORD
SetResultsHookHREC PROTO :DWORD,:DWORD
SetStrokeAttributes PROTO :DWORD,:DWORD,:DWORD,:DWORD
SetStrokeTableAttributes PROTO :DWORD,:DWORD,:DWORD,:DWORD
SetWordlistCoercionHRC PROTO :DWORD,:DWORD
SetWordlistHRC PROTO :DWORD,:DWORD
StartInking PROTO :DWORD,:DWORD,:DWORD
StartPenInput PROTO :DWORD,:DWORD,:DWORD,:DWORD
StopInking PROTO :DWORD
StopPenInput PROTO :DWORD,:DWORD,:DWORD
SymbolToCharacter PROTO :DWORD,:DWORD,:DWORD,:DWORD
TPtoDP PROTO :DWORD,:DWORD
TargetPoints PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
TrainHREC PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
TrimPenData PROTO :DWORD,:DWORD,:DWORD
UnhookResultsHookHREC PROTO :DWORD,:DWORD
UninstallRecognizer PROTO :DWORD
WriteHWL PROTO :DWORD,:DWORD


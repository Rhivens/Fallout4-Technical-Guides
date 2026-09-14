unit UserScript;

var
  Results: TStringList;
  LostXLRL, LostXLCN: Integer;

function GetLinkedLocalFormID(e: IInterface; const Path: string): Cardinal;
var
  el, linked: IInterface;
begin
  Result := 0;

  if not Assigned(e) then
    Exit;

  el := ElementByPath(e, Path);
  if not Assigned(el) then
    Exit;

  linked := LinksTo(el);

  if Assigned(linked) then
    Result := FormID(linked) and $00FFFFFF;
end;

function GetLinkedValue(e: IInterface; const Path: string): string;
var
  el: IInterface;
begin
  Result := '';

  if not Assigned(e) then
    Exit;

  el := ElementByPath(e, Path);

  if Assigned(el) then
    Result := GetEditValue(el);
end;

function Initialize: Integer;
begin
  Results := TStringList.Create;

  LostXLRL := 0;
  LostXLCN := 0;

  AddMessage('');
  AddMessage('======================================================');
  AddMessage(' Pervert Location Loss Scanner v6');
  AddMessage(' Compare XLRL / XLCN by LocalFormID');
  AddMessage(' Read-only: no plugin is modified');
  AddMessage('======================================================');
  AddMessage('');

  Result := 0;
end;

procedure CheckLocationField(
  e, Winner: IInterface;
  const Path, LabelName: string;
  var Counter: Integer
);
var
  SourceID, WinnerID: Cardinal;
  SourceValue, WinnerValue: string;
  Sig, EDID, FullName, SourcePlugin, WinnerPlugin: string;
begin
  SourceID := GetLinkedLocalFormID(e, Path);

  { The source record does not define this location field. }
  if SourceID = 0 then
    Exit;

  WinnerID := GetLinkedLocalFormID(Winner, Path);

  { Same LocalFormID: no functional conflict detected. }
  if SourceID = WinnerID then
    Exit;

  Sig := Signature(e);
  EDID := GetElementEditValues(e, 'EDID');
  FullName := GetElementEditValues(e, 'FULL');

  SourceValue := GetLinkedValue(e, Path);
  WinnerValue := GetLinkedValue(Winner, Path);

  SourcePlugin := GetFileName(GetFile(e));
  WinnerPlugin := GetFileName(GetFile(Winner));

  Results.Add(
    '[' + LabelName + ' LOST] | ' +
    Sig + ' | ' +
    IntToHex(FormID(e), 8) + ' | ' +
    EDID + ' | ' +
    FullName
  );

  Results.Add(
    '    Source  : ' + SourceValue +
    ' | LocalFormID=' + IntToHex(SourceID, 8)
  );

  if WinnerID <> 0 then
    Results.Add(
      '    Winner : ' + WinnerValue +
      ' | LocalFormID=' + IntToHex(WinnerID, 8)
    )
  else
    Results.Add(
      '    Winner : <NO LOCATION>'
    );

  Results.Add(
    '    Plugins : ' + SourcePlugin + ' -> ' + WinnerPlugin
  );

  Results.Add('');

  Inc(Counter);
end;

function Process(e: IInterface): Integer;
var
  Sig: string;
  Winner: IInterface;
begin
  Result := 0;

  if not Assigned(e) then
    Exit;

  Sig := Signature(e);

  if Length(Sig) <> 4 then
    Exit;

  Winner := WinningOverride(e);

  if not Assigned(Winner) then
    Exit;

  CheckLocationField(
    e,
    Winner,
    'XLRL',
    'XLRL',
    LostXLRL
  );

  CheckLocationField(
    e,
    Winner,
    'XLCN',
    'XLCN',
    LostXLCN
  );
end;

function Finalize: Integer;
var
  i: Integer;
begin
  AddMessage('');
  AddMessage('===================== TRUE LOSSES ====================');
  AddMessage('');

  for i := 0 to Results.Count - 1 do
    AddMessage(Results[i]);

  AddMessage('------------------------------------------------------');
  AddMessage('XLRL fields lost : ' + IntToStr(LostXLRL));
  AddMessage('XLCN fields lost : ' + IntToStr(LostXLCN));
  AddMessage('TOTAL            : ' + IntToStr(LostXLRL + LostXLCN));
  AddMessage('======================================================');
  AddMessage('');

  Results.Free;

  Result := 0;
end;

end.

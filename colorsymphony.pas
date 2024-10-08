program ColorSymphony;
uses Crt;

const
  MaxColors = 4;
  MaxNotes = 5;

type
  TColor = (Red, Green, Blue, Yellow);

var
  CurrentPattern: array[1..MaxNotes] of TColor;
  Score, Level: Integer;
  GameOver: Boolean;

procedure InitGame;
var
  i: Integer;
begin
  Randomize;
  Score := 0;
  Level := 1;
  GameOver := False;
  for i := 1 to MaxNotes do
  begin
    CurrentPattern[i] := TColor(Random(MaxColors));
  end;
end;

procedure DisplayInstructions;
begin
  ClrScr;
  WriteLn('Welcome to Color Symphony!');
  WriteLn;
  WriteLn('Game Instructions:');
  WriteLn('1. Watch the color pattern.');
  WriteLn('2. Repeat the pattern by pressing the corresponding keys:');
  WriteLn('   R (Red), G (Green), B (Blue), Y (Yellow)');
  WriteLn('3. Complete the pattern correctly to advance to the next level.');
  WriteLn('4. The game ends if you make a mistake.');
  WriteLn;
  WriteLn('Press Enter to start the game...');
  ReadLn;
end;

procedure DisplayPattern;
var
  i: Integer;
begin
  ClrScr;
  WriteLn('Watch the pattern:');
  WriteLn;
  for i := 1 to Level do
  begin
    case CurrentPattern[i] of
      Red: Write('R ');
      Green: Write('G ');
      Blue: Write('B ');
      Yellow: Write('Y ');
    end;
    Delay(500);
  end;
  WriteLn;
  WriteLn;
  WriteLn('Now repeat the pattern...');
end;

function GetPlayerInput: TColor;
var
  Ch: Char;
  PlayerColor: TColor;
begin
  repeat
    Ch := UpCase(ReadKey);
  until Ch in ['R', 'G', 'B', 'Y'];

  case Ch of
    'R': PlayerColor := Red;
    'G': PlayerColor := Green;
    'B': PlayerColor := Blue;
    'Y': PlayerColor := Yellow;
  end;
  GetPlayerInput := PlayerColor;
end;

procedure PlayRound;
var
  i: Integer;
  PlayerColor: TColor;
begin
  DisplayPattern;

  for i := 1 to Level do
  begin
    PlayerColor := GetPlayerInput;
    Write(UpCase(Chr(Ord(PlayerColor) + Ord('A'))), ' ');

    if PlayerColor <> CurrentPattern[i] then
    begin
      GameOver := True;
      Exit;
    end;
  end;

  Inc(Score, Level * 10);
  Inc(Level);
  if Level > MaxNotes then
    GameOver := True;
end;

procedure DisplayGameOver;
begin
  ClrScr;
  WriteLn('Game Over!');
  WriteLn('Your Score: ', Score);
  WriteLn('Level Reached: ', Level - 1);
  WriteLn;
  WriteLn('Press Enter to exit...');
  ReadLn;
end;

begin
  DisplayInstructions;
  InitGame;

  repeat
    PlayRound;
  until GameOver;

  DisplayGameOver;
end.
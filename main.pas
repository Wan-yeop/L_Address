unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  DM;

{ TForm1 }

// 저장버튼
procedure TForm1.Button1Click(Sender: TObject);
begin


  // Post를 호출하기 전, 현재 활성 컨트롤의 데이터 변경사항을 데이터셋에 강제로 반영합니다.
  // ActiveControl이 할당되었고 TWinControl을 상속받았는지 확인합니다.
  //if Assigned(ActiveControl) and (ActiveControl is TWinControl) then
  //begin
    // 현재 컨트롤에서 다음 컨트롤로 포커스를 이동시킵니다.
    // 이는 현재 컨트롤의 OnExit 이벤트를 강제로 발생시키는 효과를 가집니다.
    // TDBEdit에 있던 포커스가 빠져나가면서 IME 한글 조합이 완료되고,
    // 해당 내용이 데이터셋 필드에 정상적으로 업데이트됩니다.
    //SelectNext(ActiveControl as TWinControl, True, True);
  //end;


    dm1.sqlquery1.Post;
    // dm1.SQLQuery1.ApplyUpdates;
    dm1.SQLTransaction1.CommitRetaining;

  //DM1.SQLTransaction1.StartTransaction;
  //DM1.SqlQuery1.ApplyUpdates;

 //  DM1.SQLQuery1.Post;

  //DM1.SQLTransaction1.commit;

end;

// commit;
procedure TForm1.Button2Click(Sender: TObject);
begin
  DM1.SQLTransaction1.commit;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

  DM1.IBConnection1.Connected :=  true;
  DM1.SQLTransaction1.Active := True;
  DM1.SQLQuery1.open;  //시작시 open

end;

procedure TForm1.FormActivate(Sender: TObject);
begin

 // DM1.IBConnection1.Connected :=  true;
 // DM1.SQLQuery1.open;  //시작시 open

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

    DM1.SQLTransaction1.commit;

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  DM1.SQLTransaction1.Commit;
  Canclose := True;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;



end.


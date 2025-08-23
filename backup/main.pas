unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    InsertBTN: TBitBtn;
    CancelBTN: TBitBtn;
    PostBTN: TBitBtn;
    DeleteBTN: TBitBtn;
    Button1: TButton;
    Button3: TButton;
    ActiveMode: TLabel;
    MasterSource: TDataSource;
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
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure CancelBTNClick(Sender: TObject);
    procedure DeleteBTNClick(Sender: TObject);
    procedure InsertBTNClick(Sender: TObject);
    procedure PostBTNClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure MasterSourceStateChange(Sender: TObject);
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


// Save
procedure TForm1.PostBTNClick(Sender: TObject);
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
    dm1.SQLQuery1.ApplyUpdates;
    dm1.SQLTransaction1.CommitRetaining;

  //DM1.SQLTransaction1.commit;

end;

// insert BTN
procedure TForm1.InsertBTNClick(Sender: TObject);
begin
  DM1.SQLQuery1.Insert;
end;

// cancel BTN
procedure TForm1.CancelBTNClick(Sender: TObject);
begin
  DM1.SQLQuery1.cancel;
end;

// searchBTN
procedure TForm1.BitBtn1Click(Sender: TObject);
  var
    LSearchText: string;
    LSQL: string;
begin

    LSearchText := Trim(Edit1.Text);

    LSearchText := '%' + LSearchText + '%';
    LSearchText := QuotedStr(LSearchText);

    LSQL := 'SELECT id, ' +
            '  CAST(company_name AS VARCHAR(50)) AS company_name, ' +
            '  CAST(company_ceo AS VARCHAR(30)) AS company_ceo, ' +
            '  CAST(manager AS VARCHAR(20)) AS manager, ' +
            '  CAST(phone_primary AS VARCHAR(20)) AS phone_primary, ' +
            '  CAST(phone_secondary AS VARCHAR(20)) AS phone_secondary, ' +
            '  CAST(fax AS VARCHAR(20)) AS fax, ' +
            '  CAST(address AS VARCHAR(100)) AS address, ' +
            '  CAST(email AS VARCHAR(50)) AS email, ' +
            '  CAST(items AS VARCHAR(100)) AS items, ' +
            '  CAST(keywords AS VARCHAR(100)) AS keywords, ' +
            '  registration_date, ' +
            '  memo ' +
            'FROM address_book ' +
            'WHERE (company_name LIKE ' + LSearchText + ') OR ' +
            '      (manager LIKE ' + LSearchText + ') OR ' +
            '      (items LIKE ' + LSearchText + ') OR ' +
            '      (keywords LIKE ' + LSearchText + ') OR ' +
            '      (memo LIKE ' + LSearchText + ')';


    DM1.SQLQuery1.close;
    DM1.SQLQuery1.sql.clear;
    DM1.SQLQuery1.sql.Add(LSQL);
    DM1.SQLQuery1.Open;


end;

// delete BTN
procedure TForm1.DeleteBTNClick(Sender: TObject);
begin
  if MessageDlg('정말로 지우시겠습니까?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DM1.SQLQuery1.Delete;
    dm1.SQLQuery1.ApplyUpdates;
    dm1.SQLTransaction1.CommitRetaining;
  end;
end;

// OPen
procedure TForm1.Button3Click(Sender: TObject);
begin

  DM1.IBConnection1.Connected :=  true;
  DM1.SQLTransaction1.Active := True;
  DM1.SQLQuery1.open;  //시작시 open

end;

//
procedure TForm1.FormActivate(Sender: TObject);
begin

 // DM1.IBConnection1.Connected :=  true;
 // DM1.SQLQuery1.open;  //시작시 open

end;


// Close
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  DM1.SQLTransaction1.Commit;
  Canclose := True;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.MasterSourceStateChange(Sender: TObject);
begin


    with MasterSource do
    begin

    //  if DataSet <> nil then
    //    ActiveMode.Caption := Format('【 %s: %s 】', [Dataset.Name, DatasetStates[State]]);

      if State in [dsEdit] then
        begin
          ActiveMode.Caption := '수정모드';
          ActiveMode.Font.Color := clBlue;

          InsertBTN.Enabled := False;
          DeleteBTN.Enabled := False;
          PostBTN.Enabled := True;
          CancelBTN.Enabled := True;

        end
      else if State in [dsInsert] then
             begin
                ActiveMode.Caption := '삽입모드';
                ActiveMode.Font.Color := clRed;

                InsertBTN.Enabled := False;
                DeleteBTN.Enabled := False;
                PostBTN.Enabled := True;
                CancelBTN.Enabled := True;

             end
            else
             begin
                ActiveMode.Caption := '';
                ActiveMode.Font.Color := clBlue;

                InsertBTN.Enabled := True;
                DeleteBTN.Enabled := True;
                PostBTN.Enabled := False;
                CancelBTN.Enabled := False;

             end;

    end;   // with

end;



end.


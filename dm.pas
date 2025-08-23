unit DM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, IBConnection, FBAdmin, SQLite3Conn, DB;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    IBConnection1: TIBConnection;
    SQLQuery1: TSQLQuery;
    SQLQuery1ADDRESS: TStringField;
    SQLQuery1COMPANY_CEO: TStringField;
    SQLQuery1COMPANY_NAME: TStringField;
    SQLQuery1EMAIL: TStringField;
    SQLQuery1FAX: TStringField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ITEMS: TStringField;
    SQLQuery1KEYWORDS: TStringField;
    SQLQuery1MANAGER: TStringField;
    SQLQuery1MEMO: TMemoField;
    SQLQuery1PHONE_PRIMARY: TStringField;
    SQLQuery1PHONE_SECONDARY: TStringField;
    SQLQuery1REGISTRATION_DATE: TDateField;
    SQLTransaction1: TSQLTransaction;
    procedure IBConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

{ TDM1 }

procedure TDM1.IBConnection1AfterConnect(Sender: TObject);
begin

end;

end.


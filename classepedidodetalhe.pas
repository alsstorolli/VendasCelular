unit classepedidodetalhe;

interface

type TPedidoDetalhe = class
  private
    Fmpdd_transacao: String;
    Fmpdd_numerodoc: Integer;
    Fmpdd_tipo_codigo: Integer;
    Fmpdd_unid_codigo:string;
    Fmpdd_datamvto:TDateTime;
    Fmpdd_esto_codigo:string;
    Fmpdd_qtde:currency;
    Fmpdd_venda:currency;
    procedure Setmpdd_numerodoc(const Value: Integer);
    procedure Setmpdd_transacao(const Value: string);
    procedure Setmpdd_tipo_codigo(const Value: Integer);
    procedure Setmpdd_unid_codigo(const Value: string);
    procedure Setmpdd_esto_codigo(const Value: string);
    procedure Setmpdd_qtde(const Value: currency);
    procedure Setmpdd_venda(const Value: currency);
    procedure Setmpdd_datamvto(const Value: TDateTime);
  public
    [FieldName('mpdd_transacao')]
    property mpdd_transacao:string read Fmpdd_transacao write Setmpdd_transacao;
    [FieldName('mpdd_numerodoc')]
    property mpdd_numerodoc:Integer read Fmpdd_numerodoc write Setmpdd_numerodoc;
    [FieldName('mpdd_tipo_codigo')]
    property mpdd_tipo_codigo:Integer read Fmpdd_tipo_codigo write Setmpdd_tipo_codigo;
    [FieldName('mpdd_unid_codigo')]
    property mpdd_unid_codigo:string read Fmpdd_unid_codigo write Setmpdd_unid_codigo;
    [FieldName('mpdd_esto_codigo')]
    property mpdd_esto_codigo:string read Fmpdd_esto_codigo write Setmpdd_esto_codigo;
    [FieldName('mpdd_qtde')]
    property mpdd_qtde:currency read Fmpdd_qtde write Setmpdd_qtde;
    [FieldName('mpdd_venda')]
    property mpdd_venda:currency read Fmpdd_venda write Setmpdd_venda;
    [FieldName('mpdd_datamvto')]
    property mpdd_datamvto:TDateTime read Fmpdd_datamvto write Setmpdd_datamvto;

end;


implementation

{ TPedidoDetalhe }

procedure TPedidoDetalhe.Setmpdd_datamvto(const Value: TDateTime);
begin
  Fmpdd_datamvto := Value;
end;

procedure TPedidoDetalhe.Setmpdd_esto_codigo(const Value: string);
begin
  Fmpdd_esto_codigo := Value;
end;

procedure TPedidoDetalhe.Setmpdd_numerodoc(const Value: Integer);
begin
    Fmpdd_numerodoc := Value;
end;

procedure TPedidoDetalhe.Setmpdd_qtde(const Value: currency);
begin
  Fmpdd_qtde := Value;
end;

procedure TPedidoDetalhe.Setmpdd_tipo_codigo(const Value: Integer);
begin
  Fmpdd_tipo_codigo := Value;
end;

procedure TPedidoDetalhe.Setmpdd_transacao(const Value: string);
begin
  Fmpdd_transacao := Value;
end;

procedure TPedidoDetalhe.Setmpdd_unid_codigo(const Value: string);
begin
  Fmpdd_unid_codigo := Value;
end;

procedure TPedidoDetalhe.Setmpdd_venda(const Value: currency);
begin
  Fmpdd_venda := Value;
end;

end.

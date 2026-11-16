unit classepedidomestre;

interface

type TPedidoMestre = class
  private
    Fmped_transacao: String;
    Fmped_numerodoc: Integer;
    Fmped_tipo_codigo: Integer;
    Fmped_unid_codigo:string;
    Fmped_datamvto:TDateTime;
    Fmped_vlrtotal:Double;
    Fmped_totprod:Double;
    Fmped_fpgt_prazos:string;
    Fmped_fpgt_codigo:string;
    Fmped_port_codigo:string;
    procedure Setmped_numerodoc(const Value: Integer);
    procedure Setmped_transacao(const Value: string);
    procedure Setmped_tipo_codigo(const Value: integer);
    procedure Setmped_unid_codigo(const Value: string);
    procedure Setmped_datamvto(const Value: TDateTime);
    procedure Setmped_vlrtotal(const Value: Double);
    procedure Setmped_totprod(const Value: Double);
    procedure Setmped_fpgt_prazos(const Value: string);
    procedure Setmped_fpgt_codigo(const Value: string);
    procedure Setmped_port_codigo(const Value: string);
  public
    [FieldName('mped_transacao')]
    property mped_transacao:string read Fmped_transacao write Setmped_transacao;
    [FieldName('mped_numerodoc')]
    property mped_numerodoc:Integer read Fmped_numerodoc write Setmped_numerodoc;
    [FieldName('mped_tipo_codigo')]
    property mped_tipo_codigo:Integer read Fmped_tipo_codigo write Setmped_tipo_codigo;
    [FieldName('mped_unid_codigo')]
    property mped_unid_codigo:string read Fmped_unid_codigo write Setmped_unid_codigo;
    [FieldName('mped_datamvto')]
    property mped_datamvto:TDateTime read Fmped_datamvto write Setmped_datamvto;
    [FieldName('mped_vlrtotal')]
    property mped_vlrtotal:Double read Fmped_vlrtotal write Setmped_vlrtotal;
    [FieldName('mped_totprod')]
    property mped_totprod:Double read Fmped_totprod write Setmped_totprod;
    [FieldName('mped_fpgt_prazos')]
    property mped_fpgt_prazos:string read Fmped_fpgt_prazos write Setmped_fpgt_prazos;
    [FieldName('mped_fpgt_codigo')]
    property mped_fpgt_codigo:string read Fmped_fpgt_codigo write Setmped_fpgt_codigo;
    [FieldName('mped_port_codigo')]
    property mped_port_codigo:string read Fmped_port_codigo write Setmped_port_codigo;

end;

implementation


{ TPedidoMestre }

procedure TPedidoMestre.Setmped_datamvto(const Value: TDateTime);
begin
  Fmped_datamvto := Value;
end;

procedure TPedidoMestre.Setmped_fpgt_codigo(const Value: string);
begin
   FMped_fpgt_codigo := Value;
end;

procedure TPedidoMestre.Setmped_fpgt_prazos(const Value: string);
begin
  Fmped_fpgt_prazos := Value;
end;

procedure TPedidoMestre.Setmped_numerodoc(const Value: Integer);
begin
  Fmped_numerodoc := Value;
end;

procedure TPedidoMestre.Setmped_port_codigo(const Value: string);
begin
   FMped_port_codigo := Value;
end;

procedure TPedidoMestre.Setmped_tipo_codigo(const Value: Integer);
begin
  Fmped_tipo_codigo := Value;
end;

procedure TPedidoMestre.Setmped_totprod(const Value: Double);
begin
  Fmped_totprod := Value;
end;

procedure TPedidoMestre.Setmped_transacao(const Value: string);
begin
  Fmped_transacao := Value;
end;

procedure TPedidoMestre.Setmped_unid_codigo(const Value: string);
begin
  Fmped_unid_codigo := Value;
end;

procedure TPedidoMestre.Setmped_vlrtotal(const Value: Double);
begin
  Fmped_vlrtotal := Value;
end;

end.

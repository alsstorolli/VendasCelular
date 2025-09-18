unit Classeportadores;

interface

type TClassePortadores=class
  private
    FDescricao: String;
    FCodigo: String;
    FConta: Integer;
    procedure SetCodigo(const Value: String);
    procedure SetConta(const Value: Integer);
    procedure SetDescricao(const Value: String);
  public
    property Codigo:String read FCodigo write SetCodigo;
    property Descricao:String read FDescricao write SetDescricao;
    property Conta:Integer read FConta write SetConta;
end;


implementation

{ TClassePortadores }

procedure TClassePortadores.SetCodigo(const Value: String);
begin
   Fcodigo := value;
end;

procedure TClassePortadores.SetConta(const Value: Integer);
begin
   Fconta := value;
end;

procedure TClassePortadores.SetDescricao(const Value: String);
begin
  FDescricao := value;
end;

end.

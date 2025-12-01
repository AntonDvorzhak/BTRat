//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

program BTrat_v2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit6 in 'Unit6.pas' {Form6},
  HealthParamUnit in '..\..\Android Protocols\v0\HealthParamUnit.pas' {HealthParams};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(THealthParams, HealthParams);
  Application.CreateForm(THealthParams, HealthParams);
  Application.Run;
end.

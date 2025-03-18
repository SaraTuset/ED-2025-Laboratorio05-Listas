unit uListadeListas;

interface

uses
    SysUtils, 
    uListaEnlazadaDoble;

type

    nodo = record
        persona: string; // Información almacenada en el nodo
        lista: tListaDoble; // Información almacenada en el nodo
        sig: ^nodo; // Puntero al siguiente nodo
        ant: ^nodo; // Puntero al nodo anterior
    end;

    TPNodo= ^nodo;

    tListaDeListas = record
        first, last: ^nodo; // Punteros al primer y último nodo de la lista
    end;

    procedure inicializar(var list: tListaDeListas);
    function hay_facturas(list: tListaDeListas): boolean;
    function hay_facturas_de_persona(list: tListaDeListas; persona: string): boolean;
    procedure obtener_facturas_de_persona(list: tListaDeListas; persona: string; var lista: tListaDoble);
    function obtener_factura_de_persona(list: tListaDeListas; persona: string): integer;
    procedure pagar_facturas_de_persona(var list: tListaDeListas; persona: string);
    procedure pagar_factura_de_persona(var list: tListaDeListas; persona: string);
    procedure agregar_factura_a_persona(var list: tListaDeListas; persona: string; factura: integer);
    function imprimir_facturas(list: tListaDeListas): string;

implementation
   procedure inicializar(var list: tListaDeListas);
   begin
     list.first:= nil;
     list.last:= nil;
   end;

   function hay_facturas(list: tListaDeListas): boolean;
   begin
      hay_facturas := list.first <> nil; //Solo se guardan si tienen facturas

   end;

   function encontrar_persona(list: tListaDeListas; persona: string): TPNodo;
    var
     encontrado: Boolean;
     aux: TPNodo;
   begin
      encontrado := False;
      aux := list.first;
      while (aux <> nil) and not encontrado do
        if aux^.persona = persona then
           encontrado := True
        else
          aux := aux^.sig;
      encontrar_persona := aux;
   end;

   function hay_facturas_de_persona(list: tListaDeListas; persona: string): boolean;
   begin
      hay_facturas_de_persona := encontrar_persona(list, persona) <> nil;
   end;

   procedure obtener_facturas_de_persona(list: tListaDeListas; persona: string; var lista: tListaDoble);
   var
     aux: TPNodo;
   begin
      aux := encontrar_persona(list, persona);
      if aux <> nil then
         copy(aux^.lista, lista);
   end;

   function obtener_factura_de_persona(list: tListaDeListas; persona: string): integer;
   var
     factura: Integer;
     aux: TPNodo;
   begin
      factura := 0;
      aux := encontrar_persona(list,persona);
      if aux <> nil then
         begin
              factura := first(aux^.lista);        // first - ... - last
         end;                                      // |out| - ... - |new|
      obtener_factura_de_persona := factura;
   end;

   procedure pagar_facturas_de_persona(var list: tListaDeListas; persona: string);
   var
     aux: TPNodo;
   begin
      aux := encontrar_persona(list,persona);
      if aux <> nil then
         begin
              clear(aux^.lista);

              //Eliminar cliente
              if aux <> list.first then
                 aux^.ant^.sig:=aux^.sig
              else
                list.first:=aux^.sig;

              if aux <> list.last then
                 aux^.sig^.ant:=aux^.ant
              else
                list.last:= aux^.ant;

              Dispose(aux);
         end;
   end;

   procedure pagar_factura_de_persona(var list: tListaDeListas; persona: string);
   var
     aux: TPNodo;
   begin
      aux := encontrar_persona(list,persona);
      if aux <> nil then
         begin
              delete_at_begin(aux^.lista);
              if is_empty(aux^.lista) then
                 begin  //Eliminar cliente
                    if aux <> list.first then
                       aux^.ant^.sig:=aux^.sig
                    else
                      list.first:=aux^.sig;

                    if aux <> list.last then
                       aux^.sig^.ant:=aux^.ant
                    else
                      list.last:= aux^.ant;

                    Dispose(aux);
                 end;
         end;
   end;

   procedure agregar_factura_a_persona(var list: tListaDeListas; persona: string; factura: integer);
      var
     aux: TPNodo;
   begin
      aux := encontrar_persona(list,persona);
      if aux = nil then
         begin
            new(aux);
            aux^.persona:= persona;
            initialize(aux^.lista);
            aux^.sig:= nil;
            aux^.ant:= list.last;
            if list.last = nil then
               list.first:= aux
            else
               list.last^.sig:= aux;
            list.last:= aux;
         end;
      insert_at_end(aux^.lista, factura)
   end;

   function imprimir_facturas(list: tListaDeListas): string;
   var
     s: String;
     aux: TPNodo;
   begin
      s := '';
      aux := list.first;
      while aux <> nil do
        begin
          s := s + aux^.persona + ': ' + to_string(aux^.lista);
          aux := aux^.sig;
          if aux <> nil then
             s += ' '
        end;
      imprimir_facturas := s;

   end;

end.

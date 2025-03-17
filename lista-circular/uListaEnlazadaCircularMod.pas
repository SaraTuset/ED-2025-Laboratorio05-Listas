unit uListaEnlazadaCircularMod;

interface

uses
    SysUtils;

type
    nodo = record
        info: Integer; // Información almacenada en el nodo
        sig: ^nodo; // Puntero al siguiente nodo
    end;

    TPNodo = ^nodo;

    tListaCircular = record
        last: ^nodo; // Puntero al último nodo de la lista
    end;

    {Operaciones básicas}
    procedure initialize(var list: tListaCircular);
    function is_empty(list: tListaCircular): boolean;
    function first(list: tListaCircular): integer;
    function last(list: tListaCircular): integer;
    procedure insert_at_end(var list: tListaCircular; x: integer);
    procedure insert_at_begin(var list: tListaCircular; x: integer);
    procedure delete(var list: tListaCircular; x: integer);
    function in_list(list: tListaCircular; x: integer): boolean;

    {Otras operaciones}
    function to_string(list: tListaCircular): string;
    { Ejercicio 8 }
    function to_string_rec(list: tListaCircular): string;
    procedure clear(var list: tListaCircular);
    function num_elems(list: tListaCircular): integer;
    { Ejercicio 8 }
    function num_elems_rec(list: tListaCircular): integer;
    procedure copy(list: tListaCircular; var c2: tListaCircular);

implementation

    procedure initialize(var list: tListaCircular);
    begin
        list.last := nil; // Inicializa la lista vacía
    end;

    function is_empty(list: tListaCircular): boolean;
    begin
        is_empty := list.last = nil; // Verifica si la lista está vacía
    end;

    function first(list: tListaCircular): integer;
    begin
        if not is_empty(list) then
            first := list.last^.sig^.info; // Devuelve el primer elemento de la lista
    end;

    function last(list: tListaCircular): integer;
    begin
        if not is_empty(list) then
            last := list.last^.info; // Devuelve el último elemento de la lista
    end;

    procedure insert_at_end(var list: tListaCircular; x: integer);
    var
        aux: ^nodo;
    begin
        new(aux); // Crea un nuevo nodo
        aux^.info := x; // Almacena la información
        if is_empty(list) then
            aux^.sig := aux // El nodo apunta a sí mismo
        else
        begin
            aux^.sig := list.last^.sig; // El nuevo nodo apunta al primer nodo
            list.last^.sig := aux; // El último nodo apunta al nuevo nodo
        end;
        list.last := aux; // El último nodo es el nuevo nodo
    end;

    procedure insert_at_begin(var list: tListaCircular; x: integer);
    var
        aux: ^nodo;
    begin
        new(aux); // Crea un nuevo nodo
        aux^.info := x; // Almacena la información
        if is_empty(list) then
        begin
            aux^.sig := aux; // El nodo apunta a sí mismo
            list.last := aux; // El último nodo es el nuevo nodo
        end
        else
        begin
            aux^.sig := list.last^.sig; // El nuevo nodo apunta al primer nodo
            list.last^.sig := aux; // El último nodo apunta al nuevo nodo
        end;
    end;

    procedure delete(var list: tListaCircular; x: integer);
    var
        aux, prev: ^nodo;
        found: boolean;
    begin
        if not is_empty(list) then
        begin
            found := false;
            aux := list.last^.sig;
            prev := list.last;
            while (aux <> list.last) and not found do
            begin
                if aux^.info = x then
                    found := true
                else
                begin
                    prev := aux;
                    aux := aux^.sig;
                end;
            end;
            if aux^.info = x then
            begin
                if aux = list.last then
                begin
                    if aux = prev then // Caso especial: Lista con un solo nodo
                        list.last := nil // La lista queda vacía
                    else
                        list.last := prev; // Caso general: Se elimina el último nodo
                end;
                if list.last <> nil then // Asegurarse de que la lista no esté vacía después de la posible actualización de last
                    prev^.sig := aux^.sig;
                dispose(aux);
            end;
        end;
    end;

    function in_list(list: tListaCircular; x: integer): boolean;
    var
        aux: ^nodo;
        found: boolean;
    begin
        found := false;
        if not is_empty(list) then
        begin
            aux := list.last^.sig; // Comienza en el primer nodo
            while (aux <> list.last) and not found do // Recorre la lista y busca el elemento
            begin
                if aux^.info = x then
                    found := true
                else
                    aux := aux^.sig;
            end;
            if aux^.info = x then
                found := true;
        end;
        in_list := found; // Devuelve true si se encontró el elemento
    end;

    { --- Otras operaciones --- }

    function to_string(list: tListaCircular): string;
    var
        aux: ^nodo;
        s: string;
    begin
        s := '';
        if not is_empty(list) then
        begin
            aux := list.last^.sig; // Comienza en el primer nodo
            repeat
                s := s + IntToStr(aux^.info) + ' '; // Concatena la información
                aux := aux^.sig; // Avanza al siguiente nodo
            until aux = list.last^.sig; // Hasta que se complete el ciclo
        end;
        to_string := s; // Devuelve la lista como cadena
    end;

    function to_string_rec_aux(node: TPNodo; list: tListaCircular): string;
    begin
        if  node = list.last then
           to_string_rec_aux := ''
        else
            to_string_rec_aux := ', ' + IntToStr(node^.info) + to_string_rec_aux(list.last^.sig, list);
    end;

    function to_string_rec(list: tListaCircular): string;
    begin
        if is_empty(list) then
           to_string_rec := ''
        else
            to_string_rec := IntToStr(list.last^.info) + to_string_rec_aux(list.last^.sig, list);
    end;


    procedure clear(var list: tListaCircular);
    var
        aux: ^nodo;
    begin
        if not is_empty(list) then
        begin
            aux := list.last^.sig; // Comienza en el primer nodo
            repeat
                list.last^.sig := aux^.sig; // Enlaza el último nodo con el siguiente
                dispose(aux); // Libera la memoria
                aux := list.last^.sig; // Avanza al siguiente nodo
            until aux = list.last^.sig; // Hasta que se complete el ciclo
            list.last := nil; // La lista está vacía
        end;
    end;

    function num_elems(list: tListaCircular): integer;
    var
        aux: ^nodo;
        count: integer;
    begin
        count := 0;
        if not is_empty(list) then
        begin
            aux := list.last^.sig; // Comienza en el primer nodo
            repeat
                count := count + 1; // Incrementa el contador
                aux := aux^.sig; // Avanza al siguiente nodo
            until aux = list.last^.sig; // Hasta que se complete el ciclo
        end;
        num_elems := count; // Devuelve el número de elementos
    end;



    { Ejercicio 8 }
    function num_elems_rec_aux(node: TPNodo; list: tListaCircular): Integer;
    begin
        if node = list.last then
           num_elems_rec_aux := 0
        else
            num_elems_rec_aux := 1 + num_elems_rec_aux(node^.sig, list);
    end;

    function num_elems_rec(list: tListaCircular): integer;
    begin
        if is_empty(list) then
           num_elems_rec := 0
        else
            num_elems_rec := 1 + num_elems_rec_aux(list.last^.sig, list);
    end;


    procedure copy(list: tListaCircular; var c2: tListaCircular);
    var
        aux: ^nodo;
    begin
        initialize(c2); // Inicializa la nueva lista
        if not is_empty(list) then
        begin
            aux := list.last^.sig; // Comienza en el primer nodo
            repeat
                insert_at_end(c2, aux^.info); // Inserta el elemento en la nueva lista
                aux := aux^.sig; // Avanza al siguiente nodo
            until aux = list.last^.sig; // Hasta que se complete el ciclo
        end;
    end;

end.

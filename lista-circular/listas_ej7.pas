program listas_ej7;

uses uListaEnlazadaCircular;

var
  lista, lista2: tListaCircular;

begin
    // 7.1 Inicialización de la lista
    initialize(lista);

    // 7.2 Inserción de elementos al final
    insert_at_end(lista, 2);
    insert_at_end(lista, 4);
    insert_at_end(lista, 1);
    WriteLn('Lista tras insertar por el final: ', to_string(lista));
    WriteLn;

    // 7.3 Cálculo de diferencia entre primer y último elemento
    WriteLn('Primer elemento: ', first(lista));
    WriteLn('Último elemento: ', last(lista));
    WriteLn('Diferencia: ', first(lista) - last(lista));
    WriteLn;

    // 7.4 Eliminación y limpieza
    WriteLn('La lista esta vacia = ', is_empty(lista));
    clear(lista);
    WriteLn('La lista esta vacia = ', is_empty(lista));

    // 7.5 Copia de lista y verificación de vacío
    copy(lista,lista2);
    WriteLn('Lista copiada a lista 2: ', to_string(lista), '= ', to_string(lista2));
    insert_at_begin(lista, 1);
    insert_at_begin(lista, 1);
    copy(lista,lista2);
    WriteLn('Lista copiada a lista 2: ', to_string(lista), '= ', to_string(lista2));
    delete(lista, first(lista));
    WriteLn('Tras eliminar por el inicio: ', to_string(lista), '!= ', to_string(lista2));

    // 7.6 Inserción al inicio
    insert_at_begin(lista, 2);
    insert_at_begin(lista, 3);
    insert_at_begin(lista, 5);
    insert_at_begin(lista, 4);
    WriteLn('Lista tras insertar 2, 3, 5 y 4: ', to_string(lista));

    // 7.7 Eliminación al final
    delete(lista, last(lista));
    WriteLn('Lista tras eliminar el final: ', to_string(lista));

    // 7.8 Eliminación de elemento específico
    delete(lista, 3);
    WriteLn('Lista tras eliminar el 3: ', to_string(lista));

    // 7.9 Búsqueda de elemento (iterativa)
    WriteLn('Recursivamente:');
    WriteLn('El 3 esta el la lista = ', in_list(lista, 3));
    WriteLn('El 2 esta el la lista = ', in_list(lista, 2));



    readln;
end.

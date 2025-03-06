program listas_ej2;

uses uListaEnlazadaSimple;

var
  lista, lista2: tListaSimple;

begin
    // 2.1 Inicializar lista
    initialize(lista);

    // 2.2 Insertar elementos al final y mostrar lista
    insert_at_end(lista, 2);
    insert_at_end(lista, 4);
    insert_at_end(lista, 1);
    WriteLn('Lista tras insertar por el final: ', to_string(lista));
    WriteLn;

    // 2.3 Obtener primer y último elemento, calcular diferencia
    WriteLn('Primer elemento: ', first(lista));
    WriteLn('Último elemento: ', last(lista));
    WriteLn('Diferencia: ', first(lista) - last(lista));
    WriteLn;

    // 2.4 Número de elementos, eliminar al inicio, limpiar lista
    WriteLn('Número de elementos de la lista: ', num_elems(lista));
    delete_at_begin(lista);
    WriteLn('Tras eliminar por el inicio: ', num_elems(lista));
    clear(lista);
    WriteLn('Tras limpiarla: ', num_elems(lista));
    WriteLn;

    // 2.5 Verificar si la lista está vacía, copiar lista, eliminar al inicio
    WriteLn('La lista esta vacia = ', is_empty(lista));
    WriteLn('Tras insertar 1 y 2');
    insert_at_end(lista, 1);
    insert_at_end(lista, 2);
    WriteLn('La lista esta vacia = ', is_empty(lista));
    copy(lista,lista2);
    WriteLn('Lista copiada a lista 2: ', to_string(lista), '= ', to_string(lista2));
    delete_at_begin(lista);
    WriteLn('Tras eliminar por el inicio: ', to_string(lista), '!= ', to_string(lista2));

    // 2.6 Insertar al inicio
    insert_at_begin(lista, 1);
    WriteLn('Tras insertar 1 por el inicio: ', to_string(lista), '= ', to_string(lista2));

    // 2.7 Eliminar al final;
    delete_at_end(lista);
    WriteLn('Tras eliminar por el final: ', to_string(lista), '!= ', to_string(lista2));
    WriteLn;

    // 2.8 Eliminar un elemento específico
    insert_at_end(lista, 2);
    insert_at_end(lista, 3);
    insert_at_end(lista, 4);
    WriteLn('Lista tras insertar 2, 3 y 4: ', to_string(lista));
    delete(lista, 3);
    WriteLn('Lista tras eliminar el 3: ', to_string(lista));

    // 2.9 Verificar si un elemento está en la lista
    WriteLn('El 3 esta el la lista = ', in_list(lista, 3));
    WriteLn('El 2 esta el la lista = ', in_list(lista, 2));

    // 2.10 Verificar recursivamente si un elemento está en la lista


    readln;
end.

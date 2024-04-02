package br.edu.ifpr.formulario.services;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;

public class FormularioService {

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    /*** Verifica se o texto não é nulo ou possui menos de 2 caracteres ***/
    public String validaTexto(String textParam) throws IllegalArgumentException {

        if (textParam == null || textParam.length() < 2){
            throw new IllegalArgumentException("O valor informado é inválido");
        }

        return textParam.trim();
    }

    /*** Verifica se o número é maior que zero ***/
    public Integer validaNumero(String numeroParam) throws IllegalArgumentException {

        Integer numero = Integer.valueOf(numeroParam);

        if (numero < 0){
            throw new IllegalArgumentException("O valor informado não pode ser negativo");
        }

        return numero;
    }

    /*** Verifica se a lista de herois não está vazia ***/
    public ArrayList<String> validaCheckbox(String[] herois){

        ArrayList<String> list = new ArrayList<>();

        if (herois == null){
            throw new IllegalArgumentException("A lista de herois não pode estar vazia");
        }

        for (String s : herois) {
            list.add(s.toUpperCase());
        }

        return list;
    }

    /*** Verifica se a lista de herois não está vazia ***/
    public LocalDate validaData(String dataTexto){

        LocalDate data;
        try {
            data = LocalDate.parse(dataTexto);

        } catch (DateTimeParseException e1){
            try {
                data = LocalDate.parse(dataTexto, formatter);
            }catch (DateTimeParseException e2) {
                throw new IllegalArgumentException("O texto " + dataTexto + " não pode ser interpretado como uma data");
            }
        }

        return data;
    }

    public String getDataBrasil(LocalDate date){
        return date.format(formatter);
    }

}

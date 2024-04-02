package br.edu.ifpr.formulario.models;

import br.edu.ifpr.formulario.services.FormularioService;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Objects;

public class Formulario {

    FormularioService service = new FormularioService();

    private String texto;
    private Integer numero;
    private LocalDate data;
    private String opcao;
    private ArrayList<String> herois = new ArrayList<>();

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public LocalDate getData() {
        return data;
    }

    public String getDataBrasil() {
        return service.getDataBrasil(this.data);
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getOpcao() {
        return opcao;
    }

    public void setOpcao(String opcao) {
        this.opcao = opcao;
    }

    public ArrayList<String> getHerois() {
        return herois;
    }

    public void setHeroi(String heroi) {
        herois.add(heroi);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Formulario that = (Formulario) o;

        if (!Objects.equals(texto, that.texto)) return false;
        return Objects.equals(numero, that.numero);
    }

    @Override
    public int hashCode() {
        int result = texto != null ? texto.hashCode() : 0;
        result = 31 * result + (numero != null ? numero.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Formulario{" +
                "texto='" + texto + '\'' +
                ", numero=" + numero +
                ", data=" + data +
                ", opcao='" + opcao + '\'' +
                '}';
    }
}

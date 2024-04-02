package br.edu.ifpr.formulario.controllers;

import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import br.edu.ifpr.formulario.models.Formulario;
import br.edu.ifpr.formulario.services.FormularioService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class FormularioServlet extends HttpServlet {
    private String message;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Formulario formulario = new Formulario();
        FormularioService service = new FormularioService();

        Map<String, String> erros = new HashMap<>();

        try {
            String texto = service.validaTexto(request.getParameter("campo_texto"));
            formulario.setTexto(texto);
        } catch (IllegalArgumentException e) {
            erros.put("erro_texto", e.getMessage());
        }

        try {
            Integer numero = service.validaNumero(request.getParameter("campo_numerico"));
            formulario.setNumero(numero);
        } catch (IllegalArgumentException e) {
            erros.put("erro_numero", e.getMessage());
        }

        try {
            ArrayList<String> herois = service.validaCheckbox(request.getParameterValues("campo_opcao_checkbox"));
            for (String heroi: herois ) {
                formulario.setHeroi(heroi);
            }
        } catch (IllegalArgumentException e){
            erros.put("erro_herois", e.getMessage());
        }

        try {
            LocalDate date = service.validaData(request.getParameter("campo_data"));
            formulario.setData(date);

        } catch (IllegalArgumentException e) {
            erros.put("erro_data", e.getMessage());
        }

        formulario.setOpcao(request.getParameter("campo_opcao_radio"));

        if (!erros.isEmpty()){
            request.setAttribute("erros_map", erros);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }


        request.setAttribute("formulario", formulario);
        RequestDispatcher dispatcher = request.getRequestDispatcher("sucesso.jsp");
        dispatcher.forward(request, response);

    }
}
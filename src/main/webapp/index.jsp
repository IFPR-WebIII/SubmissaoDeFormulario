<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Map<String, String> erros = (Map<String, String>) request.getAttribute("erros_map");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Formulário de Cadastro JSP</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<div class="isolate bg-white p-36">

    <div class="mx-auto max-w-2xl text-center">
        <h1 class="text-2xl font-bold tracking-tight text-gray-900">Formulário de Cadastro</h1>
        <p class="mt-2 leading-8 text-gray-600">Aplicação de exemplo para submissão e validação de formulários</p>
    </div>

    <%-- request.getContextPath() -> caminho para o servidor --%>
    <form action="<%= request.getContextPath() %>/hello-servlet" method="get">

        <!-- Campo Texto -->
        <div class="mb-5">
            <label for="campo_texto" class="block text-sm font-semibold leading-6 text-gray-900">Campo de Texto</label>
            <div class="mt-2.5">
                <input type="text" name="campo_texto" id="campo_texto"
                       placeholder="informe um texto com ao menos 2 caracteres"
                       class="block w-full rounded-md border-0 px-3.5 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6">
            </div>
            <p class="text-red-500 font-light">
                <% if (erros != null && erros.containsKey("erro_texto")) {out.print(erros.get("erro_texto"));}%>
            </p>
        </div>

        <!-- Campo Número -->
        <div class="mb-5">
            <label for="campo_numerico" class="block text-sm font-semibold leading-6 text-gray-900">Campo Número</label>
            <div class="mt-2.5">
                <input type="number" name="campo_numerico" id="campo_numerico" autocomplete="informe um número"
                       class="block w-full rounded-md border-0 px-3.5 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6">
            </div>
            <p class="text-red-500">
                <% if (erros != null && erros.containsKey("erro_numero")) {out.print(erros.get("erro_numero"));}%>
            </p>
        </div>

        <!-- Campo Data -->
        <div class="mb-5">
            <label for="campo_data" class="block text-sm font-semibold leading-6 text-gray-900">Campo Data</label>
            <div class="mt-2.5">
                <input type="date" name="campo_data" id="campo_data" autocomplete="informe um número"
                       class="block w-full rounded-md border-0 px-3.5 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6">
            </div>
            <p class="text-red-500">
                <% if (erros != null && erros.containsKey("erro_data")) {out.print(erros.get("erro_data"));}%>
            </p>
        </div>

        <!-- Campo Opções -->
        <div class="mb-5">

            <label for="campo_data" class="block text-sm font-semibold leading-6 text-gray-900">Campo de opções
                (radio)</label>

            <div class="flex items-center gap-x-3">
                <input id="push-everything" name="campo_opcao_radio" type="radio" value="Valor 'a'" checked
                       class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                <label for="push-everything" class="block text-sm font-medium leading-6 text-gray-900">Valor A</label>
            </div>
            <div class="flex items-center gap-x-3">
                <input id="push-email" name="campo_opcao_radio" type="radio" value="Valor 'b'"
                       class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                <label for="push-email" class="block text-sm font-medium leading-6 text-gray-900">Valor B</label>
            </div>
            <div class="flex items-center gap-x-3">
                <input id="push-nothing" name="campo_opcao_radio" type="radio" value="Valor 'c'"
                       class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                <label for="push-nothing" class="block text-sm font-medium leading-6 text-gray-900">Valor C</label>
            </div>
        </div>

        <div>
            <label for="campo_data" class="block text-sm font-semibold leading-6 text-gray-900">Campo de opções (checkbox)</label>

            <div class="mb-5 flex gap-4">

                <div class="flex-auto">
                    <input name="campo_opcao_checkbox" type="checkbox" value="Aquaman"
                           class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                    <label for="" class="text-sm font-medium leading-5 text-gray-900">Aquaman</label>
                </div>

                <div class="flex-auto">
                    <input name="campo_opcao_checkbox" type="checkbox" value="Batman"
                           class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                    <label for="" class="text-sm font-medium leading-5 text-gray-900">Batman</label>
                </div>

                <div class="flex-auto">
                    <input name="campo_opcao_checkbox" type="checkbox" value="Capitão América"
                           class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600">
                    <label for="" class="text-sm font-medium leading-5 text-gray-900">Capitão América</label>
                </div>

            </div>
            <p class="text-red-500">
                <% if (erros != null && erros.containsKey("erro_herois")) {out.print(erros.get("erro_herois"));}%>
            </p>

        </div>


        <div class="mt-6 flex items-center justify-start gap-x-6">
            <button type="submit"
                    class="rounded-md bg-indigo-600 px-3 py-2 text-white hover:bg-indigo-500">
                Submeter
            </button>
            <button type="reset" class="font-semibold text-gray-900">Apagar</button>
        </div>

    </form>

</div>
</body>
</html>
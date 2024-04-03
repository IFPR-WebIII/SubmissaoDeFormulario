<%@ page import="java.util.Map" %>
<%@ page import="br.edu.ifpr.formulario.models.Formulario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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

  <div>
    <div class="mt-6 border-t border-gray-100">
      <dl class="divide-y divide-gray-100">

        <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
          <dt class="text-sm font-medium leading-6 text-gray-900">Texto Informado</dt>
          <dd class="mt-1 text-sm leading-6 font-light sm:col-span-2 sm:mt-0">${requestScope.formulario.texto}</dd>
        </div>

        <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
          <dt class="text-sm font-medium leading-6 text-gray-900">Número Informado</dt>
          <dd class="mt-1 text-sm leading-6 font-light sm:col-span-2 sm:mt-0">${requestScope.formulario.texto}</dd>
        </div>

        <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
          <dt class="text-sm font-medium leading-6 text-gray-900">Data informada</dt>
          <dd class="mt-1 text-sm leading-6 font-light sm:col-span-2 sm:mt-0">${requestScope.formulario.dataBrasil}</dd>
        </div>

        <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
          <dt class="text-sm font-medium leading-6 text-gray-900">Opção selecionada</dt>
          <dd class="mt-1 text-sm leading-6 font-light sm:col-span-2 sm:mt-0">${requestScope.formulario.opcao}</dd>
        </div>

        <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-0">
          <dt class="text-sm font-medium leading-6 text-gray-900">Heróis selecionados</dt>
          <dd class="mt-1 text-sm leading-6 font-light sm:col-span-2 sm:mt-0">${requestScope.formulario.herois}</dd>
        </div>


      </dl>
    </div>
  </div>








</div>
</body>
</html>
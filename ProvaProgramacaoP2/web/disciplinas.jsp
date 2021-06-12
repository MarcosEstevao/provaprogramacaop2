<%-- 
    Document   : disciplinas
    Created on : 12 de jun. de 2021, 20:02:18
    Author     : MARCOSESTEVAODASILVA
(5 pontos) Deve haver uma página chamada “disciplinas.jsp” que inclua o jspf acima e que apresente, para quem está com sessão identificada:

(5 pontos) Um formulário para incluir uma disciplina informando nome, dia da semana, horário e quantidade de aulas

(5 pontos) A lista com as disciplinas cadastradas, com comando de exclusão e campos para alterar as notas da p1 ou da p2

(10 pontos) Os dados da lista devem ser armazenados no banco de dados em uma tabela chamada disciplinas com campos para 
nome, dia da semana, horário, quantidade de aulas, nota da p1 e nota da p2
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Disciplina> disciplinas = new ArrayList<>();
    try{
        if(request.getParameter("insert")!=null){
            String nome = request.getParameter("nome");
            String diaDaSemana = request.getParameter("diaDaSemana");
            String horario = request.getParameter("horario");
            int qtAulas = Integer.parseInt(request.getParameter("qtAulas"));
            Disciplina.insertDisciplina(nome, diaDaSemana, horario, qtAulas, 0F, 0F);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("update")!=null){
            String nome = request.getParameter("nome");
            Float p1 = Float.parseFloat(request.getParameter("p1"));
            Float p2 = Float.parseFloat(request.getParameter("p2"));
            Disciplina.updateDisciplina(nome, p1, p2);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("delete")!=null){
            String nome = request.getParameter("nome");
            Disciplina.deleteDisciplina(nome);
            response.sendRedirect(request.getRequestURI());
        }
        disciplinas = Disciplina.getDisciplinas();
    }catch(Exception ex){
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários - MyFinance$</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Usuários</h2>
        <%if(requestError!=null){%>
        <div style="color: red"><%= requestError %></div>
        <%}%>
        
        <%if(session.getAttribute("user.login") == null){%>
            <div>Página restrita a usuários logados</div>
        <%}else{%>
        
        <form method="post">
            Nome: <input type="text" name="nome"/>
            Dia da semana: <input type="text" name="diaDaSemana"/>
            Horário: <input type="text" name="horario"/>
            Quantidade de aulas: <input type="text" name="qtAulas"/>
            <input type="submit" name="insert" value="Inserir"/>
        </form>
        <hr/>
        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Dia da semana</th>
                <th>Horário</th>
                <th>Quantidade de aulas</th>
                <th>P1</th>
                <th>P2</th>
                <th>Alteração</th>
                <th>Exclusão</th>
            </tr>
            <%for(Disciplina disciplina: disciplinas){%>
                <tr>
                    <td><%= disciplina.getNome() %></td>
                    <td><%= disciplina.getDiaDaSemana() %></td>
                    <td><%= disciplina.getHorario() %></td>
                    <td><%= disciplina.getQtAulas() %></td>
                    <td><%= disciplina.getP1() %></td>
                    <td><%= disciplina.getP2() %></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="nome" value="<%= disciplina.getNome() %>"/>
                            P1: <input type="text" name="p1"/>
                            P2: <input type="text" name="p2"/>
                            <input type="submit" name="update" value="Alterar"/>
                        </form>
                    </td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="nome" value="<%= disciplina.getNome() %>"/>
                            <input type="submit" name="delete" value="Excluir"/>
                        </form>
                    </td>
                </tr>
            <%}%>
        </table>
        
        <%}%>
    </body>
</html>
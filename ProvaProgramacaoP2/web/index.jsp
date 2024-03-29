<%-- 
    Document   : index
    Created on : 12 de jun. de 2021, 19:58:14
    Author     : MARCOSESTEVAODASILVA

(5 pontos) Deve haver uma página chamada “index.jsp” que inclua o jspf acima e que apresente:

(5 pontos) Um quadro com seu número de matrícula, nome completo, semestre em que ingressou na Fatec e o link de seu perfil no GitHub

(5 pontos) Um quadro com as médias das disciplinas na tabela que é solicitada nos requisitos abaixo
--%>

<%@page import="db.Disciplina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prova P2</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        
        <h1>Marcos Estevão da Silva Junior</h1>
        <h1>RA: 1290481913026</h1>
        <h1>Semestre que ingressei na FATEC: 01/2019</h1>
        <a href="https://github.com/MarcosEstevao">My profile</a>
        <hr/>
        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Dia da semana</th>
                <th>Horário</th>
                <th>Quantidade de aulas</th>
                <th>P1</th>
                <th>P2</th>
                <th>Média</th>
            </tr>
            <%for(Disciplina disciplina: Disciplina.getDisciplinas()){%>
                <tr>
                    <td><%= disciplina.getNome() %></td>
                    <td><%= disciplina.getDiaDaSemana() %></td>
                    <td><%= disciplina.getHorario() %></td>
                    <td><%= disciplina.getQtAulas() %></td>
                    <td><%= disciplina.getP1() %></td>
                    <td><%= disciplina.getP2() %></td>
                    <td>
                        <%= (disciplina.getP1() + disciplina.getP2()) / 2 %>
                    </td>
                </tr>
            <%}%>
        </table>
    </body>
</html>

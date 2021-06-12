/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

 */
package db;

import java.sql.*;
import java.util.ArrayList;
import web.DbListener;

/**
 *
 * @author rlarg
 * 
 * (10 pontos) Os dados da lista devem ser armazenados no banco de dados em uma tabela chamada disciplinas com campos para 
    nome, dia da semana, horário, quantidade de aulas, nota da p1 e nota da p2
 */
public class Disciplina {
    private String nome;
    private String diaDaSemana;
    private String horario;
    private int qtAulas;
    private Float p1;
    private Float p2;
    
    public static String getCreateStatement(){
        return "CREATE TABLE IF NOT EXISTS disciplinas("
                + "nm_disciplina VARCHAR(50) UNIQUE NOT NULL,"
                + "dd_semana VARCHAR(200) NOT NULL,"
                + "hr_aula varchar(20) NOT NULL,"
                + "qt_aulas int NOT NULL,"
                + "qt_p1 float"
                + "qt_p2 float"
                + ")";
    }
    
    public static ArrayList<Disciplina> getDisciplinas() throws Exception{
        ArrayList<Disciplina> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * from disciplinas");
        while(rs.next()){
            String nome = rs.getString("nm_disciplina");
            String diaDaSemana = rs.getString("dd_semana");
            String horario = rs.getString("hr_aula");
            int qtAulas = Integer.parseInt(rs.getString("qt_aulas"));
            Float p1 = Float.parseFloat(rs.getString("qt_p1"));
            Float p2 = Float.parseFloat(rs.getString("qt_p2"));
            list.add(new Disciplina(nome, diaDaSemana, horario, qtAulas, p1, p2));
        }
        stmt.close();
        con.close();
        return list;
    }
    
    public static Disciplina getDisciplina(String nome) throws Exception{
        Disciplina disciplina = null;
        Connection con = DbListener.getConnection();
        String sql = "SELECT * from disciplinas WHERE nm_disciplina = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nome);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String diaDaSemana = rs.getString("dd_semana");
            String horario = rs.getString("hr_aula");
            int qtAulas = Integer.parseInt(rs.getString("qt_aulas"));
            Float p1 = Float.parseFloat(rs.getString("qt_p1"));
            Float p2 = Float.parseFloat(rs.getString("qt_p2"));
            disciplina = new Disciplina(nome, diaDaSemana, horario, qtAulas, p1, p2);
        }
        stmt.close();
        con.close();
        return disciplina;
    }
    
    public static void insertDisciplina(String nome, String diaDaSemana, String horario, int qtAulas, Float p1, Float p2) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO disciplinas(nm_disciplina, dd_semana, hr_aula, qt_aulas, qt_p1, qt_p2) "
                + "VALUES(?,?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nome);
        stmt.setString(2, diaDaSemana);
        stmt.setString(3, horario);
        stmt.setInt(4, qtAulas);
        stmt.setFloat(5, p1);
        stmt.setFloat(6, p2);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void deleteDisciplina(String nome) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM disciplinas WHERE nm_disciplina = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nome);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void changePassword(String nome, Float p1, Float p2) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "UPDATE disciplinas SET qt_p1 = ?, qt_p2 = ? WHERE nm_disciplina = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setFloat(1, p1);
        stmt.setFloat(2, p2);
        stmt.setString(3, nome);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Disciplina(String nome, String diaDaSemana, String horario, int qtAulas, Float p1, Float p2) {
        this.nome = nome;
        this.diaDaSemana = diaDaSemana;
        this.horario = horario;
        this.qtAulas = qtAulas;
        this.p1 = p1;
        this.p2 = p2;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDiaDaSemana() {
        return diaDaSemana;
    }

    public void setDiaDaSemana(String diaDaSemana) {
        this.diaDaSemana = diaDaSemana;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public int getQtAulas() {
        return qtAulas;
    }

    public void setQtAulas(int qtAulas) {
        this.qtAulas = qtAulas;
    }

    public Float getP1() {
        return p1;
    }

    public void setP1(Float p1) {
        this.p1 = p1;
    }

    public Float getP2() {
        return p2;
    }

    public void setP2(Float p2) {
        this.p2 = p2;
    }

    
    
    
    
}
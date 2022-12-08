/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se.kth.iv1351.soundgood.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
/**
 *
 * @author fredr
 */
public class DAO {
    Connection conn;
    PreparedStatement showTableRows;
    ResultSet studentTable;
    public DAO() throws SQLException{
        try{
            this.conn = accessDB();
            //printAllStudents(conn);
            showTableRows = conn.prepareStatement("SELECT * FROM student");
            studentTable = showTableRows.executeQuery();

            while(studentTable.next()){
                System.out.println("name: " + studentTable.getString(3) + 
                        " address: " + studentTable.getString(4));
            }
        }catch(SQLException ex){
                ex.printStackTrace();
            }/*finally{
            studentTable.close();
        }*/
    }

    private Connection accessDB(){
        try{
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/final",
                                                     "postgres", "postgres");
            conn.setAutoCommit(false);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return conn;
    }
    private static void printAllStudents(Connection conn)throws SQLException{
        Statement stmt = conn.createStatement();
        ResultSet studentTable = stmt.executeQuery("SELECT * FROM student");
        while(studentTable.next()){
            System.out.println("name: " + studentTable.getString(3) + 
                    " address: " + studentTable.getString(4));
        }
    }
    private void printAllMetaData(Connection connection){
        try{
            DatabaseMetaData meta = connection.getMetaData();
            ResultSet tableData = meta.getTables(null, null, null, null);
            while(tableData.next()){
                String tableName = tableData.getString(3);
                System.out.println(tableName);
            }
        }catch (SQLException ex){
            ex.printStackTrace();
        }
    }
}

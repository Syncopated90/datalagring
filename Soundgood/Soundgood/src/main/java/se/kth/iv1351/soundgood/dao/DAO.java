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
    private Connection conn;
    private PreparedStatement showTableRows;
    private PreparedStatement showInstrumentsStmt;
    private PreparedStatement showRentalNumbers;
    private PreparedStatement makeRental;
    private PreparedStatement endRental;
    ResultSet studentTable;
    public DAO() throws SQLException{
        this.conn = accessDB();
        prepareStatements();
    }
    public void showInstruments(String instrument){
        PreparedStatement stmt = showInstrumentsStmt;
        ResultSet result = null;
        try{
            stmt.setString(1, instrument);
            result = stmt.executeQuery();
            if (!result.isBeforeFirst() ) {    
                System.out.println("No instrument available of that type"); 
} 
            while(result.next()){
                System.out.print(result.getString(1) + " " + instrument + " available");
                System.out.println(" for: " + result.getString(2) + " kr");
                System.out.println("Instrument id: " + result.getString(3));
            }
        }catch(SQLException err){
            err.printStackTrace();
            try{
                conn.rollback();
            }catch(SQLException rollbackErr){
                rollbackErr.printStackTrace();
            }
        }finally{
            try{
                if(result != null) result.close();
            }catch(SQLException err){
                err.printStackTrace();
            }
        }
    }
    public void rentInstrument(String instrumentID, int studentID){
        PreparedStatement stmt = makeRental;
        try{
            stmt.setString(1, instrumentID);
            stmt.setInt(2, studentID);
            stmt.executeUpdate();
            this.conn.commit();
        }catch(SQLException err){
            err.printStackTrace();
            try{
                conn.rollback();
            }catch(SQLException rollbackErr){
                rollbackErr.printStackTrace();
            }
        }
    }
    public void endRental(String instrumentID){
        PreparedStatement stmt = endRental;
        try{
            stmt.setString(1, instrumentID);
            stmt.executeUpdate();
            this.conn.commit();
        }catch(SQLException err){
            err.printStackTrace();
            try{
                conn.rollback();
            }catch(SQLException rollbackErr){
                rollbackErr.printStackTrace();
            }
        }
    }
    public Integer showNumberOfRentals(int studentID){
        PreparedStatement stmt = showRentalNumbers;
        ResultSet result = null;
        try{
            stmt.setInt(1, studentID);
            result = stmt.executeQuery();
            result.next();
            this.conn.commit();
            return Integer.parseInt(result.getString(1));
        }catch(SQLException err){
            err.printStackTrace();
            try{
                conn.rollback();
            }catch(SQLException rollbackErr){
                rollbackErr.printStackTrace();
            }
            
        }finally{
            try{
                if(result != null) result.close();
            }catch(SQLException err){
                err.printStackTrace();
            }
        }
        return null;
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
    private void prepareStatements(){
        try{
        showInstrumentsStmt = conn.prepareStatement("SELECT brand, price, instrument_id FROM instruments_for_rent "
            + "INNER JOIN instrument_price_list "
            + "ON instruments_for_rent.id = instrument_price_list.instruments_for_rent_id "
            + "WHERE instruments_for_rent.id NOT IN "
            + "(SELECT instruments_for_rent_id FROM rented_instrument WHERE end_date IS NULL) "
            + "AND instruments_for_rent.type = ? FOR UPDATE;");
        showRentalNumbers = conn.prepareStatement("SELECT COUNT(*) FROM rented_instrument WHERE student_id = ?;");
        makeRental = conn.prepareStatement("INSERT INTO rented_instrument (instruments_for_rent_id, "
                + "student_id, start_date, end_date ) "
                + "VALUES ((SELECT id FROM instruments_for_rent "
                + "WHERE instrument_id = ?), ?, current_date, null);");
        endRental = conn.prepareStatement("UPDATE rented_instrument SET end_date = current_date "
                + "WHERE instruments_for_rent_id = "
                + "(SELECT id FROM instruments_for_rent WHERE instrument_id = ?);");
        }catch(SQLException err){
            err.printStackTrace();
        }
    }
    private void printAllStudents(Connection conn)throws SQLException{
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
    private void test() throws SQLException{
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
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se.kth.iv1351.soundgood.controller;

import java.sql.SQLException;
import se.kth.iv1351.soundgood.dao.DAO;

/**
 *
 * @author fredr
 */
public class Controller {
    private DAO dao;
    public Controller(){
        try{
             this.dao = new DAO();
        }catch(SQLException sqle){
            sqle.printStackTrace();
        }
    }
    public void showInstruments(String instrument){
        dao.showInstruments(instrument);
    }
    public void showNumberOfRentals(int studentID){
        System.out.println("Number of instr rentals: " + dao.showNumberOfRentals(studentID));
    }
    public void rentInstrument(String instrumentID, int studentID){
        if(dao.showNumberOfRentals(studentID) < 2){
            dao.rentInstrument(instrumentID, studentID);
            System.out.println("Rental complete");
        }
        else
            System.out.println("That student is already renting max number of instruments");
    }
    public void endRental(String instrumentID){
        dao.endRental(instrumentID);
    }
}

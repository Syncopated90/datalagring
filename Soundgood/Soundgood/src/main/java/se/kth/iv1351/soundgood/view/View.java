/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se.kth.iv1351.soundgood.view;

import java.io.InputStreamReader;
import java.util.Scanner;
import se.kth.iv1351.soundgood.controller.Controller;

/**
 *
 * @author fredr
 */
public class View {
    private final Scanner scanner;
    private Controller controller;
    public View(Controller controller){
        this.controller = controller;
        this.scanner = new Scanner(System.in);
    }
    public void runRental(){
        System.out.println("StudentIDs go from 1 to 20");
        System.out.println("Drums, flutes, synthesizers, oboes and guitars are rented out by the school");
        System.out.println("Enter 'show <instrument>' to show available rental instruments");
        System.out.println("Enter 'rentals <studentID>' to show number of rentals for that student");
        System.out.println("Enter 'rent <instrumentID> <studentID>' to rent that instrument for the student");
        System.out.println("Enter 'end <instrumentID> to end the rental of the specified instrument");
        while(true){
            String command = scanner.nextLine();
            String[] commands = command.split(" ");
            try{
                if(commands[0].equals("show")){
                    controller.showInstruments(commands[1]);
                    continue;
                }
                else if(commands[0].equals("rentals")){
                    controller.showNumberOfRentals(Integer.parseInt(commands[1]));
                }
                else if(commands[0].equals("rent")){
                    controller.rentInstrument(commands[1], Integer.parseInt(commands[2]));
                }
                else if(commands[0].equals("end")){
                    controller.endRental(commands[1]);
                }
                else if(commands[0].equals("quit")){
                    return;
                }
            }catch (Exception err){//, Integer.parseInt(commands[2]))
                err.printStackTrace();
                break;
            }
        }
    }
}

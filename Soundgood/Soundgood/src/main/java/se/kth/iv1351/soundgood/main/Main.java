package se.kth.iv1351.soundgood.main;
import se.kth.iv1351.soundgood.controller.Controller;
import se.kth.iv1351.soundgood.view.View;
/**
 *
 * @author fredr
 */
public class Main{
    
    public static void main(String[] args) {
        new View(new Controller()).runRental();
    }
}

package se.kth.iv1351.soundgood.main;
import java.sql.SQLException;

import se.kth.iv1351.soundgood.dao.DAO;
/**
 *
 * @author fredr
 */
public class Main{
    
    public static void main(String[] args) {
        try{
            DAO dao = new DAO();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
    }
}

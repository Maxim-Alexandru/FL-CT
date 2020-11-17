import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;


public class FiniteAutomata {

    private String documentation = "";
    private ArrayList<String> alphabet = new ArrayList<>();
    private ArrayList<HashMap<HashMap<String, String>, String>> listOfTransitions = new ArrayList<>();
    private String initialState = "";
    private String[] finalStates = new String[0];
    private ArrayList<String> listOfStates = new ArrayList<>();

    public FiniteAutomata() {}

    public void readData() {
        BufferedReader reader;

        try {
            reader = new BufferedReader(new FileReader("src/FA.in.txt"));
            documentation = reader.readLine();
            documentation += "\n";
            for (int i=2;i<=10;i++) {
                documentation += reader.readLine();
                documentation += "\n";
            }

            initialState += reader.readLine();
            String finals = reader.readLine();
            finalStates  = finals.split(",");
            String states = reader.readLine();
            int position = 0;
            while (states.charAt(position) != 0) {

                HashMap<String, String> pair = new HashMap();
                pair.put(states.substring(position+1, position+3), states.substring(position+4, position+5));
                HashMap<HashMap<String, String>, String> transition = new HashMap<>();
                transition.put(pair, states.substring(position+7, position+9));

                listOfTransitions.add(transition);
                if (!listOfStates.contains(states.substring(position+1, position+3)))
                    listOfStates.add(states.substring(position+1, position+3));

                if (!alphabet.contains(states.substring(position+4, position+5)))
                    alphabet.add(states.substring(position+4, position+5));

                position += 9;
            }
            reader.close();
        }
        catch (Exception e) {}
    }

    public void printMenu() {
        System.out.println("1) List of states.");
        System.out.println("2) Alphabet.");
        System.out.println("3) Transitions.");
        System.out.println("4) Initial state.");
        System.out.println("5) Final state.");
        System.out.println("6) Documentation.");
        System.out.println("7) Verify if a string is a valid token.");
    }

    public boolean verifyString(String token) {

        String state = initialState.substring(2);
        for (int i=0; i<token.length(); i++) {
            HashMap<String, String> pair = new HashMap();
            pair.put(state, token.substring(i, i+1));
            for (int j=0; j<listOfStates.size(); j++) {
                HashMap<HashMap<String, String>, String> transition = new HashMap<>();
                transition.put(pair, listOfStates.get(j));
                System.out.println(transition);
                if (listOfTransitions.contains(transition))
                    state = listOfStates.get(j);
            }
        }
        for (String s: finalStates) {
            if (state.equals(s.substring(1)))
                return true;
        }
        return false;
    }


    public static void main(String[] args) {

        FiniteAutomata f = new FiniteAutomata();
        f.readData();
        f.printMenu();
        int option = -1;
        while (option != 0) {
            Scanner s = new Scanner(System.in);
            System.out.println("Select an option: ");
            option = s.nextInt();
            switch (option) {
                case 1: {
                    System.out.println(f.listOfStates);
                    break;
                }
                case 2: {
                    System.out.println(f.alphabet);
                    break;
                }
                case 3: {
                    System.out.println(f.listOfTransitions);
                    break;
                }
                case 4: {
                    System.out.println(f.initialState);
                    break;
                }
                case 5: {
                    for (String state: f.finalStates)
                        System.out.println(state + " ");
                    break;
                }
                case 6: {
                    System.out.println(f.documentation);
                    break;
                }
                case 7: {
                    String token = "";
                    System.out.println("Please enter the string you want to verify: ");
                    Scanner newScanner = new Scanner(System.in);
                    token = newScanner.nextLine();
                    System.out.println(f.verifyString(token));
                }
            }
        }

    }
}

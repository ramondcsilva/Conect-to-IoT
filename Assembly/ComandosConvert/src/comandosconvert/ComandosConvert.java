/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comandosconvert;

import java.io.*;
/**
 * @author Alan Bruno
 */
public class ComandosConvert {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            File fileDir = new File("entrada.txt");
            OutputStreamWriter gravarArq = new OutputStreamWriter(
                    new FileOutputStream("saida.txt"), "UTF-8");
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                            new FileInputStream(fileDir), "UTF8"));
            String str;

            while ((str = in.readLine()) != null) {
                String comando = str;
                for (int i = 0; i < comando.length(); i++) {
                    char character = comando.charAt(i); // This gives the character 'a'
                    int ascii = (int) character;
                    gravarArq.write("movi r5," + ascii + " #" + character);
                    gravarArq.write("\n");
                    gravarArq.write("call sendChar");
                    gravarArq.write("\n");
                    gravarArq.write("call delay");
                    gravarArq.write("\n");
                }
                gravarArq.write("movi r5," + 13 + " #\\r");
                gravarArq.write("\n");
                gravarArq.write("call sendChar");
                gravarArq.write("\n");
                gravarArq.write("call delay");
                gravarArq.write("\n");
                gravarArq.write("movi r5," + 10 + " #\\n");
                gravarArq.write("\n");
                gravarArq.write("call sendChar");
                gravarArq.write("\n");
                gravarArq.write("call delay");
                gravarArq.write("\n");
                gravarArq.write("\n");
                gravarArq.write("\n");
            }
            in.close();
             gravarArq.close();
        } catch (UnsupportedEncodingException e) {
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}

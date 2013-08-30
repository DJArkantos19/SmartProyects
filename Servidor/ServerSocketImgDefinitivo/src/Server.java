
/*
 * Servidor.java
 *
 * Author: Antony Delgado
 * Created: 31 de Agosto de 2006 
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server implements Runnable {
	ServerSocket server;
	public Server() {
		try {
			//CREAMOS EL SOCKET DEL SERVIDOR
			server=new ServerSocket(9000);
			System.out.println("Servidor corriendo...");
		} catch(Exception e) {
			System.out.println("Error al correr el servidor\n"+e);
			System.exit(1);
		}
	}

	public void run() {
		Socket client=null;
		while (true) {
			if (server==null)
				return;
			try {
				//ESPERA A QUE LLEGUE UN CLIENTE
				client=server.accept();
				System.out.println("Llegó un cliente!");
			} catch(java.io.IOException e) {
				System.err.println("No se pudo establecer conexión " + e.getMessage());
			}
			try {
				//ABRIMOS UN BUFER PARA DESCARGAR LO QUE EL CLIENTE NOS ESTÁ ENVIANDO
				InputStream in = client.getInputStream();
				//CREAMOS LA INSTANCIA PARA ESCRIBIR EL ARCHIVO EN DISCO
				FileOutputStream out = new FileOutputStream(new File("D://imagenWilcho.jpg"));
				byte[] buf = new byte[1024];
				int len;

				while ((len = in.read(buf)) > 0) {
						out.write(buf, 0, len);					
				}
				
				in.close();
				out.close();
			} catch(java.io.IOException e) {
				System.out.println("Error: " + e);
			}
		}
	}

	public static void main(String a[]) {
		Server servidor = new Server();
		// Ponemos a correr nuestro hilo servidor
		new Thread(servidor).start();
	}
}

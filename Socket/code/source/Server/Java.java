package Server;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
// --- <<IS-END-IMPORTS>> ---

public final class Java

{
	// ---( internal utility methods )---

	final static Java _instance = new Java();

	static Java _newInstance() { return new Java(); }

	static Java _cast(Object o) { return (Java)o; }

	// ---( server methods )---




	public static final void ServerSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(ServerSocket)>> ---
		// @sigtype java 3.5
		// [o] field:0:required Message
		try(ServerSocket serverSocket = new ServerSocket(12866)){
		    while(true) {
		        // \uC694\uCCAD\uC774 \uB4E4\uC5B4\uC62C\uB54C\uAE4C\uC9C0 \uB300\uAE30, \uD074\uB77C\uC774\uC5B8\uD2B8\uC758 \uC5F0\uACB0\uC694\uCCAD\uC774 \uB4E4\uC5B4\uC624\uBA74 \uD074\uB77C\uC774\uC5B8\uD2B8\uC18C\uCF13\uACFC \uD1B5\uC2E0\uD560 \uC18C\uCF13\uC744 \uBC18\uD658
		        Socket socket = serverSocket.accept(); 
		       
		        // \uCD9C\uB825\uC2A4\uD2B8\uB9BC 
		        OutputStream out = socket.getOutputStream();
		        DataOutputStream dos = new DataOutputStream(out);
		        IDataCursor pipelineCursor = pipeline.getCursor();
		        byte[] data="send Data".getBytes();
		        out.write(data, 0, data.length);
			     IDataUtil.put( pipelineCursor, "Message", "ServerSocket Open");
			     
			     pipelineCursor.destroy();
		        dos.close();
		        socket.close();
		        serverSocket.close();
		     // pipeline
		
		
		    
		
		    }
		}catch(IOException e) {
			IDataCursor pipelineCursor = pipeline.getCursor();
			 IDataUtil.put( pipelineCursor, "Message",e.toString());
			 pipelineCursor.destroy();
		
		}
			
		// --- <<IS-END>> ---

                
	}
}


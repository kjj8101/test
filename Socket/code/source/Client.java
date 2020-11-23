

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.g11n.ui.DEBUG;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
// --- <<IS-END-IMPORTS>> ---

public final class Client

{
	// ---( internal utility methods )---

	final static Client _instance = new Client();

	static Client _newInstance() { return new Client(); }

	static Client _cast(Object o) { return (Client)o; }

	// ---( server methods )---




	public static final void ClientSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(ClientSocket)>> ---
		// @sigtype java 3.5
		// [o] field:0:required Message
 String serverIp = "127.0.0.1";
    try(Socket socket = new Socket(serverIp, 12866)){
        
        // \uC785\uB825\uC2A4\uD2B8\uB9BC 
        InputStream in = socket.getInputStream();
        DataInputStream dis = new DataInputStream(in);
        byte[] data=new byte[100];
        in.read(data,0,100);
        // \uB370\uC774\uD130 \uCD9C\uB825 
   	 IDataCursor pipelineCursor = pipeline.getCursor();
	 IDataUtil.put( pipelineCursor, "Message", "Client\uC5F0\uACB0\uC131\uACF5" );
	 pipelineCursor.destroy();
     dis.close();
     in.close();
     socket.close();
    }catch(IOException e) {
    	IDataCursor pipelineCursor = pipeline.getCursor();
		 IDataUtil.put( pipelineCursor, "Message",e.toString());
		 pipelineCursor.destroy();
    }

 // pipeline

 // pipeline

	
		// --- <<IS-END>> ---

                
	}
}


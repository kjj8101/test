package Util;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class Java

{
	// ---( internal utility methods )---

	final static Java _instance = new Java();

	static Java _newInstance() { return new Java(); }

	static Java _cast(Object o) { return (Java)o; }

	// ---( server methods )---




	public static final void PortScann (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(PortScann)>> ---
		// @sigtype java 3.5
		boolean availablePort(String host, int port) 
		{
		boolean result = false;
		 
		try {
		    (new Socket(host, port)).close();
		 
		    result = true;
		}
		catch(Exception e) {
		    
		}
		    return result;
		}
		 
		// \uD3EC\uD2B8\uAC00 \uC5F4\uB838\uB294\uC9C0 \uD655\uC778\uD560 IP \uC8FC\uC18C\uC640 \uD3EC\uD2B8
		boolean portCheck = availablePort("192.168.2.100",6000);
		 
		if(portCheck)
		{
		    System.out.println("port available");
		}
		else
		{
		    System.out.println("port unavailable");
		} 
		// --- <<IS-END>> ---

                
	}
}


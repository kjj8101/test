package Default;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.JavaService;
import com.wm.app.b2b.server.ServerAPI;
import com.wm.lang.ns.NSName;
import com.wm.app.b2b.server.ns.Namespace;
// --- <<IS-END-IMPORTS>> ---

public final class hack

{
	// ---( internal utility methods )---

	final static hack _instance = new hack();

	static hack _newInstance() { return new hack(); }

	static hack _cast(Object o) { return (hack)o; }

	// ---( server methods )---




	public static final void get (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(get)>> ---
		// @sigtype java 3.5
		IDataCursor idc = pipeline.getCursor();
		IDataUtil.put(idc, "list", Namespace.current().getNodeList());
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required nsname
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	nsname = IDataUtil.getString( pipelineCursor, "nsname" );
		pipelineCursor.destroy();
		
		Object nodeDef = Namespace.current().getService(NSName.create(nsname));
		JavaService javaSvc = (JavaService)nodeDef;
		
		
		pipelineCursor = pipeline.getCursor();
		IDataUtil.put(pipelineCursor, "defType", nodeDef.getClass().getCanonicalName());
		IDataUtil.put(pipelineCursor, "nodeValues", javaSvc.getNodeValues()); 
		IDataUtil.put(pipelineCursor, "def", nodeDef); 
		
		pipelineCursor.destroy();
			
		// --- <<IS-END>> ---

                
	}
}


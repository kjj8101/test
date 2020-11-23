

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
// --- <<IS-END-IMPORTS>> ---

public final class Java

{
	// ---( internal utility methods )---

	final static Java _instance = new Java();

	static Java _newInstance() { return new Java(); }

	static Java _cast(Object o) { return (Java)o; }

	// ---( server methods )---




	public static final void closefile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closefile)>> ---
		// @sigtype java 3.5
		// [i] object:0:required Stream
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			Object	Stream = IDataUtil.get( pipelineCursor, "Stream" );
		pipelineCursor.destroy();
		if(Stream instanceof FileInputStream){
			FileInputStream f = (FileInputStream)Stream;
			try {
				f.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// pipeline
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void openfile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(openfile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required url
		// [o] object:0:required stream
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	url = IDataUtil.getString( pipelineCursor, "url" );
		pipelineCursor.destroy();
		FileInputStream f=null;
		
		try {
			f = new FileInputStream(url);
		
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		Object stream = new Object();
		IDataUtil.put( pipelineCursor_1, "stream", f );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void parseJSON (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(parseJSON)>> ---
		// @sigtype java 3.5
		// [i] field:0:required Str
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	Str = IDataUtil.getString( pipelineCursor, "Str" );
		pipelineCursor.destroy();
		
		// pipeline
		
		
		File file = new File("C:\\oracle\\hello.json");
		
		try {
		  FileWriter fw = new FileWriter(file);
		  fw.write(Str);
		  fw.close();
		} catch (IOException e) {
		  e.printStackTrace();
		}
			
		// --- <<IS-END>> ---

                
	}
}


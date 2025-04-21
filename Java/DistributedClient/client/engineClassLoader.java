// ////////////////////////////////////////////////////////////////////////
// //                                                                    //
// //  Aurthor     :  ...                                                //
// //                                                                    //
// //  Email       :  ...                                                //
// //                                                                    //
// //  Web address :  ...                                                //
// //                                                                    //
// //  Date        :  June 2000 - May 2001                               //
// //                                                                    //
// //  This Release:  Resolved a java.lang.LinkageError error.           //
// //                                                                    //
// ////////////////////////////////////////////////////////////////////////

import java.util.*;
import java.io.*;

public class engineClassLoader extends ClassLoader {

	public engineClassLoader() {
	}

	public synchronized Class loadClass(String name,boolean t) {
		// This method is called by the virtual machine to resolve
		//  the dynamically created class.
		Class ct = null;

		try {
			ct = Class.forName(name);

			if (t) {
				super.resolveClass(ct);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("loadClass(String,boolean) ClassNotFoundException : " + e.getMessage());
		}

                  return ct;
	}

	public synchronized Class loadClass(String name) {
		FileInputStream fstream;
		DataInputStream d;
                byte b[] = null;
		Class c = null;

		File f = new File(name +".class");

		// Compress the file into a byte array
		try {
			fstream = new FileInputStream( name +".class" );
			d = new DataInputStream( fstream );
			b = new byte[(int)f.length()];
			d.read(b,0,(int)f.length());

			d.close();
		} catch (IOException e) {
			System.out.println("loadClass(String) IOException : " + e.getMessage());
		}

		// If the class was read from the file
		if (b != null) {
			try {
				c = defineClass(name,b, 0, b.length);

				// resolve the class
				super.resolveClass(c);
			} 
			catch (ClassFormatError x) {
				System.out.println("loadClass(String) ClassFormatError : "+x.getMessage());
			}
			catch (LinkageError x) {
				// This error indicates that this class is already defined
			}
		}

		return c;
	}
}


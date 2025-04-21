// //////////////////////////////////////////////////////////////////////// //
// // ...                                                                // //
// //                                                                    // //
// // November 29, 2000                                                  // //
// //                                                                    // //
// // Purpose:  Generate prime numbers                                   // //
// //                                                                    // //
// // Input: file contains 3 doubles                                     // //
// //          1. increment value                                        // //
// //          2. starting value                                         // //
// //          3. ending value                                           // //
// //                                                                    // //
// // Output: file containing prime doubles                              // //
// //                                                                    // //
// //////////////////////////////////////////////////////////////////////// //

import java.io.*;
import java.lang.Math;

class engine extends Thread {
        private String fileIn = null;
        private String fileOut = null;
        private Client clnt;
	private boolean invalidInput = false;
	private int interalCounter=0;

        public engine (String fileIn, String fileOut, Client clnt) {
                this.fileIn = fileIn;
                this.fileOut = fileOut;
                this.clnt = clnt;
        }

        public synchronized void run() {
		FileInputStream fstream;
		BufferedReader d;
		PrintWriter out;
		double numToProcess=0,start=0,end=0;

		// Read in file input
		try {
			fstream = new FileInputStream(fileIn);
			d = new BufferedReader(new InputStreamReader(fstream));

			try {
				 numToProcess=new Double(d.readLine()).doubleValue();
				 start=new Double(d.readLine()).doubleValue();
				 end=new Double(d.readLine()).doubleValue();

				// Number of doubles can be halved because even
				//  numbers can not be prime.
				numToProcess = numToProcess / 2;

			} catch (NumberFormatException x) {
				invalidInput = true;
			}


			d.close();
		} catch (IOException x) {
			invalidInput = true;
		}

		// Open output file and start processing
		try {
			out=new PrintWriter(new BufferedWriter(new FileWriter( fileOut)));

			if(!invalidInput) {
				// Start one at a time and check if the number
				//  is prime.

				for(double j=start; j<end; j+=2) { 
					if (isPrime(j)) {
						out.println(j);
					}

					// So as not to call the main thread
					//  every time.
					// REALLY it is (100/2) == (50)
					if (interalCounter-- == 0) {
						clnt.percentCompleted((int)(((j-start)*50)/numToProcess));
						interalCounter=100;
					}
				}
			} else {
				out.println("Data was corrupted... ");
				out.println("... No prime numbers processed!");
			}

			out.close();
		} catch (IOException x) {
		}

                // Must be set to 100%
                clnt.percentCompleted(100);
        }

	private boolean isPrime(double d) {
		boolean prime = true;
		double start = Math.sqrt(d);

		// Make sure it is a Whole ODD double	
		start = Math.ceil(start);
		if ((start % 2) == 0) { start++; }

		for (double i=start; i>=3; i-=2)
			if ((d % i) == 0) {
				prime = false;
				break;
			}
		
		return prime;
	}
}

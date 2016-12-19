package bonanno_prog1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;



public class Driver{
	
	
	//helper function to calc log base 2
	public static double calcLog2(double n){
		
		double retVal = Math.log10(n) / Math.log10(2.0);
		//System.out.println(retVal);
		return retVal;
	}
	
	//calculates the infoGain
	public static double calcGain(int totalNodes, int yesNodes, int x1y1, int x1y2, int x2y1, int x2y2){
		double infoGain = 0;
		int noNodes = totalNodes - yesNodes;
		double totalX1 = x1y1 + x1y2;
		double totalX2 = x2y1 + x2y2;
		double term1 = x1y1 / totalX1; //y1 = PlayTennis = yes
		double term3 = x2y1 / totalX2; //y2 = PlayTennis = no
		double term2 = x1y2 / totalX1; //x1 = Label = pos
		double term4 = x2y2 / totalX2; //x2 = Label = neg
		double probA = (double)totalX1 / totalNodes;
		double probB = (double)totalX2 / totalNodes;
		
		double probPos = (double)yesNodes / totalNodes;
		double probNeg = (double)noNodes / totalNodes;
		
		double entropy = - probPos * calcLog2(probPos) - probNeg * calcLog2(probNeg);
		double condEntropy = -probA  * (term1 * calcLog2(term1) + term2 * calcLog2(term2)) +
				-probB * (term3 * calcLog2(term3) + term4 * calcLog2(term4));
		infoGain = entropy - condEntropy;
		return infoGain;
	}
	
	//returns probability of playTennis given positive label x1
	public static double calcNBC(int totalNodes, int yesNodes, int x1y1, int x1y2, int x2y1, int x2y2){
		double retVal = 0.0;
		//double totalX1 = x1y1 + x1y2;
		//double totalX2 = x2y1 + x2y2;
		//double probX = (double)totalX1 / totalNodes;
		//double probPos = (double)yesNodes / totalNodes;
		double probXGivenYes = (double)x1y1 / yesNodes;
		retVal = probXGivenYes;
		return retVal;
	}
	
	public static void main(String[] args) throws IOException{
		
		String inputPath = null;
		try {
			inputPath = args[0];
		}
		catch (ArrayIndexOutOfBoundsException e){
			System.err.println("Could not find specified input file");
			System.exit(0);
		}
		URL inputUrl = Driver.class.getClassLoader().getResource(inputPath);
		FileReader input = null;
		BufferedReader buffer = null;
		ArrayList<Node> trainingData = new ArrayList<Node>();
		
		try {
			input = new FileReader(inputUrl.getPath());
			buffer = new BufferedReader(input);
			String thisLine;
			thisLine = buffer.readLine();
			while(thisLine != null){
				int[] tempArray = new int[4];
				boolean tempPlay = false;
				String[] tokens = thisLine.split("\\s+");
				
				if (tokens[1].equals("sunny") || tokens[1].equals("Sunny"))
					tempArray[0] = 1;
				else if (tokens[1].equals("overcast") || tokens[1].equals("Overcast"))
					tempArray[0] = 2;
				else
					tempArray[0] = 3;
				if (tokens[2].equals("hot") || tokens[2].equals("Hot"))
					tempArray[1]  = 1;
				else if (tokens[2].equals("mild") || tokens[2].equals("Mild"))
					tempArray[1]  = 2;
				else
					tempArray[1] = 3;
				if (tokens[3].equals("high") || tokens[3].equals("High"))
					tempArray[2]  = 1;
				else
					tempArray[2] = 2;
				if (tokens[4].equals("strong") || tokens[4].equals("Strong"))
					tempArray[3]  = 1;
				else
					tempArray[3] = 2;	
				if (tokens[5].equals("yes") || tokens[5].equals("Yes")){
					tempPlay = true;
				}
				//parse input file write values to tempArray and tempPlay
				//send values to construct a new Node
				//add the new Node to the trainingData arraylist
				Node tempNode = new Node(tempArray[0],tempArray[1], tempArray[2],tempArray[3], tempPlay);
				trainingData.add(tempNode);
				thisLine = buffer.readLine();
			}
			
		}
		catch (FileNotFoundException e){
			System.err.println(e.getMessage());
			System.exit(0);
		}
		catch (IOException e) {
			System.err.println(e.getMessage());
			System.exit(0);
		}
		catch (NullPointerException e){
			System.err.println("Specified input file not found");
			System.exit(0);
		}
		
		finally{
			if (input != null) {
				input.close();
			}
			if (buffer != null){
				buffer.close();
			}
		}
		double infoWind, infoHumid, infoTemp, infoOutlook;
		double nbcWind, nbcHumid, nbcTemp, nbcOutlook;
		int totalNumNodes = trainingData.size();
		int yesNodes = 0;
		//considering wind
		int labelYesPlayYes = 0; 
		int labelYesPlayNo = 0; 
		int labelNoPlayYes = 0; 
		int labelNoPlayNo = 0;
		for (Node d: trainingData) {
			//System.out.println(d);
			if (d.getPlay()){
				yesNodes++;
				if (d.getWind() == 1)
					labelYesPlayYes++;
				else
					labelNoPlayYes++;
			}	
			else {
				if (d.getWind() == 1)
					labelYesPlayNo++;
				else
					labelNoPlayNo++;
			}
		}
		
		//call function for info gain for wind
		nbcWind = calcNBC(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		infoWind = calcGain(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		System.out.println("Info gain for wind(strong vs weak):\t" + infoWind);
		//considering humidity
		labelYesPlayYes = 0; 
		labelYesPlayNo = 0; 
		labelNoPlayYes = 0; 
		labelNoPlayNo = 0;
		for (Node d: trainingData) {
			if (d.getPlay()){
				if (d.getHumidity() == 1)
					labelYesPlayYes++;
				else
					labelNoPlayYes++;
			}	
			else {
				if (d.getHumidity() == 1)
					labelYesPlayNo++;
				else
					labelNoPlayNo++;
			}
		}
		//call function for info gain for humidity
		nbcHumid = calcNBC(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		infoHumid = calcGain(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		
		System.out.println("Info gain for humidity(high vs normal):\t" + infoHumid);
		//considering temp
		labelYesPlayYes = 0; 
		labelYesPlayNo = 0; 
		labelNoPlayYes = 0; 
		labelNoPlayNo = 0;
		for (Node d: trainingData) {
			if (d.getPlay()){
				if (d.getTemp() == 1)
					labelYesPlayYes++;
				else
					labelNoPlayYes++;
			}	
			else {
				if (d.getTemp() == 1)
					labelYesPlayNo++;
				else
					labelNoPlayNo++;
			}
		}
		//call function for info gain for temp
		nbcTemp = calcNBC(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		infoTemp = calcGain(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		System.out.println("Info gain for temp(hot vs not hot):\t" + infoTemp);
		//considering outlook
		labelYesPlayYes = 0; 
		labelYesPlayNo = 0; 
		labelNoPlayYes = 0; 
		labelNoPlayNo = 0;
		for (Node d: trainingData) {
			if (d.getPlay()){
				if (d.getOutlook() == 1)
					labelYesPlayYes++;
				else
					labelNoPlayYes++;
			}	
			else {
				if (d.getOutlook() == 1)
					labelYesPlayNo++;
				else
					labelNoPlayNo++;
			}
		}
		//call infogain for outlook
		nbcOutlook = calcNBC(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		infoOutlook = calcGain(totalNumNodes, yesNodes, labelYesPlayYes, labelYesPlayNo, labelNoPlayYes, labelNoPlayNo);
		System.out.println("Info gain for outlook(sunny vs not sunny):\t" + infoOutlook);
		//results
		double maxArray[] = new double[4];
		maxArray[0] = infoWind;
		maxArray[1] = infoHumid;
		maxArray[2] = infoTemp;
		maxArray[3] = infoOutlook;
		double bestChoice = 0.0;
		int bestIndex = -1;
		for (int i = 0; i < maxArray.length; i++){
			if (maxArray[i] >= bestChoice){
				bestChoice = maxArray[1];
				bestIndex = i;
			}	
		}
		
		System.out.print("The best feature for the split is: ");
		if (bestIndex == 0)
			System.out.println("Wind");
		else if (bestIndex == 1)
			System.out.println("Humidity");
		else if (bestIndex == 2)
			System.out.println("Temperature");
		else if (bestIndex == 3)
			System.out.println("Outlook");
		else
			System.out.println("unknown");
		
		//System.out.println(nbcWind);
		//System.out.println(nbcHumid);
		//System.out.println(nbcTemp);
		//System.out.println(nbcOutlook);
		double probYes = 0;
		double probNo = 0;
		double probPlay = (double)yesNodes / totalNumNodes;
		probYes = probPlay * (1 - nbcOutlook) * (1 - nbcTemp) 
				* nbcHumid * nbcWind;
		probNo = (1 - probPlay) * nbcOutlook * nbcTemp * 
				(1 - nbcHumid) * (1 -  nbcWind);
		//System.out.println(probYes);
		//System.out.println(probNo);
		if (probYes > probNo){
			System.out.println("Given outlook = rain, temp = cool, humidity = high"
					+ " wind = strong, the prediction is that we WILL play tennis.");
		}
		else
			System.out.println("Given outlook = rain, temp = cool, humidity = high"
					+ " wind = strong, the prediction is that we WILL NOT play tennis.");
			
		
	}
	
	
}
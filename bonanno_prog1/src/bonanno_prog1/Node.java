package bonanno_prog1;

public class Node{
	private int outlook; //1 = sunny 2 = overcast 3 = rain
	private int temperature; //1 = hot 2 = mild 3 = cool
	private int humidity; //1 = high 2 = normal
	private int wind; //1 = strong 2 = weak
	private boolean playTennis;
	
	public Node(int newOutlook, int newTemp, int newHumid, int newWind, boolean newPlay){
		this.outlook = newOutlook;
		this.temperature = newTemp;
		this.humidity = newHumid;
		this.wind = newWind;
		this.playTennis = newPlay;
		
	}
	
	public int getOutlook(){
		return outlook;
	}
	
	public int getTemp(){
		return temperature;
	}
	
	public int getHumidity(){
		return humidity;
	}
	
	public int getWind(){
		return wind;
	}
	
	public boolean getPlay(){
		return playTennis;
	}
	
	public String toString() {
		return "Object data:" + outlook + temperature + humidity + wind + playTennis;
	}
}
package mybatis;

import java.util.ArrayList;

public interface ArtMapImpl {
	
	public ArrayList<ArtistDTO> searchRadius(int distance, double latTxt, double lngTxt);

}

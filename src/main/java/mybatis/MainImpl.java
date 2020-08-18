package mybatis;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import org.springframework.stereotype.Service;

@Service
public interface MainImpl {
	
	//메인페이지 
	public ArrayList<MainDTO> mainList(ParameterDTO parameterDTO);
	public ArrayList<MainDTO> mainListRental(ParameterDTO parameterDTO);
	public ArrayList<MainDTO> mainListComing(ParameterDTO parameterDTO);
	public int getMinPrice(int auctionId);
	
	
}
